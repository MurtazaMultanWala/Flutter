import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  final Function addNewTransactionHandler;

  NewTransaction(this.addNewTransactionHandler){
    print("Constructor NewTransaction Widget");
  }

  @override
  _NewTransactionState createState() {
    print("createState NewTransaction Widget");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState(){
    print("Constructor NewTransaction State");
  }

  @override
  void initState() {
    //used to fetch initial data you need for the app or widget 
    print("InitState()");
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    //Executes when changes are done in parent widget and refetch in the state also give access to old widget
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // executes when state is removed, used for cleanup data like cleaning up live data, listeneres etc.
    print('dispose()');
    super.dispose();
  }

  void _submitData(){

    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text;
    
    if (enteredTitle.isEmpty)
      return;
    else if(enteredAmount.isEmpty || double.parse(enteredAmount)<=0)
      return;
    else if (_selectedDate == null)
      return;


    widget.addNewTransactionHandler(
      enteredTitle, 
      double.parse(enteredAmount),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatepicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2020), 
      lastDate: DateTime.now(),
    ).then((pickedDate){
      
      if(pickedDate == null)
        return;

      setState(() {
        _selectedDate = pickedDate;
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
        
        elevation: 5,
        
        child: Container(
          
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 10,
            right: 10,
            top: 10,
          ),
          
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,

            children: <Widget>[
              
              TextField(
                decoration: InputDecoration(labelText: 'Title'),

                controller: _titleController,
                onSubmitted: (_) => _submitData,
                // onChanged: (inputTitle){
                //   titleInput = inputTitle;
                // },
              ),
              
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: _amountController, 
                onSubmitted: (_) => _submitData(),
                // onChanged: (inputAmount){
                //   amountInput = inputAmount;
                // }
              ),
              
              Container(
                height: 70,

                child: Row(children: <Widget>[
                  
                  Expanded(
                    
                    child: Text(
                      _selectedDate == null ? "No date Chosen!" : 
                      'Picked Date: ' + '${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  
                  AdaptiveFlatButton("Choose Date", _presentDatepicker),
                
                ],
                ),
              ),
              

              RaisedButton(
                child: Text('Add Transaction'),
                onPressed: () => _submitData(),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            
            ],
         
          ),
        
        ),
      
      ),
    );
  }
}
