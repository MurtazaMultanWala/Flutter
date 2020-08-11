import '../widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName= '/filters';
  final Map<String, bool> currentfilters;
  final Function saveFiltersHandler;

  FiltersScreen(this.currentfilters, this.saveFiltersHandler);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.currentfilters['gluten'];
    _vegeterian = widget.currentfilters['vegeterian'];
    _vegan = widget.currentfilters['vegan'];
    _lactoseFree = widget.currentfilters['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String subTitle, bool currentValue, Function updateValue)
  {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subTitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            // the given handler is triggered when save button is pressed and then it will link with save filter method in main.dart file using this handler.
            onPressed: (){
              Map<String, bool> mySelectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                "vegan": _vegan,
                "vegeterian": _vegeterian,
              };

              widget.saveFiltersHandler(mySelectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),   
      
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          
          //Expanded takes the remianinf column space 
          Expanded(
            child: ListView(
              children: <Widget>[
                
                _buildSwitchListTile(
                  "Gluten-Free",
                  'Only include gluten-free meals.',
                  _glutenFree,
                  (newValue){
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }
                ),

                
                _buildSwitchListTile(
                  "Lactose-Free",
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (newValue){
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }
                ),

                
                _buildSwitchListTile(
                  "Vegetarian",
                  'Only include vegeterian meals.',
                  _vegeterian,
                  (newValue){
                    setState(() {
                      _vegeterian = newValue;
                    });
                  }
                ),

                
                _buildSwitchListTile(
                  "Vegan",
                  'Only include vegan meals.',
                  _vegan,
                  (newValue){
                    setState(() {
                      _vegan = newValue;
                    });
                  }
                ),
              ],
            ),
          ),
        ],     
      ),
    );
  }
}