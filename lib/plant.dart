import 'dart:math';

import 'package:flutter/material.dart';
import './custom_icons_icons.dart';

class Plant {
  String name;
  String location;
  int waterConsumption;
  String assetName;
  double currentPercentage;
  bool _isDry;

  Plant(this.name, this.location, this.waterConsumption, this.assetName,
      this.currentPercentage) {
    _isDry = (currentPercentage > 0) ? false : true;
  }
}

class PlantCard extends StatelessWidget {
  final Plant plant;

  PlantCard(this.plant);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 55.0,
            height: 65.0,
            margin:
                EdgeInsets.only(top: 7.0, left: 12.0, bottom: 7.0, right: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                plant.assetName,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      plant.name,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            CustomIcons.location,
                            size: 20.0,
                            color: Colors.grey[500],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 4.0),
                          ),
                          Text(
                            plant.location,
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            CustomIcons.watering,
                            size: 20.0,
                            color: Colors.grey[500],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 4.0),
                          ),
                          Text(
                            plant.waterConsumption.toString() + ' ml',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 25.0),
            child: CustomPaint(
              foregroundPainter: DropletPainter(plant.currentPercentage),
              child: Padding(
                padding: const EdgeInsets.all(13.5),
                child: Icon(
                  CustomIcons.droplet,
                  size: 25.0,
                  color:
                      plant._isDry ? Colors.grey[500] : Colors.lightGreen[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropletPainter extends CustomPainter {
  double _percentage;

  DropletPainter(this._percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = Colors.grey[300]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    Paint complete = Paint()
      ..color = Colors.lightGreen[400]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);

    double arcAngle = 2 * pi * (_percentage / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        -arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
