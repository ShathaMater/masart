import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String? toDateTimeString() {
    return DateFormat('dd/MM/yyyy')
        .format(DateTime.tryParse(this) ?? DateTime.now());
  }

  DateTime? toDateTime() {
    return DateTime.tryParse(DateFormat('dd/MM/yyyy')
        .format(DateTime.tryParse(this) ?? DateTime.now()));
  }
}

extension TimeExtenstion on TimeOfDay {
  String? toTimeFormat() => '$hour:$minute';
}
