import 'dart:math';
import 'package:flutter/material.dart';

import 'package:plant_life/widgets/plantcard.dart';
import 'package:plant_life/models/plant.dart';

class DayHeader extends StatelessWidget {
  final String title;

  DayHeader(this.title);

  @override
  Widget build(BuildContext context) {
    Color fontColor;
    FontWeight fontWeight;
    double topPadding;

    if (title == 'Missed') {
      fontColor = Colors.white;
      fontWeight = FontWeight.w500;
      topPadding = 0.0;
    } else {
      fontColor = Colors.grey[700];
      fontWeight = FontWeight.w600;
      topPadding = 20.0;
    }

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 25.0,
            fontWeight: fontWeight,
            letterSpacing: -0.8,
            color: fontColor),
      ),
    );
  }
}

class DaySection extends StatelessWidget {
  final List<PlantCard> plantCards;
  final String sectionTitle;
  final onRemovePlantCard;

  DaySection({this.plantCards, this.sectionTitle, this.onRemovePlantCard});

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = plantCards
        .asMap()
        .map((i, elem) => MapEntry(
              i,
              Dismissible(
                key: elem.key,
                onDismissed: (direction) {
                  onRemovePlantCard(sectionTitle, i);
                },
                background: PlantCardBody(
                  color: Colors.grey[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(
                          Icons.format_color_reset,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                    ],
                  ),
                ),
                secondaryBackground: PlantCardBody(
                  color: Colors.lightGreen[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      ),
                    ],
                  ),
                ),
                child: elem,
              ),
            ))
        .values
        .toList();
    final List<Widget> sectionList =
        List<Widget>.from([DayHeader(sectionTitle)]);
    sectionList.addAll(cards);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sectionList);
  }
}

class WateringList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WateringListState();
}

class _WateringListState extends State<WateringList> {

  static Random rnd = Random();

  // Holds plant data
  Map<String, List<PlantCard>> plantData = {
    'Missed': [
      PlantCard(
        Plant('Echeveria', 'Kitchen', 100,
            'assets/plant_icons/plant' + (1 + rnd.nextInt(15)).toString() + '.png', 0),
        key: Key('100'),
      ),
      PlantCard(
        Plant('Hyacinth', 'Kitchen', 90, 'assets/plant_icons/plant' + (1 + rnd.nextInt(15)).toString() + '.png', 0),
        key: Key('101'),
      ),
    ],
    'Today': [
      PlantCard(
        Plant('My Cactus', 'Kitchen', 75,
            'assets/plant_icons/plant' + (1 + rnd.nextInt(15)).toString() + '.png', 85),
        key: Key('102'),
      ),
      PlantCard(
        Plant('Ficus', 'Kitchen', 90, 'assets/plant_icons/plant' + (1 + rnd.nextInt(15)).toString() + '.png', 60),
        key: Key('103'),
      ),
    ],
    'Tommorrow': [
      PlantCard(
        Plant('Cactus', 'Kitchen', 75, 'assets/plant_icons/plant' + (1 + rnd.nextInt(15)).toString() + '.png', 20),
        key: Key('104'),
      ),
      PlantCard(
        Plant('Ficus', 'Kitchen', 90, 'assets/plant_icons/plant' + (1 + rnd.nextInt(15)).toString() + '.png', 60),
        key: Key('105'),
      ),
      PlantCard(
        Plant('Ficus', 'Kitchen', 90, 'assets/plant_icons/plant' + (1 + rnd.nextInt(15)).toString() + '.png', 60),
        key: Key('106'),
      ),
    ]
  };

  // Removed the dismissed from the corresponding day at its index
  void removeCard(String day, int index) {
    setState(() => plantData[day].removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.1, 0.45, 0.8, 0.9],
                        colors: [
                          Colors.lightGreen[800],
                          Colors.lightGreen[500],
                          Colors.lightGreen[400],
                          Colors.lightGreen[300],
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60.0),
                      ),
                    ),
                    height: 245.0,
                    // child: FittedBox(
                    //   fit: BoxFit.fill,
                    //   child: Container(color: Colors.red,),
                    //   // child: ClipRRect(
                    //   //   borderRadius: BorderRadius.only(
                    //   //     bottomLeft: Radius.circular(60.0),
                    //   //     bottomRight: Radius.circular(0.0),
                    //   //   ),

                    //   //   child: Image.asset(
                    //   //     'assets/heading.jpg',
                    //   //     fit: BoxFit.fitWidth,
                    //   //   ),
                    //   // ),
                    // ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 120.0, left: 20.0, right: 15.0, bottom: 40.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Hi',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 45.0,
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            ' Natalie!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 45.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 12.0,
                          left: 12.0,
                          right: 5.0,
                        ),
                        color: Colors.transparent,
                        alignment: Alignment.topLeft,
                        child: Column(
                            // List of sections
                            children: plantData
                                .map((title, elem) => MapEntry(
                                    title,
                                    DaySection(
                                      sectionTitle: title,
                                      plantCards: elem,
                                      onRemovePlantCard: removeCard,
                                    )))
                                .values
                                .toList()),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
