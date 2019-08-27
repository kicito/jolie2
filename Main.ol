import IConsole from Console // import some symbol from module Console. This searches all public symbols in all files in that module.
import Console from Console // This imports the service definition Console in module Console.

/*
 * A jolie file can contain multiple service definitions.
 * When launched from the command line, the service with the same name as the file is launched.
 * So, for example, jolie Main.ol would instantiate and launch service Main.
 */

// This is an auxiliary service definition. It can be embedded by users of this module, or by this module itself.
service SomeService {
	/* etc. */
}

type MainParams {
	prefix:string
}

/*
Services can have parameters. The user decides how they are called. There is at most one parameter, and it's always a tree.
*/
service Main ( params:MainParams ) { // name of the service must be the same as the name of the enclosing file
	embed Console { // embed whatever service is defined in Console.ol
		// This binds the input ports of Console to output ports here.
		// If an output port does not exist, like Console here, it is automatically created.
		bindIn: IP -> Console // , IP2 -> OP2, etc.

		// This binds the output ports of Console to either some input port or literal binding information, see below.

		// Example of bindOut with literal binding information
		bindOut: Receiver {
			location: "local:/MyConsoleInput"
		}

		// Example of bindOut with direct binding to an existing input port
		/*
		bindOut: Receiver -> ConsoleInput
		*/

		// Here bindOut only mentions the port Receiver but does not really bind it, so Receiver becomes an output port of the embedder which the user must now configure!
		// bindOut: Receiver

		// One can also pass parameters to the embedded service
		// params: etc // here we could pass on some parameters
	}
	// TODO: update also loadEmbeddedService@Runtime to reflect the structure above

	/*
	outputPort Pippo2 {
		protocol: http {
			debug = params.debug
		}
		interfaces: PippoI
	}
	*/

	/*
	*/
	// embed Console

	/* It might be bothersome to have to create an input port all the time whenever we embed Console, since operation in is used only sometimes... split Console into two modules? Let's check how it's called in javascript */
	inputPort ConsoleInput {
		location: "local:/MyConsoleInput"
		interfaces: IConsole
	}

	main {
		registerForInput@Console()()
		in(x)
		println@Console( params.prefix + "Hello, World!" )() // Example of parameter use
	}
}
