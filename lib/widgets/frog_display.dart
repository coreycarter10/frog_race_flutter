import 'package:flutter/material.dart';

import '../models/frog.dart';

class FrogDisplay extends StatefulWidget {
  final Frog frog;
  final double width;
  final double height;
  final bool spotlight;

  FrogDisplay(
      {Key key,
      @required this.frog,
      @required this.width,
      @required this.height,
      this.spotlight = false})
      : super(key: key);

  @override
  _FrogDisplayState createState() => _FrogDisplayState();
}

class _FrogDisplayState extends State<FrogDisplay> with SingleTickerProviderStateMixin {
  static final tween = Tween<double>(begin: 1, end: 15);

  AnimationController _animCtrl;
  Animation _anim;

  @override
  void initState() {
    super.initState();

    _animCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.spotlight && _anim == null) {
      _anim = tween.animate(_animCtrl)
        ..addListener(_glow)
        ..addStatusListener(_glowComplete);

      _animCtrl.forward();
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.spotlight ? BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(255, 255, 255, .5),
            blurRadius: _anim?.value ?? tween.end,
            spreadRadius: _anim?.value ?? tween.end,
          ),
        ],
      ) : null,
      child: Image.asset(
        'assets/images/frog.png',
        color: frogColorToColor(widget.frog.color),
        fit: BoxFit.fill,
      ),
    );
  }

  void _glow() {
    setState(() {

    });
  }

  void _glowComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _anim
        ..removeListener(_glow)
        ..removeStatusListener(_glowComplete);

      _anim = null;

      _animCtrl.reset();
    }
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
