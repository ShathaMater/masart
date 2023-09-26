import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/config/constants.dart';
import 'package:masarat/views/auth/login_page.dart';
import 'package:masarat/views/auth/register_page.dart';
import 'package:masarat/views/widgets/buttons.dart';

class MainLoginPage extends StatelessWidget {
  const MainLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_img.png', scale: 5 / 3),
            SizedBox(height: 30.h),
            CustomElevatedBtn(
              onPressed: () => Get.offAll(() => const LoginPage()),
              child: Text(
                'تسجيل دخول',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30.h),
            CustomElevatedBtn(
              onPressed: () => Get.offAll(() => const RegisterPage()),
              isBorder: true,
              bgColor: Colors.transparent,
              child: Text(
                'حساب جديد',
                style: TextStyle(
                  color: kPrimColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
