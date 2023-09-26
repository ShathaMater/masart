import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/models/new_trip.dart';
import 'package:masarat/views/user_app/payment/select_payment_type_page.dart';
import '../../../config/constants.dart';
import '../../../config/images.dart';
import '../../widgets/buttons.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({Key? key, required this.trip}) : super(key: key);
  final NewTrip trip;
  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  int persons = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPath(),
                  // _buildConfirmBtn(),
                  _buildBookingList(),
                  // _buildRowWidget(
                  //   'المبلغ',
                  //   int.parse((widget.trip.price ?? '0')) * persons,
                  //   '\$',
                  // ),
                  // _buildRowWidget('الخصم', 10, '%'),
                  _buildRowWidget(
                    'الاجمالي',
                    int.parse((widget.trip.price ?? '0')) * persons,
                    '\$',
                  ),
                  // _buildCardNum(),
                  _buildSendBtn(),
                ],
              ),
            ),
          )
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
              title: Text('تأكيد الطلب',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold)),
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )));
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

  Widget _buildBookingList() {
    return Container(
      color: kPrimColorLi.withOpacity(.15),
      margin: EdgeInsets.only(top: 20.h),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 1,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.white,
          thickness: 1,
          height: 0.2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _buildBookingTile();
        },
      ),
    );
  }

  Widget _buildBookingTile() {
    return Padding(
      padding: EdgeInsets.only(right: 42.w, left: 35.w, top: 8.h, bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.trip.titleAr ?? '',
            style: TextStyle(color: kBlackLi, fontSize: 16.sp),
          ),
          Row(
            children: [
              Text(
                'السعر',
                style: TextStyle(color: kBlackLi, fontSize: 14.sp),
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                '\$${widget.trip.price}',
                style: TextStyle(color: kPrimColor, fontSize: 16.sp),
              ),
              SizedBox(width: 10.w),
              Image.asset(Images.calendar),
              SizedBox(width: 10.w),
              Text(
                widget.trip.startDate ?? '',
                style: TextStyle(
                    color: kPrimColor.withOpacity(0.3),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (persons >= 4) return;
                    persons += 1;
                  });
                },
                icon: Image.asset(Images.add),
              ),
              Text(
                '$persons',
                style: TextStyle(color: kTextColor, fontSize: 18.sp),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (persons <= 1) return;
                    persons -= 1;
                  });
                },
                icon: Image.asset(Images.minus),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSendBtn() {
    return Container(
      margin: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 20.h, top: 36.h),
      child: CustomElevatedBtn(
        onPressed: () {
          NewTrip nTrip = widget.trip;
          nTrip.persons = persons;
          nTrip.price = (int.parse(nTrip.price ?? '0') * persons).toString();
          log(nTrip.price ?? '');
          Get.to(() => SelectPaymentTypePage(trip: nTrip));
        },
        height: 50.h,
        borderRadius: BorderRadius.circular(12.r),
        child: Text(
          'اكمل الدفع',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
      ),
    );
  }

  Widget _buildRowWidget(String title, int val, String currency) {
    return Container(
      margin: EdgeInsets.only(right: 40.w, left: 40.w, top: 20.h, bottom: 20.h),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18.sp, fontWeight: FontWeight.w400, color: kBlackLi),
          ),
          const Spacer(),
          Text(
            '$currency $val',
            style: TextStyle(
                fontSize: 18.sp, fontWeight: FontWeight.w400, color: kBlackLi),
          ),
        ],
      ),
    );
  }
}
