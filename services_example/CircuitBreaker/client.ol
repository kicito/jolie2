from "CalculatorService.ol" import 
    CalculatorIface,
    CalculatorService 
from "CircuitBreaker.ol" import CiruitBreaker,CircuitGateWayIface
decl service client{

    // embedding a service, but it will not be communicate directly with this service (client service)
    embed CalculatorService ({ 
        i << { 
            location = "socket://localhost:3000" 
            protocol = sodep 
            interfaces = CalculatorIface
        }
    })

    // embedding a CiruitBreaker passing information of service. notice the passing interface and port, 
    // it should be identical to service declare above 
    embed CiruitBreaker({
        serviceIface = CalculatorIface,
        serviceFwdTo << { 
            location = "socket://localhost:3000" 
            protocol = sodep 
        },
        circuitGateWay << { // an information for client to communicate with circuit breaker
            location: "socket://localhost:3001"
            protocol: sodep
            interfaces: CalculatorService, CircuitGateWayIface 
        }
    })

    // an outputPort to communicate with circuit breaker
    outputPort OP {
        location: "socket://localhost:3001"
        protocol: sodep
        interfaces: CalculatorService, CircuitGateWayIface
    }

    main {
        // sum@OP({x=1, y=2})(res)
    }
}