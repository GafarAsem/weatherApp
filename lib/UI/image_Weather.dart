import 'package:flutter/cupertino.dart';

class ImageWeather {


  static AssetImage getImage(String mainWeather,String descripeMain) {
    AssetImage image;
    switch (mainWeather) {

      case 'Clear':
        DateTime
            .now()
            .hour < 12 ?
        image= getAsset('images/clear_day.png')
            :
        image= getAsset('images/clear_night.png');

        break;

      case 'Clouds':

        if(descripeMain=='few clouds'||descripeMain=='scattered clouds'){
          DateTime
              .now()
              .hour < 12  ?
          image= getAsset('images/cloudy_sun.png')
              :
          image= getAsset('images/cloudy_night.png');
        }
        else{
          image=getAsset('images/cloudy.png');
        }
        break;

      case 'Rain':

        image =getAsset('images/riany.png');

        break;

      case 'Thunderstorm':

        image =getAsset('images/storm.png');

        break;

      case 'Snow':

        image =getAsset('images/snow.png');

        break;


  }

  return image;

  }

  static AssetImage getAsset(String pathImage) {
    return AssetImage(pathImage);
  }

}