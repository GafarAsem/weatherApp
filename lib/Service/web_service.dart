import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/Modules/weather_module.dart';
import 'package:weather_app/Service/weather_data.dart';

class WepService {

  static var weatherURL = 'api.openweathermap.org';
  static var tokenApi='4e3d36f8747c07b49c5dfcd4046d8141';
  static var currentWeather='/data/2.5/weather';
  static var oneCallWeather='/data/2.5/onecall';


  static Future<String> fetchCurrentWeather(String cityName) async {

    var response = await http.get(Uri.https(
      weatherURL,
      currentWeather,
      {
        'q':cityName,
         'appid':tokenApi
      }
    ));



    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
     // _weather=WeatherData.getWeather(response.body);
      return response.body;
    } else {
      throw Exception('Failed to load weather');
    }

  }


  static Future<String> fetchCurrentWeatherLocation(double lat,double lon) async {

    var response = await http.get(Uri.https(
        weatherURL,
        currentWeather,
        {
          'lat':lat.toString() ,
          'lon':lon.toString(),
          'appid':tokenApi
        }
    ));



    if (response.statusCode == 200) {

      return response.body;
    } else {
      throw Exception(Uri.https(
          weatherURL,
          currentWeather,
          {
            'lat':lat.toString() ,
            'lon':lon.toString(),
            'appid':tokenApi
          }
      ));
    }

  }
  static Future<String> fetchHourlyWeatherLocation(double lat,double lon) async {

    var response = await http.get(Uri.https(
        weatherURL,
        oneCallWeather,
        {
          'lat':lat.toString(),
          'lon':lon.toString(),
          'exclude':'minutely,daily',
          'appid':tokenApi,
        }
    ));



    if (response.statusCode == 200) {

      return response.body;
    } else {
      throw Exception('Failed to get Hourly currentData');
    }

  }

}
