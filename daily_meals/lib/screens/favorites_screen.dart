import '../widgets/meal_item.dart';
import '../models/meal.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    
    if(favoriteMeals.isEmpty){
      return Center(
        child: Text("You have no favorites saved ... start adding some!"),
      );
    }
    else{
      return ListView.builder(
          itemBuilder: (ctx, index){ //index of the item render from the list
          
            // here we need to implement the widget we need to show
            return MealItem(
              id: favoriteMeals[index].id,
              title: favoriteMeals[index].title, 
              imageUrl: favoriteMeals[index].imageUrl, 
              duration: favoriteMeals[index].duration, 
              complexity: favoriteMeals[index].complexity, 
              affordability: favoriteMeals[index].affordability,
            );
            
          },
          
          // tells the list the # of recipes
          itemCount: favoriteMeals.length,
        ); 
    }
  }
}