import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/constants.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: kPrimColor),
        elevation: 0,
        title: Text(
          'البنود والشروط',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: kPrimColor,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        height: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: kPrimColorL,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Text(
          'باستخدام التطبيق أو الخدمات أو موقع الويب ، فإنك توافق على الالتزام بهذه الشروط والأحكام. يرجى قراءة هذه الشروط والأحكام بعناية قبل قبولها. إذا كنت لا توافق على الالتزام بهذه الشروط والأحكام ، فلا تدخل أو تستخدم التطبيقات أو الموقع الإلكتروني. يحتوي هذا المستند على معلومات توضح حقوقك في الوصول إلى تطبيق أسهل واستخدامه (كما هو موضح أدناه) وموقع ويب ويشكل اتفاقية ملزمة بينك وبين أسهل. لا تغير هذه الشروط بأي شكل من الأشكال شروط أو شروط أي اتفاقية أخرى قد تكون لديك مع أسهل للمنتجات أو الخدمات أو غير ذلك. بينما نبذل جهودًا معقولة لتوفير معلومات دقيقة وفي الوقت المناسب حول تطبيقاتنا أو خدماتنا ، يجب ألا تفترض أن المعلومات محدثة دائمًا أو أن الموقع يحتوي على جميع المعلومات ذات الصلة المتاحة حول أسهل.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16.sp, color: Colors.black, height: 1.5),
        ),
      ),
    );
  }
}
