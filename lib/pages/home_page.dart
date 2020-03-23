import 'package:flutter/material.dart';

import '../models/race.dart';
import '../models/frog.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const animationDuration = Duration(milliseconds: 250);

  Race _race;

  @override
  void initState() {
    super.initState();

    _newRace();
  }

  void _newRace() {
    _race = Race.newGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              setState(() {
                // TODO: Disable play button period.
                // TODO: Wait for duration then check for winners and re-enable play button.
                // TODO: Create dialog box when winner occurs.
                _race.go();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
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

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (Frog frog in frogs.values)
                Container(
                  margin: EdgeInsets.all(trackPadding),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  width: trackWidth,
                  child: Stack(
                    children: <Widget>[
                      AnimatedPositioned(
                        duration: animationDuration,
                        left: frogCenter,
                        bottom: frog.position * frogHeight,
                        child: Container(
                          width: frogWidth,
                          height: frogHeight,
                          child: Image.asset(
                            'assets/images/frog.png',
                            color: frogColorToColor(frog.color),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

Color frogColorToColor(FrogColor fc) {
  switch (fc) {
    case FrogColor.red:
      return Colors.red;
      break;
    case FrogColor.yellow:
      return Colors.yellow;
      break;
    case FrogColor.green:
      return Colors.green;
      break;
    case FrogColor.blue:
      return Colors.blue;
      break;
    case FrogColor.orange:
      return Colors.orange;
      break;
    case FrogColor.pink:
      return Colors.pink;
      break;
    default:
      return null;
  }
}
