import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() => runApp(FrogRace());

class FrogRace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Frog Race',
      theme: ThemeData.dark(),
      home: HomePage(title: 'Tree Frog Race'),
    );
  }
}

