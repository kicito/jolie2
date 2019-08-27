import IConsoleInput from Console // import some symbol from Console.ol
import Console from Console

service Main( params:T ) { // name of the service must be the same as the name of the enclosing file
	embed Console { // embed whatever service is defined in Console.ol
		bindOut: IP -> Console // , IP2 -> OP2, etc.
		bindIn: Pippo {
			location
		}
		// params: etc // here we could pass on some parameters
	}

	outputPort Pippo2 {
		protocol: http {
			debug = params.debug
		}
		interfaces: PippoI
	}

	// Convenient alternative form for the above that can be 
	// embed Console

	inputPort ConsoleInput {
		location: "local"
		interfaces: IConsoleInput
	}

	main {
		registerForInput@Console()()
		in(x)
		println@Console("Hello, World!")()
	}
}
