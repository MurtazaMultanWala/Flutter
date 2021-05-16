import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(Xylophone());

class Xylophone extends StatelessWidget {
  void playTone(int toneNumber) {
    final AudioCache audioCache = new AudioCache();
    audioCache.play('note$toneNumber.wav');
  }

  Expanded getCustomColorPlayTile({Color providedColor, int toneNumber}) {
    return Expanded(
      child: FlatButton(
        color: providedColor,
        onPressed: () {
          playTone(toneNumber);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              getCustomColorPlayTile(
                providedColor: Colors.red,
                toneNumber: 1,
              ),
              getCustomColorPlayTile(
                providedColor: Colors.orange,
                toneNumber: 2,
              ),
              getCustomColorPlayTile(
                providedColor: Colors.yellow,
                toneNumber: 3,
              ),
              getCustomColorPlayTile(
                providedColor: Colors.teal.shade700,
                toneNumber: 4,
              ),
              getCustomColorPlayTile(
                providedColor: Colors.green.shade400,
                toneNumber: 5,
              ),
              getCustomColorPlayTile(
                providedColor: Colors.blue,
                toneNumber: 6,
              ),
              getCustomColorPlayTile(
                providedColor: Colors.purple,
                toneNumber: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
