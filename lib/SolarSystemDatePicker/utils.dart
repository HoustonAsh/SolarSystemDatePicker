import 'dart:math' as math;
import 'package:flutter/material.dart';

bool isPtInCircle(Offset pos, Offset center, double rad, double width) {
  var dx = math.pow(pos.dx - center.dx, 2);
  var dy = math.pow(pos.dy - center.dy, 2);
  var distance = math.sqrt(dx + dy);
  return (distance - rad).abs() < width;
}

double dateTimeToAngle(DateTime _dt) {
  int days = _dt.difference(DateTime(_dt.year)).inDays;

  return days /
          (365 +
              ((_dt.year % 400 == 0 ||
                      (_dt.year % 4 == 0 && _dt.year % 100 != 0))
                  ? 1
                  : 0)) *
          math.pi *
          2 +
      math.pi;
}

DateTime angleToDateTime(double angle, int year) {
  DateTime ans = DateTime(year);

  int days = (angle /
          (math.pi * 2) *
          (365 +
              ((year % 400 == 0 || (year % 4 == 0 && year % 100 != 0))
                  ? 1
                  : 0)))
      .round()
      .toInt();

  return ans.add(Duration(days: days + (365 / 2).ceil()));
}
