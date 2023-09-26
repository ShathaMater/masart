import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../controllers/auth_controller.dart';
import '../../models/onboarding.dart';
import 'main_login_page.dart';

class OnBordingScreen extends StatelessWidget {
  OnBordingScreen({super.key});

  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Column(
          children: [
            Image.asset(
              onBoardingData[authController.onboardingPage.value].imagePathEn!,
              height: Get.height / 1.7,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.h),
            Text(
              '${onBoardingData[authController.onboardingPage.value].titleAr}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                color: kPrimColor,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: Text(
                '${onBoardingData[authController.onboardingPage.value].subTitleAr}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: kPrimColor,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            SizedBox(
              height: 8,
              child: ListView.separated(
                separatorBuilder: (context, index) => Container(width: 3.w),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: onBoardingData.length,
                itemBuilder: (context, index) => Container(
                  width: authController.onboardingPage.value == index
                      ? 15.0.w
                      : 8.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    shape: BoxShape.rectangle,
                    color: authController.onboardingPage.value == index
                        ? kPrimColor
                        : const Color.fromRGBO(0, 0, 0, 0.2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.h),
            SizedBox(
              height: 40.h,
              width: Get.width / 2,
              child: ElevatedButton(
                onPressed: () {
                  if ((authController.onboardingPage.value + 1) <
                      onBoardingData.length) {
                    authController.onboardingPage.value += 1;
                  } else {
                    Get.offAll(() => const MainLoginPage());
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kPrimColor),
                ),
                child: Text(
                  ((authController.onboardingPage.value + 1) <
                          onBoardingData.length)
                      ? 'التالي'
                      : 'تخطي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
