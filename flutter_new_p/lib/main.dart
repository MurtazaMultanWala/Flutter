import 'package:flutter/material.dart';
import './question.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
    @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(home: Text("Hello!"));
  // }
  var _questionIndex =  0;
  var questions = ["What's You Name?", 
                  "What's your fav color?",];
  
  void _answerQuestion()
  { 
    setState(() {
      if(_questionIndex == 0)
        _questionIndex=1;
      else
        _questionIndex=0;
    });
    
    print(_questionIndex);
    print("Answer Selected!");
  } 

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text('My First App'),
            ),
            body: Column(
              children: <Widget>[
                Question(questions[_questionIndex]),
            RaisedButton(
              child: Text("Answer 1"),
              onPressed: _answerQuestion,
            ),
            RaisedButton(
              child: Text("Answer 2"),
              onPressed: () => print("Anwser 2 Chosen"),
            ),
            RaisedButton(
              child: Text("Answer 3"),
              onPressed: () => print("Anwser 3 Chosen"),
            )
          ],
        ),
      ),
    );
  }
}
