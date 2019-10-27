import SEResultInterface, SEInterface from "SearchEngine"
// importing Console is omitted

service Main ( params:MainParams ) { 
    embed SearchEngine{ }

	outputPort ClientToSE {
		Location: "local:/searchEngineInput" // lib author set static location.
		Interfaces: SEInterface
	}

	inputPort SEToClient {
		Location: "local:/searchEngineOutput" // lib author set static location.
		Interfaces: SEResultInterface
	}

    init {
        search@ClientToSE({.query= "Jolie Programing Language"})
    }

	main {
        [searchResult(res)]{
            println@Console( "# Found " + #res.result.Results.Result + " result(s)" )();
        }
    }
}

