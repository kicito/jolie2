
type searchRequestMsg:void{
    .query:string
}

type searchResponseMsg: void{
    .result: any{?}
}

interface SEInterface{
    OneWay : // or oneWay
        search(searchRequestMsg)
}

interface SEResultInterface{
    OneWay: 
        searchResult(searchResponseMsg)
}

// asyncronous search
service SearchEngine (params){

    outputPort SEOP {
        Location: "socket://api.duckduckgo.com:443/"
        Protocol: https {
            .osc.search.alias = "?q=%{q}&format=xml&t=jolie_example";
            .osc.search.method = "get"
        }
        RequestResponse: search // dynamic typing
    }

    inputPort IP{
        Interfaces: SEInterface
        Location: "local:/searchEngineInput"
    }

    outputPort OPToClient{
        Interfaces: SEResultInterface
        Location: "local:/searchEngineOutput"
    }

    main {
        [search(req){
            search@SEOP({.q= .req.q})(res)
        }]{
            searchResult@ClientOP({.result = res})
        }
    }
}