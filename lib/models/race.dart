import 'dart:math';

import 'frog.dart';

class Race {
  static const winningPosition = 8;

  final Map<FrogColor, Frog> _frogs;
  Map<FrogColor, Frog> get frogs => Map.unmodifiable(_frogs);

  Race(this._frogs);

  factory Race.newGame() {
    final Map<FrogColor, Frog> frogs = {};

    for (FrogColor color in FrogColor.values) {
      frogs[color] = Frog(color: color);
    }

    return Race(frogs);
  }

  Race go() => _moveFrogs(Roller.rollFrogColorDie(), Roller.rollFrogColorDie());

  Race _moveFrogs(FrogColor frog1, FrogColor frog2) {
    _frogs[frog1] = _frogs[frog1].move();
    _frogs[frog2] = _frogs[frog2].move();

    return Race(_frogs);
  }

  bool isWinner(Frog frog) => frog.position >= winningPosition;

  List<Frog> get winners => _frogs.values.where(isWinner).toList();
  bool get hasWinner => _frogs.values.any(isWinner);
  int get numFrogs => _frogs.length;

  @override
  String toString() => _frogs.values.map((Frog frog) => frog.toString()).toList().join('\n');
}

class Roller {
  static const testIterations = 10000;

  static Random _random = Random(DateTime.now().millisecondsSinceEpoch);

  static int rollDie(int sides) => _random.nextInt(sides) + 1;

  static FrogColor rollFrogColorDie() => FrogColor.values[_random.nextInt(FrogColor.values.length)];


  static Map<int, int> testDie(int sides) {
    final keys = List<int>.generate(sides, (int i) => i + 1);
    final values = List<int>.filled(sides, 0);
    final resultTable = Map<int, int>.fromIterables(keys, values);

    for (int i = 0; i < testIterations; i++) {
      resultTable[rollDie(sides)]++;
    }

    return resultTable;
  }

  static Map<FrogColor, int> testFrogColorDie() {
    final sides = FrogColor.values.length;

    final keys = List<FrogColor>.from(FrogColor.values);
    final values = List<int>.filled(sides, 0);
    final resultTable = Map<FrogColor, int>.fromIterables(keys, values);

    for (int i = 0; i < testIterations; i++) {
      resultTable[rollFrogColorDie()]++;
    }

    return resultTable;
  }
}