import 'dart:async';
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
  // Used for pageinagtion of home page
  PageController _pageController;
  int _selectedIndex =
      0; // Keeps track of the selected index for the bottom bar

  // Animation information for FAB SubMenu
  bool _isOpened = false;
  bool _hideElevation = true;
  AnimationController _animationController;
  Animation<Color> _animateBackgroundColor;
  Animation<Color> _animateForegroundColor;
  Animation<double> _transition;
  Curve _curve = Curves.easeOut;

  // Information for calendar button transition
  final Duration _calendarAnimationDuration = Duration(milliseconds: 450);
  final Duration _delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  void _onCalendarIconTap() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(_calendarAnimationDuration + _delay, _goToCalendarPage);
    });
  }

  void _goToCalendarPage() {
    if(_isOpened) { animateFabMenu(); };  // Close the menu
    Navigator.of(context)
        .push(FadeRouteBuilder(page: CalendarPage()))
        .then((_) => setState(() => rect = null));
  }

  Widget _rippleWidget() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: _calendarAnimationDuration,
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
    //Initialize page controller
    _pageController = PageController(initialPage: 0, keepPage: false);
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
      _hideElevation = false;
      _animationController.forward();
    } else {
      _animationController.reverse();
      // Add a delay otherwise the shadow of FABs doesn't look right
      Timer delay = Timer(Duration(milliseconds: 150), () { 
        _hideElevation = true;
      });
    }
    _isOpened = !_isOpened;
  }

  void _updatePageChange(int index) {
    setState(() {
      // Close the sub menu if opened before switching tabs
      if (_isOpened && index != _selectedIndex) {
        animateFabMenu();
      }
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
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
              selectedIconTheme: IconThemeData(
                color: Colors.lightGreen,
                size: 28.0,
              ),
              unselectedItemColor: Colors.grey,
              onTap: (int index) {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
                _updatePageChange(index);
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
              PageView(
                controller: _pageController,
                onPageChanged: _updatePageChange,
                children: <Widget>[
                  WateringList(),
                  Container(
                    color: Colors.grey[200],
                  ),
                ],
              ),
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
                            onPressed: () => _onCalendarIconTap(),
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
                hideElevation: _hideElevation,
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
