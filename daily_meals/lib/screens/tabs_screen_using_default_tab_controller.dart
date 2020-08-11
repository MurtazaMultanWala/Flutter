import 'package:daily_meals/screens/favorites_screen.dart';

import './categories_screen.dart';
import 'package:flutter/material.dart';
class TabsScreenDefaultController extends StatefulWidget {
  @override
  _TabsScreenDefaultControllerState createState() => _TabsScreenDefaultControllerState();
}

class _TabsScreenDefaultControllerState extends State<TabsScreenDefaultController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // how many tabs you you wanna have
      length: 2, 
      
      // this means first tab i.e. categories will be by default selected when app is started to change replace 0 with the tab index.
      initialIndex: 0,

      //here we add tab bar and two tabs in it for user.
      child: Scaffold(
        appBar: AppBar(
          
          title: Text("Meals"),
          
          bottom: TabBar(
            tabs: <Widget>[
              
              //First tab for Goto Categories Page.
              Tab(
                icon: Icon(Icons.category), 
                text: "Categories",
              ),
              
              //Sencond tab to view the favorites.
              Tab(
                icon: Icon(Icons.star), 
                text: "Favorites",
              ),
            ],
          ),
        ),

        // here the body is configuring with the pages to open when click on tabs. Order of tabs and screen file must be take care of.
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(), //FavoritesScreen(),
          ],
        ),
      ),

    );
  }
}