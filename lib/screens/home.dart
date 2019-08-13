import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

import 'package:plant_life/screens/calendar.dart';
import 'package:plant_life/widgets/submenu.dart';
import 'package:plant_life/widgets/wateringlist.dart';


import 'package:plant_life/icons/custom_icons_icons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Used for keeping track of tabs
  int _selectedIndex = 0;
  List<Widget> _tabs = <Widget>[
    WateringList(),
    Container(),
  ];

  // Animation information for FAB SubMenu
  bool _isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateBackgroundColor;
  Animation<Color> _animateForegroundColor;
  Animation<double> _transition;
  Curve _curve = Curves.easeOut;

  // Information for calendar button transition
  final Duration animationDuration = Duration(milliseconds: 550);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  void _onTap() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToCalendarPage);
    });
  }

  void _goToCalendarPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: CalendarPage()))
        .then((_) => setState(() => rect = null));
  }

  Widget _rippleWidget() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void initState() {
    // Initialize animation controller
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    // Set up animate icon
    // _animateIcon =
    //     Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    // Set up animation color
    _animateBackgroundColor =
        ColorTween(begin: Colors.green[300], end: Colors.white).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.00, 1.00, curve: Curves.linear)));
    _animateForegroundColor =
        ColorTween(begin: Colors.white, end: Colors.green[400]).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval(0.00, 1.00, curve: Curves.linear)));
    // Set up translation of menu items
    _transition = Tween<double>(begin: 0.0, end: -88.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.75, curve: _curve),
    ));

    super.initState();
  }

  void animateFabMenu() {
    if (!_isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _isOpened = !_isOpened;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: _animateBackgroundColor.value,
            onPressed: animateFabMenu,
            tooltip: 'Add',
            child: Icon(
              Icons.add,
              color: _animateForegroundColor.value,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 6.0,
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.lightGreen,
              unselectedItemColor: Colors.grey,
              onTap: (int index) {
                setState(() {
                  // Close the sub menu if opened before switching tabs
                  if (_isOpened && index != _selectedIndex) {
                    animateFabMenu();
                  }
                  _selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5.0),
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
                  icon: Icon(CustomIcons.plant),
                  title: Container(
                    height: 0,
                    width: 0,
                  ),
                )
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              _tabs.elementAt(_selectedIndex),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 60.0, right: 25.0),
                        child: RectGetter(
                          key: rectGetterKey,
                          child: FloatingActionButton(
                            heroTag: null,
                            backgroundColor: Colors.white,
                            onPressed: () {
                              _onTap();
                            },
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.green[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              FabSubMenu(
                transition: _transition.value,
                hideElevation: !_isOpened,
              ),
            ],
          ),
        ),
        _rippleWidget(),
      ],
    );
  }
}

/// FadeTransition needed for calendar page transition
class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
            pageBuilder: (context, animation1, animation2) => page,
            transitionsBuilder: (context, animation1, animation2, child) {
              return FadeTransition(
                opacity: animation1,
                child: child,
              );
            });
}
