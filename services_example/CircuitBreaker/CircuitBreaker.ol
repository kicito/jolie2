

// assume TimerService available

constants {
    RESET_TIME=10000,
    TIMEOUT=10000,
    ERROR_THRESHOLD=5,
    OPEN="Open",
    HALFOPEN="HalfOpen",
    CLOSE="Close"
}

// interface for comunication client and Circuit breaker
interface CircuitGateWayIface{
    oneWay: resetTimeout(void)
}

// extender for CircuitBreaker mechanisim
interface extender CBExtender {
RequestResponse:
    *( void )( void ) throws CBFault
}

type CircuitBreakerParams:void{
    // serviceIface accepts interface of service target for CircuitBreaker
    serviceIface: interface,
    // serviceFwdTo defines location, protocol of service's target
    serviceFwdTo: inputPort:{location: string, protocol: string},
    // circuitGateWay port used for communication between client and Circuit breaker
    circuitGateWay: inputPort{ interfaces: CircuitGateWayIface }
}

decl service CiruitBreaker(CiruitBreakerParams p){

    // an OutputPort for communication between service and CircultBreaker
    outputPort circuitFwdTo(p.serviceFwdTo){interfaces: p.serviceIface}

    // an InputPort for communication between client and CircultBreaker, extends circuitFwdTo with CBExtender
    inputPort circuitRecv(p.serviceFwdTo){Aggregates: circuitFwdTo with CBExtender}

    inputPort circuitGateWay(p.circuitGateWay){
        // default location
        // default protocol
    }

    define trip { state = Open ; resetTimer }

    define resetTimer {
        scheduleTimeout@Time( RESET_TIME{ .operation="resetTimeout" } )(  )// call TimerService 
    }

    define startCallTimer {
        scheduleTimeout@Time( TIMEOUT{ .operation="callTimeout" } )( global.callTimeoutID )// call TimerService 
    }

    define cancelCallTimer {
        scheduleTimeout@Time( global.callTimeoutID )( )// call TimerService 
    }
    
    define resetErrorCount{
        global.errorCount = 0
    }

    define addErrorCount{
        global.errorCount++
    }

    define shouldTrip{
        if (
            global.errorCount > ERROR_THRESHOLD && 
            (state == HalfOpen || state == CLOSE)
        ){
            trip
        }
    }

    define forwardMsg {
        callTimer;
        install (
            default = >
            cancelCallTimer ; addErrorCount;
            checkErrorRate
        );
        forward ( request )( response );
        resetErrorCount; // reset when success
        cancelCallTimer
    }

    define checkErrorRate {
        if ( state == Closed ) {
            addErrorCount
            tripIfExceedThreshold
        }
        if ( state == HalfOpen ){
            trip
        }
    }

    // a courier for interception of communication
    courier circuitFwdTo {
        [ interface p.serviceIface( request )( response ) ] { // p.serviceIface is defined from embedder through params
            if ( state == Open ) throw ( CBFault )
            else forwardMsg
        }
    }

    main{
        [ callTimeout () ] {
            addErrorCount;
            checkErrorRate;
            throw CBFault
        }
        [ resetTimeout () ] {
            if ( state == Open ){ 
                resetErrorCount;
                state = HalfOpen 
            }
        }
    }
}