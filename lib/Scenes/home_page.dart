import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather_app/Modules/descripe_wether.dart';
import 'package:weather_app/Modules/weather_module.dart';
import 'package:weather_app/Service/location.dart';
import 'package:weather_app/Service/weather_data.dart';
import 'package:weather_app/Service/web_service.dart';
import 'package:weather_app/UI/assetColor.dart';
import 'package:weather_app/UI/image_Weather.dart';
import 'package:weather_app/UI/style.dart';
import 'package:weather_app/Widgets/descripWeather.dart';
import 'package:weather_icons/weather_icons.dart';

// String city = 'NewYork';
// String day = 'ToDay'.toUpperCase();
// AssetImage weatherImage = AssetImage('images/cloudy.png');
// int temp = 17;
// String descripe = 'Cloudy'.toUpperCase();

AssetImage weatherImage = AssetImage('images/cloudy.png');
Weather _weather;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();
  Future<String> futureData;
  Future<Position> futurePosition;
  String city;
  int pageSelected;
  final TextEditingController _textController = TextEditingController();
  var prf;
  Future<bool> connected;

  @override
  void initState() {
    super.initState();
    pageSelected = 0;
    connected = getConnected();
    prf = getLastWeather();
  }

  Future<bool> getConnected() async {
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }

  Future<SharedPreferences> getLastWeather() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> setLastWeather(String dataWeather) async {
    final prf = await SharedPreferences.getInstance();
    bool lastWeather = await prf.setString('last_weather', dataWeather);
    return lastWeather;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: connected,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data as bool) {
              if (pageSelected == 0)
                return getPositionWeatherWidget(context);
              else
                return getCityWeatherWidget(context, _textController.text);
            } else {
              return FutureBuilder(
                  future: prf,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      String lastWeather =
                      snapshot.data.getString('last_weather');
                      if (lastWeather != null) {
                        var lastWeatherData = jsonDecode(lastWeather);
                        _weather = Weather.fromJson(lastWeatherData);
                        if (pageSelected == 0)
                          return getPositionWeatherWidget(context);
                        else
                          return getCityWeatherWidget(
                              context, _textController.text);
                      }
                      else {
                        return Container(
                          color: UI.gray_dark,
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: UI.gray_white,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Container(
                        color: UI.gray_dark,
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: UI.gray_white,
                          ),
                        ),
                      );
                    }
                  });
            }
          } else {
            return Container(
              color: UI.gray_dark,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: UI.gray_white,
                ),
              ),
            );
          }
        });
  }

  Widget scaffold(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: UI.gray_dark,
      body: Scrollable(
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 15, right: 15),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: UI.gray_dark,
                                    title: Text(
                                      'Search Place',
                                      style: style.myTextStyle(context, 15),
                                    ),
                                    content: Container(
                                      child: TextField(
                                        controller: _textController,
                                        onEditingComplete: () {
                                          setState(() {
                                            city = _textController.text;
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      getCityWeatherWidget(
                                                          context, city)),
                                            );
                                          });
                                        },
                                        style: style.myTextStyle(context, null),
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            prefixText: 'City : ',
                                            prefixStyle: style.myTextStyle(
                                                context, null),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                borderSide:
                                                    BorderSide(width: 2))),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'cancel',
                                            style: style.myTextStyle(
                                                context, null),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              city = _textController.text;
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        getCityWeatherWidget(
                                                            context, city)),
                                              );
                                            });
                                          },
                                          child: Text(
                                            'search',
                                            style: style.myTextStyle(
                                                context, null),
                                          )),
                                    ],
                                  );
                                },
                              );
                            });
                          },
                          icon: Icon(CupertinoIcons.search_circle_fill),
                          color: UI.gray_white,
                          iconSize: 50,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 15, right: 15),
                            child: Text(
                              _weather.getCity,
                              style: style.myTextStyle(context, 25),
                            ),
                          ),
                          Text(
                            _weather.getDay,
                            style: style.myTextStyle(context, 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image(
                    image: ImageWeather.getImage(
                        _weather.getmain, _weather.getDescripeWeather),
                    width: MediaQuery.of(context).size.height / 4,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Column(
                    children: [
                      Text(
                        '${_weather.getTemp}°c',
                        style: style.myTextStyle(context, 70),
                      ),
                      Text(
                        _weather.getmain,
                        style: style.myTextStyle(context, 15),
                      ),
                    ],
                  ),
                  Column(children: [
                    Divider(
                      height: 10,
                      color: UI.gray_white,
                      indent: MediaQuery.of(context).size.width / 4.5,
                      endIndent: MediaQuery.of(context).size.width / 4.5,
                      thickness: 2,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 8,
                      child: getViewPager(),
                    ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 2,
                      effect: ScaleEffect(
                          dotColor: UI.gray_white,
                          activeDotColor: Colors.blueGrey.shade900,
                          scale: 1.6),
                    ),
                  ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getViewPager() {
    return PageView.builder(
      controller: _controller,
      itemBuilder: (context, i) => DescripeWidget(_weather),
      itemCount: 2,
      scrollDirection: Axis.horizontal,
    );
  }

  Future<String> fetchWeatherData(Position position) async {
    var weatherData = await WepService.fetchCurrentWeatherLocation(
        position.latitude, position.longitude);
    return weatherData;
  }

  Widget getPositionWeatherWidget(BuildContext context) {
    futurePosition = Location.getPosition();
    return FutureBuilder<Position>(
        future: futurePosition,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            futureData = fetchWeatherData(snapshot.data as Position);
            return FutureBuilder<String>(
              future: futureData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _weather = WeatherData.getWeather(snapshot.data);
                  setLastWeather(snapshot.data.toString());
                  return scaffold(context);
                } else {
                  return Container(
                    color: UI.gray_dark,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: UI.gray_white,
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return Container(
                color: UI.gray_dark,
                child: Center(
                    child: CircularProgressIndicator(
                  backgroundColor: UI.gray_white,
                )));
          }
        });
  }

  Widget getCityWeatherWidget(BuildContext context, String city) {
    futureData = fetchWeatherDataCity(city);
    return FutureBuilder<String>(
      future: futureData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _weather = WeatherData.getWeather(snapshot.data);
          return scaffold(context);
        } else {
          return Container(
            color: UI.gray_dark,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: UI.gray_white,
              ),
            ),
          );
        }
      },
    );
  }

  Future<String> fetchWeatherDataCity(String city) async {
    var weatherData = await WepService.fetchCurrentWeather(city);
    return weatherData;
  }
}
