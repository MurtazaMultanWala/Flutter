import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';


class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
 // keeping just the list of screen works fine but it dosenot chnage the title of appbar when tabs are changed so fixing that we have to tweak the list little bit.
//  final List<Widget> _pagesToRender =[

  List<Map<String,Object>> _pagesToRender;
  
  int _selectedPageIndex = 0; 
  
  
  @override
  void initState() {
    _pagesToRender =[
      {
      'page': CategoriesScreen(), 
      'title': 'Categories'
      },

      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorite'
      },
    ];
    super.initState();
  }

 void _selectPage(int index) {
    
    setState(() {
      _selectedPageIndex = index;
    });
  }
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagesToRender[_selectedPageIndex]['title']),
      ),

      drawer: MainDrawer(),
      // here the body is configuring with the pages to open when click on tabs. Order of tabs and screen file must be take care of.
      body: _pagesToRender[_selectedPageIndex]['page'],

      // By name it is clear that the tab bar is added at the bottom so for that we have to ad it manually
      bottomNavigationBar: BottomNavigationBar(
        
        //flutter by default sends the index of the page it is tapped through on tap arg.
        onTap: _selectPage,
        
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        
        // _SelectedPageIndex chances on each tab pressing. thats why keep iniside setState()
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        
        //here we will add tabs same like we add in default tab bar
        items: [
          
          // Tab for categories page
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category), 
            title: Text('Categories'), 
          ),

          //Tab for favorites page
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star), 
            title: Text('Favorites'), 
          ),

        ],
      ),
    ); 
          }
        
          
}