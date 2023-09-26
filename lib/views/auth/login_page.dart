import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/config/constants.dart';
import 'package:masarat/controllers/auth_controller.dart';
import 'package:masarat/views/auth/register_page.dart';
import 'package:masarat/views/widgets/buttons.dart';
import 'package:masarat/views/widgets/loading_widget.dart';
import 'package:masarat/views/widgets/show_toast.dart';
import 'package:masarat/views/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isCompany = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: AuthController(),
        builder: (authController) => LoadingWidget(
          statusRequest: authController.statusRequest,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 70.h),
                Image.asset('assets/images/welcome_img.png', scale: 4 / 2),
                SizedBox(height: 20.h),
                Container(
                  height: 45.h,
                  margin:
                      EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: kPrimColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedBtn(
                          onPressed: () {
                            setState(() => isCompany = true);
                          },
                          bgColor: isCompany ? kPrimColor : Colors.white,
                          isBorder: true,
                          child: Text(
                            'شركة',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: !isCompany ? kPrimColor : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomElevatedBtn(
                          onPressed: () {
                            setState(() => isCompany = false);
                          },
                          bgColor: !isCompany ? kPrimColor : Colors.white,
                          isBorder: true,
                          child: Text(
                            'مستخدم',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: isCompany ? kPrimColor : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    color: kPrimColorLi.withOpacity(.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'البريد الإلكتروني',
                            style: TextStyle(fontSize: 16.sp),
                          )
                        ],
                      ),
                      CustomTextField(
                        controller: email,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Text(
                            'كلمة المرور',
                            style: TextStyle(fontSize: 16.sp),
                          )
                        ],
                      ),
                      CustomTextField(
                        controller: password,
                        isScureField: true,
                        maxLines: 1,
                      ),
                      // forget-password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('نسيت كلمة المرور؟'),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'استعادة كلمة المرور',
                              style: TextStyle(
                                  color: kPrimColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      CustomElevatedBtn(
                        onPressed: () async {
                          if (email.text.isEmpty || password.text.isEmpty) {
                            ShowToast.show(
                                msg: 'يرجى ادخال البيانات بشكل صحيح');
                            return;
                          }
                          await authController.lgoin(
                              email.text, password.text, isCompany);
                        },
                        height: 50.h,
                        child: Text(
                          'دخول',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.sp),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      //
                      const Text(
                        'أو التسجيل من خلال',
                        style: TextStyle(
                            color: kPrimColor, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomElevatedBtn(
                            onPressed: () {},
                            width: Get.width / 3,
                            height: 50.h,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Facebook'),
                                Icon(Icons.facebook)
                              ],
                            ),
                          ),
                          CustomElevatedBtn(
                            onPressed: () {},
                            width: Get.width / 3,
                            height: 50.h,
                            bgColor: Colors.white,
                            isBorder: true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Apple',
                                  style: TextStyle(
                                      color: kPrimColor, fontSize: 16.sp),
                                ),
                                const Icon(Icons.apple, color: kPrimColor),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      TextButton(
                        onPressed: () => Get.to(() => const RegisterPage()),
                        child: const Text('انشاء حساب جديد'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
