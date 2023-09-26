import 'package:flutter/material.dart';
import 'package:masarat/config/constants.dart';

class DateTimeUtils {
  DateTimeUtils._();
  // date-picker
  static Future<DateTime?> pickDate(context, {DateTime? initDate}) async {
    return await showDatePicker(
      context: context,
      locale: const Locale('ar'),
      initialDate: initDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: kPrimColor,
            onPrimary: Colors.white,
            onSurface: kPrimColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: kPrimColor,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        child: child!,
      ),
    );
  }

  static Future<TimeOfDay?> pickTime(context, {TimeOfDay? initTime}) async {
    return await showTimePicker(
      context: context,
      cancelText: 'الغاء',
      confirmText: 'تم',
      helpText: '',
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: initTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: kPrimColor,
            onPrimary: Colors.white,
            onSurface: kPrimColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: kPrimColor,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
                fontFamily: 'Almarai',
              ),
            ),
          ),
        ),
        child: child!,
      ),
    );
  }
  //
}
