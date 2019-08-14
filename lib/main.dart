import 'package:flutter/material.dart';

import 'package:plant_life/screens/add.dart';
import 'package:plant_life/screens/calendar.dart';
import 'package:plant_life/screens/details.dart';
import 'package:plant_life/screens/home.dart';


void main() => runApp(PlantApp());

class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Life',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        // '/details': (context) => PlantDetails(),
        '/calendar': (context) => CalendarPage(),
        '/add': (context) => PlantAddPage(''),
      },
    );
  }
}
