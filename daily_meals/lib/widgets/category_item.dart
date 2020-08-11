// this file displays all of the meal categories using customize designed container

import '../screens/categories_meals_screen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
 

  CategoryItem(this.id, this.title, this.color);

  void nagivateSelectCategory(BuildContext ctx) {
    
    Navigator.of(ctx).pushNamed(
      CategoriesMealsScreen.routeName, // i.e. '/category-meals'
      arguments: {
        'id': id, 
        'title':title,
      },
    );
    
    // Another way of making navigation page.
    // Navigator.of(ctx).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return CategoriesMealsScreen(id,title);
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => nagivateSelectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),

      ),

    );
  }
}
