import Console from "Console" // import Console from built-in package
import forecast from "./forecast.ol" // import forecast.ol, run init scope



service client(params){
  // usage jolie client.ol Rome


  // embeding Console is omitted

  embed forecast{ // send nothing to forecast
    // auto create outputPort for forecast (protocol local)
		bindIn: ForecastIP -> forecast // , IP2 -> OP2, etc.
    // bindin also 
  }


  init {
    println@Console("requesting forecast service")()
  }

  main{

    /*
    here the information of forecast's inputport is carry on after binded in
    forecast.location = "someloc"
    forecast.interfaces = {
       RequestResponse:
        getTemperature( GetTemperatureRequest )( double ),
        getWind( GetWindRequest )( double )
    }
    forecast.protocol = "local"
    */

    // params.args is assigned when a service is executing at top level.
    if (#params.args == 0){
      println@Console("Specify the city for which you are requiring information")()
    } else {
        request.city = args[0];
        if ( request instaceof forecast.getTemperature.req_type){ // true
          getTemperature@forecast( request )( response );
          println@Console("Temperature:" + response.temperature )();
        }else{
          println@Console("type mismatch" + response.temperature )();
        }

        if ( request instaceof forecast.getWind.req_type){ // true
          getWind@forecast( request )( response );
          println@Console("Wind:" + response.wind )();
        }else{
          println@Console("type mismatch" + response.temperature )();
        }

    }
  }
}