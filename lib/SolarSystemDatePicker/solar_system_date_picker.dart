import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:solar_system_date_picker/SolarSystemDatePicker/utils.dart';
import 'solar_system_painter.dart';

class SolarSystemDatePicker extends StatefulWidget {
  final void Function(DateTime)? onChanged;
  final BoxConstraints constraints;
  const SolarSystemDatePicker(
      {Key? key, this.onChanged, required this.constraints})
      : super(key: key);

  @override
  State<SolarSystemDatePicker> createState() => _SolarSystemDatePickerState();
}

class _SolarSystemDatePickerState extends State<SolarSystemDatePicker> {
  late DateTime dt;
  late double angle;
  late SolarSystemPainter _painter;
  bool _isHandlerSelected = false;

  @override
  void initState() {
    super.initState();
    dt = DateTime(2022, 6);
    angle = dateTimeToAngle(dt);
    _painter = SolarSystemPainter(
        color: Colors.blue, constraints: widget.constraints, earthAngle: angle);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => _onPanUpdate(context, details),
      onPanDown: (details) => _onPanDown(context, details),
      onPanEnd: (details) => _onPanEnd(context, details),
      child: CustomPaint(
        child: Container(color: Colors.transparent),
        painter: _painter,
      ),
    );
  }

  _onPanDown(context, DragDownDetails details) {
    if (_painter.earthPos == null) return;
    if (isPtInCircle(
      details.localPosition,
      _painter.earthPos!,
      _painter.earthRad!,
      25,
    )) {
      _isHandlerSelected = true;
    } else {
      _isHandlerSelected = false;
    }
  }

  _onPanEnd(context, DragEndDetails details) {
    if (_painter.earthPos == null) return;
    _isHandlerSelected = false;
  }

  _onPanUpdate(context, DragUpdateDetails details) {
    if (!_isHandlerSelected) return;
    if (_painter.earthPos == null) return;

    Offset _ = details.localPosition - _painter.sysCenter!;

    setState(() {
      angle = math.atan2(_.dy, _.dx);
      _painter = SolarSystemPainter(
          color: Colors.blue,
          constraints: widget.constraints,
          earthAngle: angle);
    });

    if (widget.onChanged != null) {
      print(angleToDateTime(angle, dt.year));
      widget.onChanged!(angleToDateTime(angle, dt.year));
    }
  }
}
