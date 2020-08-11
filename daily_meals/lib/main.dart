import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_Screen.dart';
import './screens/categories_meals_screen.dart';
import './screens/categories_screen.dart';
import './models/meal.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    "vegan": false,
    "vegeterian": false,
  };

  // to load the meals after applying filters then pass to the category meal file so can display meals acoordingly.
  List<Meal> _availableMeals = DUMMY_MEALS;

  // to store the favorites. So now to add them into fav. we pas it using tab screen beacuse we donot haice favorite screen route registered 
  // in main.dart file but tab screen has it.
  List<Meal> _favoriteMeals = [];


  void _setfilters(Map<String, bool> filterDataSettings)
  {
    setState(() {
      _filters = filterDataSettings;

      _availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegeterian'] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }


  // this method should called whenever the fav button is tab so passing this function to mealdetail screen for floating button on tap action.
  void _toggleFavorite(String mealId){
    /* 
      problem!! whenever you toggle favorite add or remove the vuild method will be called because of
      SetState() method this will cause rebuild/reloading the entire app. This is state management 
      issue will discuss in next module.
    */
    // checking whether the meal is already in favorite or not.  if yes then return -1 else return the index of that meal. 
    final int existingIndex = _favoriteMeals.indexWhere((meal)=> meal.id == mealId,);

    if (existingIndex >=0 ){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere( (meal)=> meal.id == mealId ));
      }); 
    }
  }


  bool _isFavoriteMeal(String idMeal){
    return _favoriteMeals.any((meal)=> meal.id == idMeal);

  }

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Meal',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData( 
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        
        textTheme: ThemeData.light().textTheme
          .copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),  
            ),

            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),  
            ),

            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      
      // home: CategoriesScreen(),
      initialRoute: '/', //default is '/' home page. 
      routes: {  // its takes map as a value
          
          // page routes key is page reference name i.e. route and value is 
          //that page file reference using context which is provide by flutter
         
         '/': (ctx)=> TabsScreen(_favoriteMeals), //for loaidng homepage alt
        
        //  '/category-meals': (ctx)=> CategoriesMealsScreen(),
        //alt for above one preent error chances
        CategoriesMealsScreen.routeName: (ctx)=> CategoriesMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx)=>MealDetailScreen(_toggleFavorite, _isFavoriteMeal),
        FiltersScreen.routeName: (ctx)=> FiltersScreen(_filters ,_setfilters),        
      },

      // these two methods are for the unusual navigation on screen if it is not registered in the route table then
      // in that case display something rather than crashing or other stuff.
      onGenerateRoute: (settings){
        print(settings.arguments);
        
        return MaterialPageRoute(
          builder: (ctx)=> CategoriesScreen(),
        );
      },

      // if flutter failed to load any of the routes i.e. in case of route table is empty and onGenerated route also fails
      // so in last it will check onUnknown route before throwing the error.
      onUnknownRoute: (settings){
        return MaterialPageRoute(
          builder: (ctx)=> CategoriesScreen(),
        );
      },

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Meal"),
      ),
      body: Center(
        child: Text('Navigation Times!'),
      ),
    );    
  }
}
