type RandParams: void{
    .seed: long
}

interface IRand{
    RequestResponse:
        nextInt(void)(int),
        nextLong(void)(long),
        nextDouble(void)(double)
    OneWay: // oneWay
        setSeed(long)
}

foreign service RandService{

    outputPort Rand{
        Interfaces: IRand
    }

    type: Java
    id: "joliex.util.RandService"
}

service Rand (params: RandParams){
    embed RandService{
        bindOut: Rand -> RandJavaService
    }

    inputPort IP {
		interfaces: IRand
	}

    setSeed@RandJavaService(params.seed)

    for(true){
        [nextInt(){

        }]
        //...
    }
}