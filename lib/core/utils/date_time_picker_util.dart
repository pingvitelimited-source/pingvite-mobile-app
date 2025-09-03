import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

class DateTimePickerUtil {
  static Future<String?> pickDateTime(BuildContext context) async {
    final now = DateTime.now();
    DateTime? selected;

    if (Platform.isIOS) {
      // iOS Cupertino picker (bottom sheet)
      selected = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (_) {
          DateTime temp = now;
          return Container(
            height: 250,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: now,
                    minimumDate: DateTime(2000),
                    maximumDate: DateTime(2100),
                    onDateTimeChanged: (dt) => temp = dt,
                  ),
                ),
                CupertinoButton(
                  child: const Text("Done"),
                  onPressed: () => Navigator.of(context).pop(temp),
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Android Material picker
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate == null) return null;

      if (!context.mounted) return null;
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
      );
      if (pickedTime == null) return null;

      selected = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    }

    if (selected == null) return null;

    // Format as String
    return DateFormat("dd-MM-yyyy HH:mm").format(selected);
  }
}
