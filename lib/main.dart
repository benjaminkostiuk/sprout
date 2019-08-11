import 'package:flutter/material.dart';
import 'package:plant_life/screens/plant_details.dart';

import './screens/home.dart';
import './screens/plant_details.dart';

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
        '/details': (context) => PlantDetails(),
      },
    );
  }
}
