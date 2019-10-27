import Time from "Time"

service Main ( params:MainParams ) {
    embed Time (){
        bindIn: IP -> Time
		bindOut: Receiver {
			location: "local:/ExtendedTimer"
		}
    }

    /* It might be bothersome to have to create an input port all the time whenever we embed Console, since operation in is used only sometimes... split Console into two modules? Let's check how it's called in javascript */
	inputPort TimerInput {
		location: "local:/ExtendedTimer"
		interfaces: Time.Reciver.interface
	}

	main {
        nextXMins@time(1)(timerID); // set timeout to next 1 min
        timeout()
	}
}