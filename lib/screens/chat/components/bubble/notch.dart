import 'package:flutter/material.dart';

class Notch extends CustomPainter {
  final Color color;
  final double notchSize = 5;

  const Notch(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var path = Path();
    path.lineTo(-notchSize, 0);
    path.lineTo(0, 2 * notchSize);
    path.lineTo(notchSize, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
