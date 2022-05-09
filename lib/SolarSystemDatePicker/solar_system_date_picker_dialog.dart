import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'solar_system_date_picker.dart';

class SolarSystemDatePickerDialog extends StatefulWidget {
  final void Function(DateTime)? onConfirm;
  const SolarSystemDatePickerDialog({Key? key, this.onConfirm})
      : super(key: key);

  @override
  State<SolarSystemDatePickerDialog> createState() =>
      _SolarSystemDatePickerDialogState();
}

class _SolarSystemDatePickerDialogState
    extends State<SolarSystemDatePickerDialog> {
  late DateTime picked;

  @override
  void initState() {
    super.initState();
    picked = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 252,
                  child: SolarSystemDatePicker(
                    onChanged: (v) {
                      setState(() {
                        picked = v;
                      });
                    },
                    constraints: BoxConstraints(
                      maxHeight: 252,
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                ),
              ),
              Text(
                DateFormat('dd.MM.yyyy').format(picked).toString(),
                style: const TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.onConfirm != null) {
                    widget.onConfirm!(picked);
                  }
                  Navigator.pop(context);
                },
                child: const Text('ok'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
