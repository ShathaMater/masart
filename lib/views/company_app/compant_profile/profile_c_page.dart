import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/auth_controller.dart';

import '../../../config/constants.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: GetBuilder(
        init: AuthController(),
        builder: (controller) => SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              // image
              SizedBox(height: 35.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.asset(
                  'assets/images/onboard_img3.png',
                  width: 100.w,
                  fit: BoxFit.fill,
                ),
              ),
              // name
              SizedBox(height: 20.h),
              Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    controller.companyNew?.companyName ?? "",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.business_center, color: kPrimColor),
                ),
              ),
              // phone
              SizedBox(height: 20.h),
              Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    controller.companyNew?.phoneNumber ?? "",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.phone, color: kPrimColor),
                ),
              ),
              // email
              SizedBox(height: 20.h),
              Card(
                elevation: 2,
                child: ListTile(
                  title: Text(
                    controller.companyNew?.email ?? "",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.email, color: kPrimColor),
                ),
              ),
              // logout
              SizedBox(height: 20.h),
              InkWell(
                onTap: () => controller.logout(),
                child: ListTile(
                  title: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  leading: const Icon(Icons.logout, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
