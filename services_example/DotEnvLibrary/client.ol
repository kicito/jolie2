from "DotEnvJolie2.ol" import DotEnvJolie2,DotEnvIface

decl client(){
    embed DotEnvJolie2({ i= "DotEnv", file= ".env", debug =true  })

    init{
        readEnv@DotEnv()(env)
    }
    main{
        // ...
    }
}