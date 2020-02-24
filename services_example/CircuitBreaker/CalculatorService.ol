
type msg : void{
    x:int
    y:int
} 

interface CalculatorIface {
	requestResponse: sum(msg)(int), minus(msg)(int), mul(msg)(int), div(msg)(int)
}

type CalculatorParams: void{
    i: inputPort { // expect i as type inputPort
        interfaces: CalculatorIface
    }
}

decl service CalculatorService( CalculatorParams p ){
    
    execution{ concurrent }

    inputPort ip(p.i)

    main{
        [sum(req)(res){
            res = req.x + req.y
        }]
        [minus(req)(res){
            res = req.x - req.y
        }]
        [mul(req)(res){
            res = req.x * req.y
        }]
        [div(req)(res){
            res = req.x / req.y
        }]
    }
}