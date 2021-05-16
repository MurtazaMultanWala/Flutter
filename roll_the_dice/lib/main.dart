import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(RollTheDice());
}

class RollTheDice extends StatefulWidget {
  const RollTheDice({Key key}) : super(key: key);

  @override
  _RollTheDiceState createState() => _RollTheDiceState();
}

class _RollTheDiceState extends State<RollTheDice> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  void changeDiceNumber() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.cyanAccent.shade700,
        appBar: AppBar(
            centerTitle: true,
            leadingWidth: 110,
            toolbarHeight: 90,
            leading: Image.asset('images/rolldice.png'),
            title: Text(
              'Roll The Dice',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.cyanAccent.shade700),
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: changeDiceNumber,
                  child: Image.asset('images/dice$leftDiceNumber.png'),
                ),
              ),
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: changeDiceNumber,
                  child: Image.asset('images/dice$rightDiceNumber.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
