import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/quizzlersBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzler',
      home: Scaffold(
        backgroundColor: Colors.white10,
        body: SafeArea(
          child: QuizzlerBody(title: 'Quizzler'),
        ),
      ),
    );
  }
}

class QuizzlerBody extends StatefulWidget {
  QuizzlerBody({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuizzlerBodyState createState() => _QuizzlerBodyState();
}

class _QuizzlerBodyState extends State<QuizzlerBody> {
  QuizzlersBrain _quizzlersBrain = new QuizzlersBrain();

  List<Icon> _resultsIconList = [];

  void _checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = _quizzlersBrain.getCorrectAnswer();

    setState(
      () {
        if (_quizzlersBrain.isFinished() == false) {
          if (userPickedAnswer == correctAnswer) {
            _resultsIconList.add(
              Icon(
                Icons.check,
                color: Colors.teal,
              ),
            );
          } else {
            _resultsIconList.add(
              Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
          }
          _quizzlersBrain.nextQuestion();
        } else {
          int _correctAnswerCount = _resultsIconList
              .map((icon) => icon.color == Colors.red)
              .where((item) => item == false)
              .length;

          int _totalQuestionCount = _resultsIconList.length;

          Alert(
            context: context,
            title: 'Finished!',
            desc:
                'You\'ve reached the end of the quiz. \nYour score is: $_correctAnswerCount out of $_totalQuestionCount',
          ).show();
          _quizzlersBrain.resetGame();
          _resultsIconList = [];
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _quizzlersBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.teal.shade400,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                _checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red.shade700,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                _checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: _resultsIconList,
        ),
      ],
    );
  }
}
