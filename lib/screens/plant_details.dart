import 'package:flutter/material.dart';


class PlantDetails extends StatelessWidget {
  // final Plant plant;

  // PlantDetails(this.plant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pushNamed(context, '/home');
          },
          child: Text('Plant Details'),
        ),
      )
    );
  }
}
