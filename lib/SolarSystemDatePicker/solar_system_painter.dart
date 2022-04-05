import 'dart:math' as math;

import 'package:flutter/material.dart';

class SolarSystemPainter extends CustomPainter {
  BoxConstraints constraints;
  Color color;
  double scale;
  double earthAngle;

  Offset? earthPos;
  Offset? sysCenter;
  double? earthRad;

  SolarSystemPainter({
    required this.color,
    this.scale = 0.9,
    required this.constraints,
    required this.earthAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var bgPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.transparent;
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, bgPaint);

    Paint paintSun = Paint()..color = Colors.yellow;
    Paint paintEarth = Paint()..color = Colors.blue;
    Paint paintTrajectory = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Offset center = Offset(size.width / 2, size.height / 2);
    sysCenter = center;

    final sunPos = Offset(center.dx - 45 * scale, center.dy * scale);
    canvas.drawCircle(sunPos, 32 * scale, paintSun);

    double a = constraints.maxWidth * 0.9 / 2;
    double b = constraints.maxHeight * 0.9 / 2;
    canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: a * 2,
          height: b * 2,
        ),
        paintTrajectory);

    double k = math.tan(earthAngle);
    double earthCenterX = k == double.nan
        ? 0.0
        : a * b / math.sqrt(b * b + k * k * a * a) * math.cos(earthAngle).sign;
    double earthCenterY =
        k == double.nan ? math.sin(earthAngle).sign * a : k * earthCenterX;

    earthPos = Offset(earthCenterX, earthCenterY) + center;

    canvas.drawCircle(earthPos!, 12, paintEarth);

    final textPainter = TextPainter(
      text: const TextSpan(text: '🌏', style: TextStyle(fontSize: 30)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    Size _sz = textPainter.size / 2;
    earthRad = _sz.width;
    textPainter.paint(canvas, earthPos! - Offset(_sz.width, _sz.height));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
