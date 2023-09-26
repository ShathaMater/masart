import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masarat/services/sp_services.dart';
import 'package:masarat/views/auth/login_page.dart';
import 'package:masarat/views/company_app/company_base/company_base.dart';
import 'package:masarat/views/user_app/base/base_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  timerAndPush() => Timer(
        const Duration(milliseconds: 700),
        () => Get.offAll(
          () => (SPService.instance.isAuth)
              ? (SPService.instance.isCompany)
                  ? const CompanyBasePage()
                  : const BasePage()
              : const LoginPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    timerAndPush();
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo_img.png', scale: 5 / 4),
      ),
    );
  }
}
