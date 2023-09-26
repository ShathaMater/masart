import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyLocale implements Translations {
  //
  static final _keys = <String, Map<String, String>>{};
  //
  @override
  Map<String, Map<String, String>> get keys => _keys;

  static Future<void> initLanguages() async {
    var ar = await load('ar');
    var en = await load('en');
    _keys['ar'] = ar;
    _keys['en'] = en;
    Get.clearTranslations();
    Get.addTranslations(_keys);
  }

  static load(String langCode) async {
    Map<String, String> localizedStrings;
    //
    var jsonString = await rootBundle.loadString('assets/langs/$langCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return localizedStrings;
  }
}
