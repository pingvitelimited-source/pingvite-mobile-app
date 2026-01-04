import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:pingvite/core/theme/app_colors.dart';

class DateTimePickerUtil {
  static Future<String?> pickDateTime(BuildContext context) async {
    final now = DateTime.now();
    DateTime? selected;

    if (Platform.isIOS) {
      selected = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (_) {
          DateTime temp = now;
          return Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Header with Done button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: AppColors.grey),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(temp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      brightness: Brightness.light,
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: now,
                      minimumDate: DateTime(2000),
                      maximumDate: DateTime(2100),
                      backgroundColor: Colors.white,
                      onDateTimeChanged: (dt) => temp = dt,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Android Material picker - use light theme for picker dialogs
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.blue,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
            ),
            child: child!,
          );
        },
      );
      if (pickedDate == null) return null;

      if (!context.mounted) return null;
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.blue,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
            ),
            child: child!,
          );
        },
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
