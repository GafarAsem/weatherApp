

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Weather{

  final String city,descripeWeather,mainWeather;
  final int temp,wind;
  final DateTime dateTime;



  Weather({this.city, this.descripeWeather,this.mainWeather, this.temp, this.wind, this.dateTime}){
    initializeDateFormatting();
    Intl.defaultLocale = 'en';
  }

  String get getCity{
    return city;
  }
  String get getDescripeWeather{
    return descripeWeather;
  }
  int get getTemp{

    return temp;
  }
  int get getWind{
    return wind;
  }
  String get getDay{
    return DateFormat('EEE').format(dateTime);
  }
  String get getTime{
    return DateFormat('Hm').format(dateTime);
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'] as String,
      mainWeather: json['weather'][0]['main'] as String,
      descripeWeather: json['weather'][0]['description'] as String,
      temp: ((json['main']['temp']-273)as double).round(),
      wind: (json['wind']['speed']as double).round(),
      dateTime: DateTime.now()
    );
  }

  factory Weather.fromJsonHourly(Map<String, dynamic> json) {
    return Weather(
      mainWeather: json['weather'][0]['main'] as String,
      descripeWeather: json['weather'][0]['description'] as String,
      temp: ((json['temp']-273)as double).round(),
      wind: (json['wind_speed']as double).round(),
      dateTime: DateTime.now()
    );
  }

  String get getmain {
    return mainWeather;
  }



}