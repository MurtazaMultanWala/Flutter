// This page loads the page of category on which user tapped.

import '../models/meal.dart';
import '../widgets/meal_item.dart';
import 'package:flutter/material.dart';
import '../dummy_data.dart';

class CategoriesMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  CategoriesMealsScreen(this.availableMeals);

  @override
  _CategoriesMealsScreenState createState() => _CategoriesMealsScreenState();
}


class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool _loadedMealData = false;
 
  @override
 // since initState is called before the build method or widget is created or full created so therefore we cannot pass the 
 // ModalRoute.of(context) here that will throw an error context issues and other. for that we use didChangeDependencies method.
  initState(){
    // now if not taking arg in constructor so how to accept that now from routes so for that MOdalRoute is used.
    
    /*final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    displayedMeals = DUMMY_MEALS.where((meal){
      return meal.categories.contains(categoryId);
    }).toList();*/
  }

  
  @override
  // Triggers when reference of the state change. this also runs before build runs so all Meals data will be loaded.
  void didChangeDependencies() {
    
    /* The if condition checks that if the data must load once when the screen is created.
     The resaon for checking this is because whenever the state changes it reloads all the data again as it runs on each state change.
     This doesnot full fills our requirement of deleteing recipe of the dish temporarly which user pressed on.*/   
    
    if(!_loadedMealData){
      // Now if not taking arg in constructor so how to accept that now from routes so for that MOdalRoute is used.
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      final String categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      
      displayedMeals = widget.availableMeals.where((meal){
        return meal.categories.contains(categoryId);
      }).toList();
      
      _loadedMealData = true;
    }
  }

  void _removeMeal(String mealId)
  {
      setState(() {
        displayedMeals.removeWhere((meal)=> meal.id == mealId);
      });
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      
      body: Center(
        /* Not using alt way i.e. child arg of listview because if we donot know the size of list and donot want to render 
         the removed list which is dynamocally handled, listview.builder() is suitable and efficient for this purpose.*/
        
        child: ListView.builder(
          itemBuilder: (ctx, index){ //index of the item render from the list
          
            // here we need to implement the widget we need to show
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title, 
              imageUrl: displayedMeals[index].imageUrl, 
              duration: displayedMeals[index].duration, 
              complexity: displayedMeals[index].complexity, 
              affordability: displayedMeals[index].affordability,
            );

          },
          
          // tells the list the # of recipes
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}