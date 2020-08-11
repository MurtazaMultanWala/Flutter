import '../models/meal.dart';
import 'package:flutter/material.dart';
import '../screens/meal_detail_Screen.dart';


class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  
  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
 });

  String get complexityText
  {
    switch(complexity){
      case Complexity.Simple: 
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText
  {
    switch(affordability){
      case Affordability.Affordable: 
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext ctx){
    
    Navigator.of(ctx).pushNamed(
      MealDetailScreen.routeName, 
      arguments: id,
    )
    .then((result)=>{
      if(result != null){
        // removeItem(result),
      }
    });
    // PushNamed returns Future Object thats allows ypu to specify the function which has done his execution i.e. the page you open has fully completed its work and returns the result.
    // After pop is called it will land on this page this was the area were it was called from.
    // inshort the pop is the method where the screen is ended so called finished execution therefore the arg return by the pop function ewill be return here in result usung ".then" method.
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> selectMeal(context),
      
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        elevation: 4,  //shadow behind the card
        margin: const EdgeInsets.all(10), //margin around every elemnt
      
        child: Column(
          children: <Widget>[
            // allows to add items on the top of eachother i.e. image and title top of it
            Stack(
              children: <Widget>[
              
                //since our card is of rounded border so we need to make image rounder border as well
                //which is not possible thorugh Image widget therefore,
                ClipRRect(
                  borderRadius: BorderRadius.only(  //only allows us to set each corcer seperately
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,  //fits the image into the appropiate size
                  ),
                ),

                Positioned( //only available in Stack widget for positioning the text as it is now at top of the image
                  bottom: 20,
                  right: 0,
                  // title was not fitting in the image width so wrap it inside the container of specific width.
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),

                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ), 

                      softWrap: true,  // text too long for container should be wrap
                      overflow: TextOverflow.fade,  // of overflow fade it out safety move
                    ),
                  ),
                ),
              ],
            ),
            
            //For displaying ifo about the image
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // all children of rows are spaced evenly

                //There are 3 children, Each child is itself row with two children
                children: <Widget>[
                  
                  //Adding Duration 
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox( width: 6), //for spacing with text
                      Text('$duration min'),
                    ],
                  ),

                  // Adding Complexity 
                  // Since its an enum so we need to translate number to the actual label therefore making getter;
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox( width: 6), //for spacing with text
                      Text(complexityText),
                    ],
                  ),

                  // Adding Affordability
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox( width: 6), //for spacing with text
                      Text(affordabilityText),
                    ],
                  ),

   
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}