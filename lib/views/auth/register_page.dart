import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/auth_controller.dart';
import 'package:masarat/models/company.dart';
import 'package:masarat/views/widgets/loading_widget.dart';

import '../../config/constants.dart';
import '../widgets/buttons.dart';
import '../widgets/show_toast.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  final confiremdPassword = TextEditingController();
  bool isCompany = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل جديد', style: TextStyle(color: kPrimColor)),
        iconTheme: const IconThemeData(color: kPrimColor),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: GetBuilder(
        init: AuthController(),
        builder: (authController) => LoadingWidget(
          statusRequest: authController.statusRequest,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    color: kPrimColorLi.withOpacity(.15),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 45.h,
                        margin: EdgeInsets.only(
                            left: 20.w, right: 20.w, bottom: 20.h),
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
                                    color:
                                        !isCompany ? kPrimColor : Colors.white,
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
                                    color:
                                        isCompany ? kPrimColor : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text('سجل بياناتك للدخول'),
                      SizedBox(height: 30.h),
                      if (isCompany) ...[
                        Row(
                          children: [
                            Text(
                              'اسم الشركة',
                              style: TextStyle(fontSize: 16.sp),
                            )
                          ],
                        ),
                        CustomTextField(
                          controller: username,
                          height: 50.h,
                        ),
                        SizedBox(height: 20.h),
                        // address
                        Row(
                          children: [
                            Text(
                              'عنوان الشركة',
                              style: TextStyle(fontSize: 16.sp),
                            )
                          ],
                        ),
                        CustomTextField(
                          controller: address,
                          height: 50.h,
                        ),
                        SizedBox(height: 20.h),
                        // phone
                        Row(
                          children: [
                            Text(
                              'رقم جوال الشركة',
                              style: TextStyle(fontSize: 16.sp),
                            )
                          ],
                        ),
                        CustomTextField(
                          controller: phone,
                          height: 50.h,
                        ),
                        SizedBox(height: 20.h),
                      ] else ...[
                        Row(
                          children: [
                            Text(
                              'اسم المستخدم',
                              style: TextStyle(fontSize: 16.sp),
                            )
                          ],
                        ),
                        CustomTextField(
                          controller: username,
                          height: 50.h,
                        ),
                        SizedBox(height: 20.h),
                      ],
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
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Text(
                            'تأكيد كلمة المرور',
                            style: TextStyle(fontSize: 16.sp),
                          )
                        ],
                      ),
                      CustomTextField(
                        controller: confiremdPassword,
                        isScureField: true,
                        maxLines: 1,
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
                          if (isCompany) {
                            if (address.text.isEmpty ||
                                email.text.isEmpty ||
                                phone.text.isEmpty) {
                              ShowToast.show(
                                  msg: 'يرجى ادخال البيانات بشكل صحيح');
                              return;
                            }
                          }
                          if (username.text.isEmpty ||
                              email.text.isEmpty ||
                              password.text.isEmpty ||
                              confiremdPassword.text.isEmpty) {
                            ShowToast.show(
                                msg: 'يرجى ادخال البيانات بشكل صحيح');
                            return;
                          }
                          if (password.text != confiremdPassword.text) {
                            ShowToast.show(msg: 'كلمة السر غير متطابقة');
                            return;
                          }
                          if (isCompany) {
                            CompanyNew c = CompanyNew();
                            c.companyName = username.text;
                            c.companyAddress = address.text;
                            c.phoneNumber = phone.text;
                            c.email = email.text;
                            await authController.registerCompany(
                              c,
                              password.text,
                            );
                          } else {
                            await authController.registerUser(
                              email.text,
                              password.text,
                              username.text,
                            );
                          }
                        },
                        height: 50.h,
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.sp),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('لديك حساب؟ الدخول'),
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
