import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';
=======
>>>>>>> d7d9b543cb8bad29f869ee4e8315464d2417aa16

import 'Scenes/home_page.dart';
import 'Service/web_service.dart';



void main()  async {
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
<<<<<<< HEAD


=======
>>>>>>> d7d9b543cb8bad29f869ee4e8315464d2417aa16
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
<<<<<<< HEAD

=======
>>>>>>> d7d9b543cb8bad29f869ee4e8315464d2417aa16
}

//
