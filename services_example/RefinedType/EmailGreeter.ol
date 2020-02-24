interface configIface{
    RequestResponse: hi(void)(void)
}

type configServiceParams:void{
    email: string("^(.+)@(.+)$"),
    i:inputPort
}

decl service EmailGreeter(configServiceParams p){

    inputPort MyPort(i)

    main{
        [hi()(res) {res="hello " + p.email} ]
    }
}