import 'dart:async';
import 'package:flutter/material.dart';

import 'package:plant_life/icons/custom_icons_icons.dart';
import 'package:plant_life/models/plant.dart';
import 'package:plant_life/widgets/plantcard.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlantDetails extends StatefulWidget {
  final Plant plant;
  PlantDetails(this.plant);

  @override
  State<StatefulWidget> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails>
    with SingleTickerProviderStateMixin {
  double _panelPosition; // To keep track of the pannel's position
  Timer _timer; // Used for the delay to create a sliding animation
  PanelController _panelController;

  AnimationController _animationController;
  Animation<double> _animationValue;

  @override
  void initState() {
    _panelController = PanelController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //double minimumPanelHeight = MediaQuery.of(context).size.height / 2.3;
    double minimumPanelHeight = 50;
    double maximumPanelHeight = MediaQuery.of(context).size.height / 1.2;

    _animationValue = Tween<double>(begin: 0.0, end: minimumPanelHeight)
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SlidingUpPanel(
            controller: _panelController,
            renderPanelSheet: true,
            minHeight: _animationValue.value ?? 0,
            maxHeight: maximumPanelHeight,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
            backdropEnabled: true,
            backdropColor: Colors.grey[300],
            onPanelSlide: (double pos) {
              // Adding a timer creates a "jiggle effect" with the FAB droplet indicator
              // TODO change to an animation maybe Transition(Matrix 4)?
              _timer = Timer(Duration(milliseconds: 1), () {
                setState(() {
                  _panelPosition = minimumPanelHeight -
                      40 +
                      (maximumPanelHeight - minimumPanelHeight) * pos;
                });
              });
            },
            panel: DetailsCard(widget.plant),
            body: Stack(
              children: <Widget>[
                DetailsBody(widget.plant),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.white, size: 30.0),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: _panelPosition ?? _animationValue.value - 40,
            left: MediaQuery.of(context).size.width / 1.4,
            child: Container(
              height: 85.0,
              width: 85.0,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {},
                backgroundColor: Colors.white,
                child: Container(
                  child: DropletIndicator(
                      widget.plant.currentPercentage, widget.plant.isDry),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsBody extends StatelessWidget {
  final Plant plant;

  DetailsBody(this.plant);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            Container(
              //height: MediaQuery.of(context).size.height / 2.5,
              padding: EdgeInsets.only(top: 50, left: 30.0, right: 5.0),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45.0),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 35.0, bottom: 7.0),
                              child: Text(
                                plant.name,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                              child: Text(
                                '(Echinocactus Cereus)',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 200.0,
                              child: Hero(
                                tag: plant.heroTag,
                                child: Image.asset(
                                  plant.assetName,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //color: Colors.red,
                    padding: EdgeInsets.only(
                      top: 25.0, right: 20.0
                    ),
                    
                    alignment: Alignment.topRight,
                    //color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[InfoBox(), InfoBox(), InfoBox()],
                    ),
                  ),
                ],
              ),

              //color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsCard extends StatelessWidget {
  final Plant plant;

  DetailsCard(this.plant);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 15.0, left: 25.0, right: 25.0, bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // This is the tab indicator for pulling up the card
          Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    width: 80.0,
                    height: 4.0,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 35.0, bottom: 3.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 15.0,
                    runSpacing: 2.0,
                    children: <Widget>[
                      Text(
                        plant.name,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 26.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '(Echinocactus Cereus)',
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    CustomIcons.location,
                    size: 20.0,
                    color: Colors.grey[400],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 35.0),
                  child: Text(
                    plant.location,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey[400]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    CustomIcons.watering,
                    size: 20.0,
                    color: Colors.grey[400],
                  ),
                ),
                Text(
                  plant.waterConsumption.toString() + ' ml',
                  style: TextStyle(fontSize: 18.0, color: Colors.grey[400]),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Watering frequency',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '7 days',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Until the next watering',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '16 hours',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Semi-desert cacti need careful watering. General advice is hard to give, since the frequency of watering required depends on where the cacti are being grown, the nature of the growing medium, and the original habitat of the cacti. Brown says that more cacti are lost through the "untimely application of water than for any other reason" and that even during the dormant winter season, cacti need some water. Other sources say that water can be withheld during winter (November to March in the Northern Hemisphere). Another issue is the hardness of the water; where it is necessary to use hard water, regular re-potting is recommended to avoid the build up of salts. The general advice given is that during the growing season, cacti should be allowed to dry out between thorough waterings. A water meter can help in determining when the soil is dry.',
            style: TextStyle(
              color: Colors.grey[600],
              height: 1.2,
            ),
            softWrap: true,
            maxLines: 50,
          ),
        ],
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      margin: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              'Room temp',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.track_changes,
                  color: Colors.lightGreen,
                ),
              ),
              Text(
                '25',
                style: TextStyle(fontSize: 25.0, letterSpacing: 0.1),
              ),
              Text(
                '°C',
                style: TextStyle(fontSize: 25.0, color: Colors.grey[400]),
              )
            ],
          )
        ],
      ),
    );
  }
}
