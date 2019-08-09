import 'package:flutter/material.dart';

import './plant.dart';
import './custom_icons_icons.dart';

void main() => runApp(PlantApp());

class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Life',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[400],
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.red,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          selectedItemColor: Colors.lightGreen,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(right: 20.0, top: 5.0),
                child: Icon(
                  CustomIcons.watering_can_with_water_drops,
                  size: 28.0,
                ),
              ),
              title: Container(
                height: 0,
                width: 0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Icon(CustomIcons.plant),
              ),
              title: Container(
                height: 0,
                width: 0,
              ),
            )
          ],
        ),
      ),
      body: Container(
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
                      height: 220.0,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(60.0),
                            bottomRight: Radius.circular(60.0),
                          ),
                          child: Image.asset(
                            'assets/heading.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 60.0, left: 15.0, right: 15.0, bottom: 95.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Hi Natalie!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 12.0,
                            left: 12.0,
                            right: 5.0,
                          ),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Missed',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              PlantCard(Plant('Echeveria', 'Kitchen', 100,
                                  'assets/plant2.jpg', 0)),
                              PlantCard(Plant('Hyacinth', 'Kitchen', 90,
                                  'assets/plant3.jpg', 0)),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.8,
                                      color: Colors.grey[700]),
                                ),
                              ),
                              PlantCard(Plant('Cactus', 'Kitchen', 75,
                                  'assets/thorny-plant.jpg', 20)),
                              PlantCard(Plant('Ficus', 'Kitchen', 90,
                                  'assets/aloe_vera.jpg', 60)),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'Tomorrow',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.8,
                                      color: Colors.grey[700]),
                                ),
                              ),
                              PlantCard(Plant('Haworthia', 'Upstairs', 120,
                                  'assets/thorny-plant.jpg', 75)),
                              PlantCard(Plant('Ficus', 'Kitchen', 90,
                                  'assets/plant2.jpg', 85)),
                              PlantCard(Plant('Cactus', 'Kitchen', 90,
                                  'assets/thorny-plant.jpg', 95)),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'Sat. August 5th',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.8,
                                      color: Colors.grey[700]),
                                ),
                              ),
                              PlantCard(Plant('Haworthia', 'Upstairs', 120,
                                  'assets/thorny-plant.jpg', 75)),
                              PlantCard(Plant('Ficus', 'Kitchen', 90,
                                  'assets/plant2.jpg', 85)),
                              PlantCard(Plant('Cactus', 'Kitchen', 90,
                                  'assets/thorny-plant.jpg', 95)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
