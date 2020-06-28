import 'dart:math';

import 'package:flutter/material.dart';

class DetectorWidget extends StatefulWidget {
  @override
  _DetectorWidgetState createState() => _DetectorWidgetState();
}

class _DetectorWidgetState extends State<DetectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 300,
        height: 300,
        child: CustomPaint(
          painter: Detector(),
        ),
      ),
    );
  }
}

class Detector extends CustomPainter {
  final double startingPositionA;
  final double startingPositionB;

  Detector({this.startingPositionA = 0, this.startingPositionB = 160});

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var circle = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.lightBlue
      ..strokeWidth = 2;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    var arcBrush = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius - 40, circle);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 25),
        startingPositionA, pi / 2, false, arcBrush);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 25),
        startingPositionB, pi / 2, false, arcBrush);

    // Draw long lines
    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 6) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    // Draw small lines
    innerCircleRadius += 8;
    for (double i = 0; i < 360; i += 3) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
