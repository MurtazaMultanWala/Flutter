import '../screens/filters_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  
  // returns the ListTile widget for reusability purpose. if the widget contins the setState() method or anythine like that which triggers the build method than it 
  // would be great to create a seperate widget but here there is nothing like that so its ok. It can be a Theme.of() method which triggers the build method only if
  // when themes are dynamic with respect to the pages if theme is constant no need for that.
  Widget buildListTile( String titleText, IconData icon, Function pageTabHandler)
  {
    return ListTile(
      leading: Icon(
        icon, 
        size: 26,
      ),

      title: Text(
        titleText,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),

      onTap: pageTabHandler,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            //it controls how the child elemnents will be alligned inside the container 
            alignment: Alignment.centerLeft, //vertically center, horizontally left
            color: Theme.of(context).accentColor,

            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ), 
            ),

          ),

          SizedBox(height: 20),
          
          // for restaurant tab
          buildListTile(
            "Meals", 
            Icons.restaurant, 
            (){
              //replacementNamed will not maintain stack it just erase the last screen and loads this one.
              Navigator.of(context).pushReplacementNamed("/");
            }
          ),

          // for setting tab
          buildListTile(
            "Filters", 
            Icons.settings,
            (){
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            }
          ),

        ],
      ),
    );
  }
}