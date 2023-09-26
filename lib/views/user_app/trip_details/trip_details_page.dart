import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/config/constants.dart';
import 'package:masarat/controllers/user_reservations_controller.dart';
import 'package:masarat/models/new_trip.dart';
import 'package:masarat/services/sp_services.dart';
import 'package:masarat/views/widgets/buttons.dart';
import 'package:masarat/views/widgets/loading_widget.dart';
import 'package:masarat/views/widgets/star_display.dart';

import '../../widgets/show_toast.dart';
import '../payment/confirm_order_page.dart';

class TripDetailsPage extends GetView<UserReservationController> {
  const TripDetailsPage({super.key, required this.trip});
  final NewTrip trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder(
        init: controller,
        builder: (controller) => LoadingWidget(
          statusRequest: controller.statusRequest,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/onboard_img3.png',
                  height: 300.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.titleAr ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              trip.companyAr ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: Colors.black45),
                            ),
                          ),
                          const StarDisplay(value: 4),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'نوع الرحلة' ':   ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.black45),
                          ),
                          Text(
                            '${trip.categoryAr}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: kPrimColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تكلفة الرحلة' ':   ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.black45),
                          ),
                          Text(
                            '\$${trip.price ?? ''}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: kPrimColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'مدة الرحلة' ':   ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.black45),
                          ),
                          Text(
                            '${trip.duration ?? ''}-يوم',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: kPrimColor,
                            ),
                          ),
                        ],
                      ),
                      //

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تاريخ بدء الرحلة' ':     ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.black45),
                          ),
                          Text(
                            trip.startDate ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: kPrimColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تاريخ نهاية الرحلة' ':   ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.black45),
                          ),
                          Text(
                            trip.endDate ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: kPrimColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'وصف الرحلة:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        trip.descriptionAr ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.black45),
                      ),
                      SizedBox(height: 20.h),
                      // hide reserve when a user is company.
                      if (!SPService.instance.isCompany)
                        CustomElevatedBtn(
                          onPressed: () async {
                            bool isFound =
                                await controller.isTripFoundInDB(trip.id!);
                            if (isFound) {
                              ShowToast.show(
                                  msg: 'الحجز موجود مسبقا في سجل حجوزاتك');
                              return;
                            }
                            Get.to(() => ConfirmOrderPage(trip: trip));
                          },
                          child: Text(
                            'حجز رحلة',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
