import 'package:flutter/material.dart';
import 'package:plant_life/screens/plant_details.dart';

import '../widgets/plant.dart';

class PlantList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  final List<Widget> plantCards = [
    PlantCard(
      Plant('Echeveria', 'Kitchen', 100, 'assets/plant2.jpg', 0),
      key: Key('100'),
    ),
    PlantCard(
      Plant('Hyacinth', 'Kitchen', 90, 'assets/plant3.jpg', 0),
      key: Key('101'),
    ),
    PlantCard(
      Plant('Cactus', 'Kitchen', 75, 'assets/thorny-plant.jpg', 20),
      key: Key('102'),
    ),
    PlantCard(
      Plant('Ficus', 'Kitchen', 90, 'assets/aloe_vera.jpg', 60),
      key: Key('103'),
    ),
  ];

  Color _backCardColor = Colors.lightGreen[300];

  List<String> items = List<String>.generate(7, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // children: <Widget>[
      //   Stack(
      //     children: <Widget>[
      //       Card(
      //         margin:
      //             EdgeInsets.only(right: 0.0, left: 0.0, top: 5.0, bottom: 5.0),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(18.0)),
      //         ),
      //         color: _backCardColor,
      //         child: Row(
      //           children: <Widget>[
      //             Container(
      //               width: 55.0,
      //               height: 65.0,
      //               margin: EdgeInsets.only(
      //                   top: 7.0, left: 12.0, bottom: 7.0, right: 15.0),
      //             )
      //           ],
      //         ),
      //       ),
      //       Dismissible(
      //         key: Key('100'),
      //         onDismissed: (direction) {
      //           setState(() {
      //             plantCards.removeAt(0);
      //           });
      //         },
      //         background: Card(
      //           margin: EdgeInsets.only(
      //               right: 0.0, left: 0.0, top: 5.0, bottom: 5.0),
      //           elevation: 0.0,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(18.0)),
      //           ),
      //           color: Colors.grey[300],
      //         ),
      //         secondaryBackground: Card(
      //           margin: EdgeInsets.only(
      //               right: 0.0, left: 0.0, top: 5.0, bottom: 5.0),
      //           elevation: 0.0,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.all(Radius.circular(18.0)),
      //           ),
      //           color: Colors.lightGreen[300],
      //         ),
      //         child: GestureDetector(child: plantCards[0], onPanUpdate: (details) {
      //           // Swipe right
      //           if(details.delta.dx > 0) {
      //             setState(() {
      //                 _backCardColor = Colors.grey[300];
      //             });
      //           } else if(details.delta.dx < 0) {
      //             setState(() {
      //                  _backCardColor = Colors.lightGreen[300];
      //             });
      //           }
      //         },)
      //       ),
      //     ],
      //   ),
      // ],
      children: plantCards
          .asMap()
          .map((i, elem) => MapEntry(
                i,
                Dismissible(
                  key: elem.key,
                  onDismissed: (direction) {
                    setState(() {
                      plantCards.removeAt(i);
                    });
                    // Scaffold.of(context)
                    //     .showSnackBar(SnackBar(content: Text('Item dismissed')));
                  },
                  background: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.transparent,
                      )
                    ],
                  ),
                  child: Stack(children: <Widget>[
                    elem,
                  ]),
                ),
              ))
          .values
          .toList()
          .map((dismiss) => Stack(
                children: <Widget>[
                  dismiss,
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    ),
                    color: Colors.lightGreen[300],
                    child: Container(
                      width: double.infinity,
                    ),
                  ),
                ],
              ))
          .toList(),
    );

    // return ListView.builder(
    //   itemCount: items.length,
    //   itemBuilder: (context, index) {
    //     final item = items[index];

    //     return Dismissible(
    //       key: Key(item),
    //       onDismissed: (direction) {
    //         setState(() {
    //           items.removeAt(index);
    //         });
    //         Scaffold.of(context).showSnackBar(SnackBar(
    //           content: Text('Item dismissed'),
    //         ));
    //       },
    //       background: Container(
    //         color: Colors.red,
    //       ),
    //       child: ListTile(
    //         title: Text('$item'),
    //       ),
    //     );
    //   },
    // );
  }
}

class WateringTest extends StatelessWidget {
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
                    height: 250.0,
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
                      top: 60.0, left: 15.0, right: 15.0, bottom: 40.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: FloatingActionButton(
                                heroTag: null,
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/details');
                                },
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.green[400],
                                ),
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
                        color: Colors.transparent,
                        alignment: Alignment.topLeft,
                        child: PlantList(),
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

class WateringList extends StatelessWidget {
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
                      top: 60.0, left: 15.0, right: 15.0, bottom: 40.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PlantDetails()));
                                },
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 30.0,
                                  color: Colors.green,
                                ),
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
    );
  }
}
