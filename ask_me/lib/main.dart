import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(AskMeAnything());
}

class AskMeAnything extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AskMeAnythingState createState() => _AskMeAnythingState();
}

class _AskMeAnythingState extends State<AskMeAnything> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade700,
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 110,
          toolbarHeight: 90,
          backgroundColor: Colors.blueGrey.shade900,
          title: Text(
            "Ask Me Anything",
            textAlign: TextAlign.center,
          ),
        ),
        body: AskMe(),
      ),
    );
  }
}

class AskMe extends StatefulWidget {
  const AskMe({Key key}) : super(key: key);

  @override
  _AskMeState createState() => _AskMeState();
}

class _AskMeState extends State<AskMe> {
  int randomAnsersNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FlatButton(
          onPressed: () {
            setState(() {
              randomAnsersNumber = Random().nextInt(5) + 1;
            });
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Image.asset('images/ball$randomAnsersNumber.png'),
        ),
      ),
    );
  }
}
