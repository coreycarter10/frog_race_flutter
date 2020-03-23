import 'dart:async';

import 'package:flutter/material.dart';
import 'package:awesome_button/awesome_button.dart';

import '../models/race.dart';
import '../models/frog.dart';
import '../widgets/frog_display.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const animationDuration = Duration(milliseconds: 250);

  Race _race;
  
  bool _climbEnabled;

  @override
  void initState() {
    super.initState();

    _newRace();
  }

  void _newRace() {
    _race = Race.newGame();
    
    _climbEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 30,
            fontFamily: "Lacquer",
            color: Colors.black,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.orange,
                Colors.pink,
              ],
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.black,
            onPressed: () {
              setState(() {
                _newRace();
              });
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Map<FrogColor, Frog> frogs = _race.frogs;
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final trackPadding = w * .01;
          final trackWidth = (w / _race.numFrogs) - (trackPadding * 2);
          final trackHeight = h - trackPadding * 2;
          final frogWidth = trackWidth * .75;
          final frogHeight = trackHeight / (Race.winningPosition + 1);
          final frogCenter = (trackWidth / 2) - (frogWidth / 2);

          return Stack(
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bark.png'),
                    repeat: ImageRepeat.repeat,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (Frog frog in frogs.values)
                      Container(
                        margin: EdgeInsets.all(trackPadding),
                        width: trackWidth,
                        child: Stack(
                          children: <Widget>[
                            AnimatedPositioned(
                              duration: animationDuration,
                              left: frogCenter,
                              bottom: (frog.position + 1) * (frogHeight * .85),
                              child: FrogDisplay(
                                frog: frog,
                                width: frogWidth,
                                height: frogHeight,
                                spotlight: _race.isWinner(frog),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: h * .01),
                child: Visibility(
                  visible: !_race.hasWinner,
                  child: AwesomeButton(
                    blurRadius: 10.0,
                    color: Colors.lightGreenAccent,
                    splashColor: Color.fromRGBO(0, 255, 0, .4),
                    borderRadius: BorderRadius.circular(37.5),
                    width: w * .2,
                    height: h * .05,
                    onTap: _climbEnabled ? _climb : null,
                    child: Text(
                      'Climb!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: h * .025,
                        fontFamily: 'Lacquer',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _climb() {
    setState(() {
      _climbEnabled = false;
      _race.go();

      Timer(animationDuration, _checkWin);
    });
  }

  void _checkWin() {
    if (_race.hasWinner) {
      print("WINNER(S): ${_race.winners}");
    }
    else {
      setState(() {
        _climbEnabled = true;
      });
    }
  }
}
