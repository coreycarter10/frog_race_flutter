import 'dart:math' show min;

import 'package:meta/meta.dart';

import 'race.dart';

class Frog {
  final FrogColor color;
  final int position;

  Frog({@required this.color, this.position = 0});

  Frog move([int spaces = 1]) =>
      Frog(color: color, position: min(position + spaces, Race.winningPosition));

  @override
  String toString() {
    final track = List<String>.generate(Race.winningPosition + 1, (int i) {
      return i != position ? '-' : 'F';
    });

    return "${track.join()}   $color ($position)";
  }
}

enum FrogColor {
  red,
  yellow,
  green,
  blue,
  orange,
  pink,
}