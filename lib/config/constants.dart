import 'dart:io';

import 'package:flutter/material.dart';

// current-platform
var isPlatfomIOS = Platform.isIOS;

// light
const kPrimColor = Color(0xFF2F86AD);
const kPrimColorL = Color(0xFFB7D1DD);
const kPrimColorL2 = Color(0xFFE4EEF3);
const kLiWhiteColor = Color(0xFFFAFAFA);
const kTextColor = Color(0xFF2B6883);
const kGreenColor = Color(0xFF56C0A9);
const kBlackLi = Color(0xFF29384E);
// const test = Color(0xFFA1C8DA);
final kPrimColorLi = const Color.fromARGB(255, 71, 160, 201).withOpacity(0.3);

//

class AppKeys {
  static const kQAyaht = 'quranAyaht';
  static const kNotFirstLunch = 'notFirstLunch';
  static const kToken = 'token';
  static const kPhone = 'phoneNumber';
  static const kIsDarkTheme = 'isDarkTheme';
  static const kBookmarks = 'kBookmarks';
}
