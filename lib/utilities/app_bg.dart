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

class Hometopshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0008333, size.height * 0.0014286);
    path_0.lineTo(size.width * 1.0008333, size.height * -0.0028571);
    path_0.lineTo(size.width * 1.0008333, size.height * 0.8571429);
    path_0.lineTo(size.width * 0.5000000, size.height);
    path_0.lineTo(size.width * -0.0008333, size.height * 0.8571429);
    path_0.lineTo(size.width * -0.0008333, size.height * 0.0014286);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class StackHometopshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0008333, size.height * 0.0014286);
    path_0.lineTo(size.width * 0.9991667, size.height * -0.0014286);
    path_0.lineTo(size.width * 0.9991667, size.height * 0.8585714);
    path_0.lineTo(size.width * 0.5008333, size.height * 1.0014286);
    path_0.lineTo(size.width * -0.0008333, size.height * 0.8600000);
    path_0.lineTo(size.width * 0.0008333, size.height * 0.0014286);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Hometopshapelogin extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5016667, size.height * -0.0028571);
    path_0.lineTo(size.width * 1.0025000, size.height * 0.2142857);
    path_0.lineTo(size.width * 1.0041667, size.height * 1.0085714);
    path_0.lineTo(size.width * 0.5000000, size.height * 1.0085714);
    path_0.lineTo(size.width * -0.0025000, size.height * 1.0085714);
    path_0.lineTo(size.width * -0.0083333, size.height * 0.2142857);
    path_0.lineTo(size.width * 0.5016667, size.height * -0.0028571);
    path_0.close();

    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
