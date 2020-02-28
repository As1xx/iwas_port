import 'package:flutter/material.dart';

class ShapesPainter extends CustomPainter {

  Color triangleColor;
  ShapesPainter({this.triangleColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = triangleColor;

    // create a path
    var path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(0.5*size.width, size.height);
    path.lineTo(size.width, 0.5*size.height);
    // close the path to form a bounded shape
    path.close();

    canvas.drawPath(path, paint);
  }



  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }



}