import Rand from Rand

service Main ( params:MainParams ) { // name of the service must be the same as the name of the enclosing file
    embed Rand ({.seed = 1}){
        bindIn: IP -> Rand
    }
    main{
        nextInt@Rand()(randInt)
        // log result
    }
}