import 'package:complex_ui/data/local/models/recipee.dart';

class RecipeeRepository {
  RecipeeRepository();

  final List<Recipe> recipees = [
    Recipe(
        name: "Chicken Tinga Tacos",
        pieces: 3,
        calories: 1032,
        minDuration: Duration(minutes: 20),
        maxDuration: Duration(minutes: 30),
        assetName: "assets/recipe/chicken_taco.jpg",
        startCount: 3,
        reviewCount: 12),
    Recipe(
        name: "Omelette Sticks",
        pieces: 12,
        calories: 206,
        minDuration: Duration(minutes: 20),
        maxDuration: Duration(minutes: 30),
        assetName: "assets/recipe/omelette_sticks.jpg",
        startCount: 4,
        reviewCount: 24),
    Recipe(
        name: "Vegan Supreme Pizza",
        pieces: 1,
        calories: 1077,
        minDuration: Duration(hours: 9, minutes: 20),
        maxDuration: Duration(hours: 9, minutes: 40),
        assetName: "assets/recipe/vegan_supreme_pizza.jpg",
        startCount: 5,
        reviewCount: 89),
    Recipe(
        name: "Vegan Brownies",
        pieces: 12,
        calories: 329,
        minDuration: Duration(minutes: 20),
        maxDuration: Duration(minutes: 30),
        assetName: "assets/recipe/vegan_brownies.jpg",
        startCount: 2,
        reviewCount: 1),
    Recipe(
        name: "American-style Pancakes",
        pieces: 5,
        calories: 252,
        minDuration: Duration(minutes: 20),
        maxDuration: Duration(minutes: 30),
        assetName: "assets/recipe/american_pancakes.jpg",
        startCount: 3,
        reviewCount: 90),
    Recipe(
        name: "Blueberry Yoghurt",
        pieces: 3,
        calories: 123,
        minDuration: Duration(minutes: 20),
        maxDuration: Duration(minutes: 30),
        assetName: "assets/recipe/yoghurt.jpg",
        startCount: 3,
        reviewCount: 129),
  ];

  // Get list with recipees
  List<Recipe> getSpecialRecipees() {
    return recipees;
  }

  // Get recommendations
  List<Recipe> getRecommendations() {
    return recipees.getRange(0, 3).toList();
  }
}
