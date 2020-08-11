import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transactions.dart';
import './widgets/transaction_list.dart';

import './models/transaction.dart';

void main() { 
  // // disabling the landscape mode option.
  // SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.portraitUp,
  //   ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        
        textTheme: ThemeData.light().textTheme.copyWith(
          // Theme for all titles not specific to App Bar
          title: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
          ),

          button: const TextStyle(
            color: Colors.white,
          ),
        ),

        appBarTheme: AppBarTheme(
          // text theme for app bar
          textTheme: ThemeData.light().textTheme.copyWith(   
            // theme applied to all "title" tags of the App Bars 
            title: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      
      ),
      home: MyHomePage(),
    );
  }
}
      
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: "New Shoes",
    //   amount: 66.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: "Weekly Groceries",
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;
 
  
  List<Transaction> get _recentTransactions {
    return _userTransaction.where( (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){
    
    final newTransaction = Transaction(
      title: txTitle, 
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString()
    );

    setState(() {
      _userTransaction.add(newTransaction);
    });
  }
  
  void _startAddNewTransaction(BuildContext ctx){

    showModalBottomSheet(
      context: ctx, 
      builder: (context){
        return GestureDetector( 
          onTap: (){},
          child:  NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,  //this catches the tap on the screen, closes when tap on background, not on the sheet.

        );
      },  //returns the widget
    );
  }


  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere(
        (tx)=> tx.id == id
      );
    });

  }


  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, AppBar appBar, Widget transactionListWidget,){
    
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Text(
            "Show Chart",
            style: Theme.of(context).textTheme.title,
          ),
          
          Switch.adaptive(  // switch design acc to the plateform
            activeColor:  Theme.of(context).accentColor,
            value: _showChart,

            onChanged: (val){
              setState(() {
                _showChart = val; 
              });
            },
            
          ),

        ],
      ),
      
      _showChart 
      ? Container( 
          height: ( 
            mediaQuery.size.height - 
            appBar.preferredSize.height - 
            mediaQuery.padding.top 
          ) * 0.6,
          
          child: Chart(_recentTransactions), 
        )    
      :  transactionListWidget,
    ];
  }


  List<Widget> _buildPotraitContent(MediaQueryData mediaQuery, AppBar appBar, Widget transactionListWidget,){
    return [
      Container(
        height: ( 
          mediaQuery.size.height - 
          appBar.preferredSize.height - 
          mediaQuery.padding.top 
        ) * 0.3,
        
        child: Chart(_recentTransactions),
      ), 
      transactionListWidget
    ];
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandScape = mediaQuery.orientation == Orientation.landscape;
   
    final PreferredSizeWidget appBar = Platform.isIOS 
    ? CupertinoNavigationBar(
      middle: Text("Personal Expense Planner"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),

    )
    : AppBar(
        title: Text("Personal Expense Planner"),
        actions: <Widget>[
        
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        
        ],
      );

    final transactionListWidget = Container(
              height: ( mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top ) * 0.7,
              child: TransactionList(_userTransaction, _deleteTransaction),
            );

    final pageBody = SafeArea ( 
      
      child: SingleChildScrollView(
        
        child: Column(
          
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,  
          
          children: <Widget>[

            if(isLandScape) 
            
            // ... means pull all element out of this list and merge 
            // them as single element to the sorrounding list above.
            
            ... _buildLandscapeContent(
              mediaQuery, 
              appBar, 
              transactionListWidget,
            ),
            
            if(!isLandScape) 
            
            // ... means pull all element out of this list and merge 
            // them as single element to the sorrounding list above.
            
            ... _buildPotraitContent(
              mediaQuery, 
              appBar, 
              transactionListWidget,
            ), 
            
          ],
            
        ),
     
      ),

    );
     

    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
    ) : Scaffold(
      appBar: appBar,
    
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      floatingActionButton: Platform.isIOS ? Container() 
      : FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
      ),  
        
    );
  } 
}
