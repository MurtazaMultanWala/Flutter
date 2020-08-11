import 'package:flutter/material.dart';
import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  
  final List<Transaction> userTransaction;
  final Function deleteTransactionHandler;
  
  TransactionList(this.userTransaction, this.deleteTransactionHandler);
  
  @override
  Widget build(BuildContext context) {
    return  userTransaction.isEmpty 
    ? Column(
        children: <Widget>[
          Text(
            "No Transactions added yet!", 
            style: Theme.of(context).textTheme.title,
          ),
          
          SizedBox(
            height: 20,
          ),

          Container(
            height: 200,
            
            child: Image.asset("assets/images/waiting.png", 
            fit: BoxFit.cover,
            ),
          
          )

        ],) 
    : ListView(
        children: userTransaction
          .map((tx)=>TranscationItem(
            key: ValueKey(tx.id),
            transaction: tx, 
            deleteTransactionHandler: deleteTransactionHandler
          )).toList() 
        );
  }
}


/*
  ListView.builder(  
    itemBuilder: (context, index){
      return TranscationItem(transaction: userTransaction[index], deleteTransactionHandler: deleteTransactionHandler);
    },
      
    itemCount: userTransaction.length,
    
    // children: userTransaction.map((tx) {}).toList(),
  
  );
*/


/*
  return Card(

    child: Row(
      
      children: <Widget>[
        
        Container(
          
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          
          decoration: BoxDecoration(
            
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          
          ),
          
          padding: EdgeInsets.all(10),
          
          child: Text(
            '\$${userTransaction[index].amount.toStringAsFixed(2)}',
            
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          
          ),
        
        ),
        
        
        Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
            
            Text(
              userTransaction[index].title,
              
              style: Theme.of(context).textTheme.title,
            
            ),
            
            Text(
              DateFormat.yMMMd().format(userTransaction[index].date),
              
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            
            ),
          
          ],
        
        ),
      
      ],
    
    ),

  );
*/