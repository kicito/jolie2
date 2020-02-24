from "./EmailGreeter.ol" import Iface as serviceInterface

decl service client( ){

    embeded EmailGreeter({
        email="s@s.com",
        i: << {
            location: "local://EmailGreeter"
            interfaces: serviceInterface
        }
    })

    outputPort EmailGreeterPort{
        location: "local://EmailGreeter"
        interfaces: serviceInterface
    }

    main{
        hi@EmailGreeterPort()(res)
    }
}