import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavoriteHandler;
  final Function isFavoriteMealHandler;

  MealDetailScreen(this.toggleFavoriteHandler, this.isFavoriteMealHandler);

  Widget buildSectionTitle(BuildContext ctx, String text){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),

      child: Text(
        text,
        style: Theme.of(ctx).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 153, 
      width: 300,

      child: child,
    );
  }


  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =  DUMMY_MEALS.firstWhere((meal)=> meal.id == mealId);
    return Scaffold(
      
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          
          children: <Widget>[
            
            //used to display image of the dish clicked on
            Container(
              height: 300, 
              width: double.infinity,
              
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            // returning the container with customize design which just print the text send as arg to avoid repeating the code snippet
            buildSectionTitle(context, "Ingrdients"),
            
            // returns the container with child param list view as an arg used to display the list items with custom design to avoid repeating the code snippet
            buildContainer( ListView.builder(
                itemBuilder: (ctx, index)=> Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  ),
                
                itemCount: selectedMeal.ingredients.length,
              ),  
            ),

            // returning the container with customize design which just print the text send as arg to avoid repeating the code snippet
            buildSectionTitle(context, "Steps"),

            // returns the container with child param list view as an arg used to display the list items with custom design to avoid repeating the code snippet
            buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => Column( 
                  children: [
                    
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index+1)}'),
                      ),

                      title: Text(selectedMeal.steps[index]),
                    ),
                    
                    //it simply draws a horizontal line
                    Divider(), 
                  ], 
                ),
                
                itemCount: selectedMeal.steps.length,
              ),),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavoriteMealHandler(mealId)? Icons.star: Icons.star_border,
        ),
        onPressed: ()=> toggleFavoriteHandler(mealId),
      ),
    );
  }
}