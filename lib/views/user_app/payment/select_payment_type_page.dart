import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/user_reservations_controller.dart';
import 'package:masarat/models/new_trip.dart';
import 'package:masarat/views/user_app/payment/online_payment.dart';
import 'package:masarat/views/widgets/loading_widget.dart';

import '../../../config/constants.dart';
import '../../../config/images.dart';
import '../../widgets/buttons.dart';

class SelectPaymentTypePage extends StatefulWidget {
  const SelectPaymentTypePage({Key? key, required this.trip}) : super(key: key);
  final NewTrip trip;
  @override
  State<SelectPaymentTypePage> createState() => _SelectPaymentTypePageState();
}

class _SelectPaymentTypePageState extends State<SelectPaymentTypePage> {
  bool isOnlinePayment = false;
  final controller = Get.find<UserReservationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (controller) => LoadingWidget(
          statusRequest: controller.statusRequest,
          child: Column(
            children: [
              _buildAppBar(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    _buildPath(),
                    SizedBox(height: 20.h),
                    _buildPayMethod(),
                    _buildBookCanBtn(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPayMethod() {
    return Container(
      padding:
          EdgeInsets.only(top: 19.h, bottom: 14.h, right: 40.w, left: 39.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio(
                value: false,
                groupValue: isOnlinePayment,
                onChanged: (value) {
                  setState(() {
                    isOnlinePayment = false;
                  });
                },
              ),
              Text(
                'دفع كاش ',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: true,
                groupValue: isOnlinePayment,
                onChanged: (value) {
                  setState(() {
                    isOnlinePayment = true;
                  });
                },
              ),
              const Text('الدفع اونلاين'),
            ],
          ),
          SizedBox(height: 29.h),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 143.h,
      decoration: BoxDecoration(
        color: kPrimColor,
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                const Color(0xFF2F86AD).withOpacity(0.09), BlendMode.dstATop),
            image: const AssetImage(Images.bgSearch),
            fit: BoxFit.cover),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: AppBar(
          title: Text(
            'اختر طريقة الدفع',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildPath() {
    return Container(
      height: 62.h,
      width: 240.w,
      margin: EdgeInsets.only(top: 19.h),
      child: Stack(
        children: [
          Align(alignment: Alignment.topLeft, child: Image.asset(Images.path)),
          Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(Images.location2)),
          Align(
              alignment: Alignment.topRight, child: Image.asset(Images.plane)),
        ],
      ),
    );
  }

  Widget _buildBookCanBtn() {
    return Padding(
      padding: EdgeInsets.all(26.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomElevatedBtn(
            onPressed: () async {
              if (!isOnlinePayment) {
                await controller.reserveTrip(widget.trip);
                return;
              }
              Get.off(() => PaymentScreen(trip: widget.trip));
            },
            width: Get.width / 3,
            height: 50.h,
            borderRadius: BorderRadius.circular(12.r),
            child: Text(
              'متابعة الحجز',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          CustomElevatedBtn(
            onPressed: () => Get.back(),
            width: Get.width / 3,
            height: 52.h,
            bgColor: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            isBorder: true,
            child: Text(
              'إلغاء',
              style: TextStyle(
                  color: kPrimColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
