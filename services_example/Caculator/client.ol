from "CalculatorService.ol" import 
    CalculatorIface,
    CalculatorService 
    // ,CalculatorParams omitable? since CalculatorService already has CalculatorParams defined

decl service client{

    embed CalculatorService ({ 
        i = { 
            location = "socket://localhost:3000" 
            protocol = sodep 
            interfaces = CalculatorIface
        }
    })
    // or embed CalculatorService ({ i = { location = "local", interfaces = CalculatorIface } })

    outputPort OP {
        location: "socket://localhost:3000"
        protocol: sodep
        interfaces: CalculatorIface
    }

    main {
        // sum({x=1 y=3})(res) ...
    }
}