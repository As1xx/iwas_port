import 'package:flutter/material.dart';
import 'package:iwas_port/Models/ShapesPainter.dart';

class Background extends StatelessWidget {
  final child;
  Background({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: CustomPaint(
          painter: ShapesPainter(triangleColor: Theme.of(context).accentColor),
          child: child,
        ));
  }
}
