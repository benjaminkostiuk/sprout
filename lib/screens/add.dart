import 'package:flutter/material.dart';

class PlantAddPage extends StatelessWidget {
  final String heroTag;

  PlantAddPage(this.heroTag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Hero(
          tag: heroTag,
          child: Image.asset('assets/plant2.jpg'),
        ),
      ),
    );
  }
}
