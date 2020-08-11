import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {

  final Function presentDatePickerHandler;
  final String text;

  AdaptiveFlatButton(this.text, this.presentDatePickerHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
    ? CupertinoButton(
      
      child: Text(
        text, 
        
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      
      ),
      
      onPressed: presentDatePickerHandler,

    ) 
    : FlatButton(
      textColor: Theme.of(context).primaryColor,
      
      child: Text(
        text, 
        
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      
      ),
      
      onPressed: presentDatePickerHandler,

    );
  }
}