import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // reason for commenting scafold is due to tabs screen it has tab bar and itself is a scaffold tha means its fully occupies the screen
    // therefore adding scaffold here can will always occupy full screen which we donot want it must occupy the remaining screen of the page.
    // return Scaffold(
      
    //   appBar: AppBar(
    //     title: const Text("Daily Meal"),
    //   ),
      
    //   body: 
    return GridView(    

        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
          .map(
            (categoryData) => CategoryItem(
              categoryData.id,
              categoryData.title, 
              categoryData.color,
            ),
          ).toList(),
        
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, // shows how many pixels it should for can item on the screen per row 
          childAspectRatio: 3/2, //how should be sized regarding to the width and height ratio i.e for 200 width there is 300 height ratio.  
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        
        /*
          silver are the scrolable areas on the screen
          gridDelegate take cares of structuring layouts of grid,
          withhMaxCrossAxisExtent predefine class allows to have maximum width
        */
      // ),
    ); 
  }
}