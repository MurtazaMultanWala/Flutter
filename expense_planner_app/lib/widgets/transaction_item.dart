import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TranscationItem extends StatefulWidget {

  
  const TranscationItem({
    
    // The key argument is always accepted inside root level widget
    // Since our Listview calls TransactionItem for displaying the transactions
    // therefore key argument is accepted here to solve the issues
    // (i.e. for now circle avatar color) when removing an item.
    
    Key key,
    @required this.transaction,
    @required this.deleteTransactionHandler,
  }) : super(key: key); 
  // super intializes the parent class on change to forward key to the base widget so flutter knows what to do with it.

  final Transaction transaction;
  final Function deleteTransactionHandler;

  @override
  _TranscationItemState createState() => _TranscationItemState();
}


class _TranscationItemState extends State<TranscationItem> {

  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      
      margin: const EdgeInsets.symmetric(
        vertical : 8,
        horizontal : 5,
      ),
                
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount}'
              ),
            ),
          ),
        ),

        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),

        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),

        trailing: MediaQuery.of(context).size.width > 360 
        ? FlatButton.icon(
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
          textColor: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTransactionHandler(widget.transaction.id),
        )
        : IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: ()=> widget.deleteTransactionHandler(widget.transaction .id),
        ),
        
      ),
    );
  }
}