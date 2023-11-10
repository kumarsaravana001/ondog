import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1
 
    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3333333, size.height * 0.1442857);
    path_0.lineTo(size.width * 0.6666667, size.height * 0.1442857);
    path_0.lineTo(size.width * 0.6666667, size.height * 0.2871429);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.3571429);
    path_0.lineTo(size.width * 0.3333333, size.height * 0.2871429);
    path_0.lineTo(size.width * 0.3333333, size.height * 0.1442857);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
