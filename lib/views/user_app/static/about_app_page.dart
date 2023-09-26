import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/constants.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: kPrimColor),
        elevation: 0,
        title: Text(
          'حول التطبيق',
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
          ''' 
هذا التطبيق الذي يتحقّق تنزيله بالمجان على الأجهزة التي يسيّرها نظام الـ"أندرويد" أو الـ"آي أو اس" هو خير مرشد خلال السفر السياحي، إذ يقدّم سبل الوصول إلى المعالم السياحية والأحداث والمهرجانات، 
وذلك في أكثر من 350 وجهة مختلفة حول العالم، بما في ذلك المزيد من المحتويات المحلية في قرابة 30 مدينة من الأكبر حول العالم.
ميزته هي إمكانيّة الحجز بوساطته لحضور الأحداث والعروض، وذلك بأسعار تنافسية،
استلام القسيمة الخاصة بالحجز على الفور عبر شاشة هاتفك.
        ''',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16.sp, color: Colors.black, height: 1.5),
        ),
      ),
    );
  }
}
