import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/models/reservation.dart';

import '../../../config/constants.dart';
import '../../../controllers/company_controller.dart';
import '../../widgets/loading_widget.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key, required this.reservation});
  final Reservation reservation;
  final companyController = Get.find<CompanyController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await companyController.fetchUser(reservation.userId!);
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('بيانات الحجز'),
      ),
      body: GetBuilder(
        init: companyController,
        builder: (controller) => LoadingWidget(
          statusRequest: controller.statusRequest,
          child: Container(
            color: kPrimColorLi.withOpacity(.15),
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      'assets/images/onboard_img3.png',
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    reservation.trip?.titleAr ?? '',
                    style: TextStyle(color: Colors.black, fontSize: 20.sp),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Text(
                        'السعر' ':   ',
                        style: TextStyle(color: kBlackLi, fontSize: 16.sp),
                      ),
                      Text(
                        '\$${reservation.trip?.price ?? ''}',
                        style: TextStyle(color: kPrimColor, fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        'عدد الاشخاص' ': ',
                        style: TextStyle(color: kBlackLi, fontSize: 16.sp),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '${reservation.trip?.persons}',
                        style: TextStyle(
                          color: kPrimColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'تاريخ البداية' ': ',
                        style: TextStyle(color: kBlackLi, fontSize: 16.sp),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        reservation.trip?.startDate ?? '',
                        style: TextStyle(
                          color: kPrimColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'تاريخ النهاية' ': ',
                        style: TextStyle(color: kBlackLi, fontSize: 16.sp),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        reservation.trip?.endDate ?? '',
                        style: TextStyle(
                          color: kPrimColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'بيانات مقدم الطلب' ': ',
                    style: TextStyle(
                      color: kBlackLi,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'الاسم' ': ',
                        style: TextStyle(color: kBlackLi, fontSize: 16.sp),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        companyController.userModel?.username ?? '',
                        style: TextStyle(
                          color: kPrimColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'البريد الالكتروني' ': ',
                        style: TextStyle(color: kBlackLi, fontSize: 16.sp),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        companyController.userModel?.email ?? '',
                        style: TextStyle(
                          color: kPrimColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
