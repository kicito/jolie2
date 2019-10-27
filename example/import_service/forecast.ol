include "interfaces/forecastInterface.iol"

service forecast(){

  inputPort ForecastIP {
    Interfaces: ForecastInterface
  }


  main {
    /* here we implement an input choice among the operations: getTemperature and getWind */
    [ getTemperature( request )( response ) {
      if ( request.city == "Rome" ) {
        response = 32.4
      } else if ( request.city == "Cesena" ) {
        response = 30.1
      } else {
        response = 29.0
      }
    } ]

    [ getWind( request )( response ) {
      if ( request.city == "Rome" ) {
        response = 1.40
      } else if ( request.city == "Cesena" ) {
        response = 2.01
      } else {
        response = 1.30
      }
    }]
  }

}