import 'package:flutter/material.dart';

import 'package:plant_life/models/plant.dart';

class PlantDetails extends StatelessWidget {
  final Plant plant;

  PlantDetails(this.plant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Text(plant.name),
          Hero(
            tag: plant.heroTag,
            child: Image.asset(plant.assetName),
          ),
        ],
      ),
    ));
  }
}
