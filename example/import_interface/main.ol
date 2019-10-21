import SearchEngine from SearchEngine
import SEResultInterface,SEInterface from SearchEngine
include "console.iol"


service Main ( params:MainParams ) { 
    embed SearchEngine{    }

	outputPort ClientToSE {
		Location: "local:/searchEngineInput"
		Interfaces: SEInterface
	}

	inputPort SEToClient {
		Location: "local:/searchEngineOutput"
		Interfaces: SEResultInterface
	}

    init{
        search@SearchEngine({.query= "Jolie Programing Language"})
    }

	main {
        [searchResult(res)]{
            println@Console( "# Found " + #res.result.Results.Result + " result(s)" )();
        }
        
    }
}

