import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/auth_controller.dart';

import '../../../config/constants.dart';
import '../../../config/images.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = Get.find<AuthController>();
  final phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [_buildForm(), _buildSaveBtn()],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSaveBtn() {
    return Container(
      margin: EdgeInsets.only(right: 20.w, left: 20.w, top: 19.h, bottom: 20.h),
      child: CustomElevatedBtn(
        onPressed: () async {
          if (phone.text.isNotEmpty) {
            controller.userModel?.mobile = phone.text;
          }
          await controller.updateUser();
          Get.back();
        },
        height: 50.h,
        borderRadius: BorderRadius.circular(12.r),
        child: Text(
          'حفظ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
        height: 143.h,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        decoration: BoxDecoration(
          color: kPrimColor,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  const Color(0xFF2F86AD).withOpacity(0.09), BlendMode.dstATop),
              image: const AssetImage(Images.bgSearch),
              fit: BoxFit.cover),
        ),
        child: Container(
            alignment: Alignment.bottomCenter,
            child: AppBar(
              title: Text('تعديل الملف الشخصي',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold)),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )));
  }

  Widget _buildForm() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 34.w, left: 34.w, bottom: 24.h),
      decoration: BoxDecoration(
        color: kPrimColorLi.withOpacity(.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          _buildProfilePhoto(),
          Row(
            children: [
              Text(
                'اسم المستخدم كامل',
                style: TextStyle(fontSize: 16.sp),
              )
            ],
          ),
          SizedBox(height: 10.sp),
          CustomTextField(
            height: 50.sp,
            controller: TextEditingController(
                text: controller.userModel?.username ?? ''),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Text(
                'البريد الإلكتروني',
                style: TextStyle(fontSize: 16.sp),
              )
            ],
          ),
          SizedBox(height: 10.sp),
          CustomTextField(
            hintTxt: 'google@gmail.com',
            controller:
                TextEditingController(text: controller.userModel?.email ?? ''),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Text(
                'رقم الهاتف',
                style: TextStyle(fontSize: 16.sp),
              )
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
          CustomTextField(
            controller: phone,
            hintTxt: 'أدخل رقم الهاتف',
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Text(
                'الجنس',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          Row(
            children: <Widget>[
              Radio(
                value: true,
                groupValue: controller.userModel!.sex == 'male',
                onChanged: (value) {
                  setState(() {
                    controller.userModel!.sex = 'male';
                  });
                  log(controller.userModel!.sex ?? "");
                },
              ),
              SizedBox(width: 4.w),
              Text(
                'ذكر',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(width: 22.w),
              Radio(
                value: true,
                groupValue: controller.userModel!.sex == 'female',
                onChanged: (value) {
                  setState(() {
                    controller.userModel!.sex = 'female';
                  });
                  log(controller.userModel!.sex ?? "");
                },
              ),
              SizedBox(width: 4.w),
              Text(
                'أنثى',
                style: TextStyle(fontSize: 16.sp),
              ), //Checkbox
            ], //<Widget>[]
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhoto() {
    return Container(
      width: 135.w,
      height: 138.w,
      margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
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
}
