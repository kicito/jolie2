import * as hs from Http_Status // call init scope in http_status
// * helps us to move all exported variable into one namespace

type httpResponse:int{
    text:string
}

interface MyInterface{
    RequestResponse: requestResponse( string )( httpResponse )
}

inputPort myPort{
    Location: "socket://localhost:3000"
    Protocol: http
    Interfaces: MyInterface
}

main{
    [requestResponse(request)(response){
        if (request == "index.html"){
            response = hs.StatusOK  // 200
            response.text = hs.status.(hs.StatusOK) // "OK"
        }else{
            response = hs.StatusNotFound  // 404
            response.text = hs.status(hs.StatusNotFound) // "Not Found"
        }
    }]
}
