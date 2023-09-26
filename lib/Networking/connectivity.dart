import 'dart:io';
import 'package:flutter/widgets.dart';

class Reachability {
  static Future<bool> isInternetConected() async {
    var icConnected = false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        icConnected = true;
      }
    } on SocketException catch (_) {
      icConnected = false;
    }
    debugPrint('connectivity || $icConnected');
    return icConnected;
  }
}
