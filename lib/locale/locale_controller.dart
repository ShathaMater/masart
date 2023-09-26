import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  static LocaleController ins = LocaleController();
  //
  Locale get initLocale {
    // var locale = SPService.instance.getString('locale').isNotEmpty
    //     ? Locale(SPService.instance.getString('locale'))
    //     : const Locale('en');
    // SPService.instance.setString('locale', locale.languageCode);
    // return locale;
    return const Locale('ar');
  }

  Future changeLanguage(String language) async {
    Locale locale = Locale(language);
    // await SPService.instance.setString('locale', language);
    Get.updateLocale(locale);
  }


}
