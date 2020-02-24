import Console, IConsole, IReceiver from "./Console.ol"

decl service client( ){

	embed Console ( {
        i = "Console", // this create local binding output port (only valid for param type InputPort) by using default value of ConsoleServiceParam
        o << {
            location: "local://ConsoleInput"
            interfaces: IReceiver
        } 
        // or o = undefined
    } )

	inputPort ConsoleInput {
		location: "local://ConsoleInput"
		interfaces: IReceiver
	}

    main{
        println@Console("Printer receive: " + req)()
    }
}