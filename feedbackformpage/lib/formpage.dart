import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          maintainBottomViewPadding: true,
          top: true,
          child: Container(
            width: screenSize.width,
            padding: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.06,
              horizontal: screenSize.width * 0.03,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Feedback Form",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      "We would love to hear your thoughts, suggestions, concerns or problems with anthing we can improve!"),
                ),
                Divider(height: screenSize.height * 0.09),
                Text(
                  "Feedback Type",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: 1,
                      onChanged: _handleRadioValueChange,
                      groupValue: _radioValue,
                    ),
                    Text("Comments"),
                    Radio(
                      value: 2,
                      onChanged: _handleRadioValueChange,
                      groupValue: _radioValue,
                    ),
                    Text("Suggestion"),
                    Radio(
                      value: 3,
                      onChanged: _handleRadioValueChange,
                      groupValue: _radioValue,
                    ),
                    Text("Questions"),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.006),
                Text(
                  "Feedback Type",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                      value: 4,
                      onChanged: _handleRadioValueChange,
                      groupValue: _radioValue,
                    ),
                    Text("Ad"),
                    SizedBox(width: screenSize.width * 0.14),
                    Radio(
                      value: 5,
                      onChanged: _handleRadioValueChange,
                      groupValue: _radioValue,
                    ),
                    Text("App"),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.04),
                Row(
                  children: <Widget>[
                    Text(
                      "Describe Your Feedback: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.01),
                TextField(
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.15,
                          vertical: screenSize.height * 0.016),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Dismiss",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.grey,
                      onPressed: () {},
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.15,
                          vertical: screenSize.height * 0.016),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
