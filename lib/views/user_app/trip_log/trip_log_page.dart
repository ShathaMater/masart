import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../config/images.dart';
import '../../../models/booking.dart';
import '../../widgets/buttons.dart';

class TripLogPage extends StatelessWidget {
  const TripLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildAppBar(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogBtn(),
                _buildBookingList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildLogBtn() {
  return Padding(
    padding: EdgeInsets.only(top: 19.h, bottom: 14.h, right: 40.w),
    child: CustomElevatedBtn(
      height: 50.h,
      width: Get.width / 3,
      borderRadius: BorderRadius.circular(15),
      bgColor: kPrimColorLi,
      onPressed: () {},
      child: Text(
        'السجل',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18.sp, color: kBlackLi),
      ),
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
            title: Text('سجل الرحلات',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold)),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
          )));
}

Widget _buildBookingList() {
  return Container(
    color: kPrimColorLi.withOpacity(.15),
    margin: EdgeInsets.only(bottom: 20.h),
    child: ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: bookings.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildBookingTile(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: kPrimColorL,
          thickness: 0.6,
        );
      },
    ),
  );
}

Widget _buildBookingTile(int index) {
  return Padding(
    padding: EdgeInsets.only(right: 42.w, left: 35.w, top: 8.h, bottom: 39.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bookings[index].locationAr!,
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
              '\$${bookings[index].price!}',
              style: TextStyle(
                  color: kPrimColor.withOpacity(0.3), fontSize: 16.sp),
            ),
            SizedBox(
              width: 10.w,
            ),
            Image.asset(Images.calendar),
            SizedBox(
              width: 10.w,
            ),
            Text(
              bookings[index].date!,
              style: TextStyle(
                  color: kPrimColor.withOpacity(0.3),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            Image.asset(Images.delete)
          ],
        ),
      ],
    ),
  );
}
