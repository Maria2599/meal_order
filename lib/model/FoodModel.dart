class FoodModel {
  List? todaysFood;
  List? Saturday;

  FoodModel({
    required this.todaysFood,
     this.Saturday,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    todaysFood = json['todaysFood'];
    Saturday = json['Saturday'];
  }

  Map<String, dynamic> toMap() {
    return {
      'todaysFood': todaysFood,
      'Saturday': Saturday,
    };
  }
}
