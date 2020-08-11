import 'package:flutter/foundation.dart';

enum Complexity{
    Simple,
    Challenging,
    Hard,
}

enum Affordability{
  Affordable,
  Pricey,
  Luxurious,
}

class Meal{
  
  final String id;  //unique meal id
  final List<String> categories;  // a meal can belong to multiple categories.
  final String title;
  final String imageUrl;  //fetch dynamically from net
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    @required this.id,
    @required this.categories,
    @required this.title, 
    @required this.imageUrl,
    @required this.ingredients,
    @required this.steps,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian, 
  });
}