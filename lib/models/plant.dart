class Plant {
  String name;
  String location;
  int waterConsumption;
  String assetName;
  double currentPercentage;
  bool isDry;

  Plant(this.name, this.location, this.waterConsumption, this.assetName,
      this.currentPercentage) {
    isDry = (currentPercentage > 0) ? false : true;
  }
}