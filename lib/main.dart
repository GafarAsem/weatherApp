import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'Scenes/home_page.dart';
import 'Service/web_service.dart';



void main()  async {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: Material(child: HomePage()),
    );
  }
}

//
