
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Modules/descripe_wether.dart';
import 'package:weather_app/Modules/weather_module.dart';
import 'package:weather_app/Service/web_service.dart';
import 'package:weather_app/UI/assetColor.dart';
import 'package:weather_app/UI/style.dart';
import 'package:weather_icons/weather_icons.dart';


List<DescripeWeather> description;
class DescripeWidget extends StatefulWidget {


  @override
  _DescripeWidgetState createState() => _DescripeWidgetState();

  DescripeWidget(Weather weather){


      description=[
        DescripeWeather(icon: CupertinoIcons.sun_dust,title: 'SUNRISE',value: weather.getTime),
        DescripeWeather(icon: CupertinoIcons.wind,title: 'WIND',value: '${weather.getWind}m/s'),
        DescripeWeather(icon: WeatherIcons.thermometer,title: 'TEMP',value: '${weather.getTemp}°c')];

  }

}

class _DescripeWidgetState extends State<DescripeWidget> {






  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // children: description.map((e) => descripWidget(e,context)).toList()
      children: [
        descripWidget(description[0], context),
        Container(
          height:30,
          width: 1,
          color: Colors.grey,
        ),
        descripWidget(description[1], context),
        Container(
          height:30,
          width: 1,
          color: Colors.grey,
        ),
        descripWidget(description[2], context),
      ],
    );
  }


}

Widget descripWidget(DescripeWeather descripeWeather,BuildContext context){
  return Container(
    child: Column(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(descripeWeather.icon,color: UI.gray_white,),
        ),
        Text(descripeWeather.title,style: style.myTextStyle(context,14),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${descripeWeather.value}',style: style.myTextStyle(context,14),),
        )
      ],
    ),
  );

}
