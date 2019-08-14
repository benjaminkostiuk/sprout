import 'package:flutter/material.dart';
import 'package:plant_life/screens/add.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.lightBlue,
            width: 200.0,
            height: 400.0,
            child: Column(
              children: <Widget>[
                Center(
                  child: Hero(
                    tag: 'hero1',
                    child: Image.asset('assets/plant2.jpg'),
                  ),
                ),
                RaisedButton(
                  child: Text('Go to add'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlantAddPage('hero1')));
                  },
                ),
              ],
            )),
      ),
    );
  }
}
