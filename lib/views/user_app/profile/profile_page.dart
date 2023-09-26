import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/auth_controller.dart';
import 'package:masarat/views/user_app/static/about_app_page.dart';
import 'package:masarat/views/user_app/static/privacy_page.dart';
import 'package:masarat/views/user_app/static/terms_page.dart';
import 'package:masarat/views/user_app/wishlist/wishlist_page.dart';

import '../../../config/constants.dart';
import '../../../config/images.dart';
import '../../../controllers/home_controller.dart';
import 'edit_profile_page.dart';

class ProfilePage extends GetView<HomeController> {
  ProfilePage({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // _buildProfilePhoto(),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.only(top: 23.h),
                      margin: EdgeInsets.only(bottom: 30.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kPrimColorLi.withOpacity(.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            authController.userModel?.username ?? '',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: kTextColor),
                          ),
                          SizedBox(height: 20.h),
                          // _buildRow('سجل الرحلة ', 1),
                          // const Divider(color: kPrimColor, height: 1),
                          // _buildRow('الخريطة', 2),
                          // const Divider(color: kPrimColor, height: 1),
                          InkWell(
                            onTap: () => Get.to(() => WishlistPage()),
                            child: _buildRow('المفضلة '),
                          ),
                          const Divider(color: kPrimColor, height: 1),
                          _buildRow('تغير كملة المرور '),
                          const Divider(color: kPrimColor, height: 1),
                          InkWell(
                            onTap: () => Get.to(() => const AboutAppPage()),
                            child: _buildRow('حول التطبيق'),
                          ),
                          const Divider(color: kPrimColor, height: 1),
                          InkWell(
                            onTap: () => Get.to(() => const PrivacyPage()),
                            child: _buildRow('سياسة الخصوصية'),
                          ),
                          const Divider(color: kPrimColor, height: 1),
                          InkWell(
                            onTap: () =>
                                Get.to(() => const TermsConditionsPage()),
                            child: _buildRow('البنود والشروط'),
                          ),

                          const Divider(color: kPrimColor, height: 1),
                          InkWell(
                            onTap: () => Get.find<AuthController>().logout(),
                            child: _buildRow('تسجيل الخروج'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title) {
    return Padding(
      padding:
          EdgeInsets.only(left: 25.w, right: 28.w, bottom: 15.h, top: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.sp),
          ),
          Image.asset(Images.arrowLeft),
        ],
      ),
    );
  }
}

Widget _buildAppBar() {
  return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 40.w, right: 40.w),
      child: Row(
        children: [
          const Spacer(),
          Center(
            child: Text(
              'الملف الشخصي',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: kPrimColor,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () => Get.to(() => EditProfile()),
              icon: Image.asset(Images.edit)),
        ],
      ));
}

Widget _buildProfilePhoto() {
  return Container(
    width: 135.w,
    height: 138.w,
    margin: EdgeInsets.only(top: 26.h, bottom: 30.h),
    decoration: BoxDecoration(
        color: kPrimColorL,
        borderRadius: BorderRadius.all(Radius.circular(70.w)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(0, 1))
        ]),
    child: const Image(
      fit: BoxFit.cover,
      image: AssetImage("assets/images/profile_img.png"),
    ),
  );
}
