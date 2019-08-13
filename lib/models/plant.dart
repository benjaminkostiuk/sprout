import 'dart:math';

class Plant {
  String name;
  String location;
  int waterConsumption;
  String assetName;
  double currentPercentage;
  bool isDry;
  String heroTag;

  Plant(this.name, this.location, this.waterConsumption, this.assetName,
      this.currentPercentage) {
    var rng = Random();
    heroTag = name + location + assetName + rng.nextInt(100).toString();
    isDry = (currentPercentage > 0) ? false : true;
  }
}
