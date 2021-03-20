import 'dart:convert';

import 'package:weather_app/Modules/weather_module.dart';

class WeatherData {
  static Weather getWeather(String ResponeData) {
    var jsonObject = jsonDecode(ResponeData);

    return (Weather.fromJson(jsonObject));
  }

  static List<Weather> getHourlyWeather(String ResponeData) {
    List<Weather> list = [];

    var jsonObject = jsonDecode(ResponeData);
    jsonObject = jsonObject['hourly'];

    for (int i = 0; i < 24; i++) {
        list.add(Weather.fromJsonHourly(jsonObject[i]));
    }

    return list;
  }
}
