import 'package:flutter/material.dart';
import 'package:plant_life/icons/custom_icons_icons.dart';

/// Contains the widgets needed for creating the Sub Menu from the FAB

/// SubMenu Item
class FabSubMenuItem extends StatelessWidget {
  final IconData iconData;
  final String tooltip;
  final double elevation;
  final onTap;

  FabSubMenuItem({this.tooltip, this.iconData, this.elevation, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},   // This currently does not work but will be patched (so dumb) https://stackoverflow.com/questions/54653849/floatingactionbutton-onpressed-not-triggering
      backgroundColor: Colors.white,
      tooltip: tooltip,
      elevation: elevation,
      heroTag: null,
      child: Icon(
        iconData,
        color: Colors.green[400],
      ),
    );
  }
}

/// SubMenu
class FabSubMenu extends StatelessWidget {
  final double transition;
  final bool hideElevation;
  final onItemSelected;

  FabSubMenu({this.transition, this.hideElevation, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    double _subMenuElevation = 4.0;
    // Check if the elevation needs to be shown
    if (hideElevation) {
      _subMenuElevation = 0;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 28.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Transform(
                    transform: Matrix4.translationValues(
                        transition / 1.2, transition / 1.8, 0.0),
                    child: FabSubMenuItem(
                      onTap: onItemSelected,
                      tooltip: 'Add Plant',
                      iconData: CustomIcons.plant,
                      elevation: _subMenuElevation,
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(0, transition, 0.0),
                    child: FabSubMenuItem(
                      onTap: onItemSelected,
                      tooltip: 'Add droplet',
                      iconData: CustomIcons.droplet,
                      elevation: _subMenuElevation,
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        -transition / 1.2, transition / 1.8, 0.0),
                    child: FabSubMenuItem(
                      onTap: onItemSelected,
                      tooltip: 'Add Watering Schedule',
                      iconData: CustomIcons.watering,
                      elevation: _subMenuElevation,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
