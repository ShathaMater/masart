import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/user_reservations_controller.dart';
import 'package:masarat/views/widgets/loading_widget.dart';

import '../../../config/constants.dart';
import '../../../config/images.dart';

class BookingPage extends StatelessWidget {
  BookingPage({super.key});

  final controller = Get.find<UserReservationController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getMyReservations();
    });
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
          init: controller,
          builder: (controller) => LoadingWidget(
            statusRequest: controller.statusRequest,
            child: controller.myReservation.isEmpty
                ? const Center(child: Text('لم يتم اضافة اي حجوزات'))
                : Column(
                    children: [
                      _buildAppBar(),
                      Expanded(
                        child: Container(
                          color: kPrimColorLi.withOpacity(.15),
                          margin: EdgeInsets.only(top: 20.h),
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.myReservation.length,
                            // physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                                        color: Colors.white,
                                        thickness: 1,
                                        height: 0.2),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.all(15.r),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.asset(
                                        'assets/images/onboard_img3.png',
                                        width: 100.w,
                                        height: 100.h,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                controller.myReservation[index]
                                                        .trip?.titleAr ??
                                                    '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.sp),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4.h,
                                                    horizontal: 10.w),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  color: controller
                                                          .myReservation[index]
                                                          .isActive!
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                                child: Text(
                                                  controller
                                                          .myReservation[index]
                                                          .isActive!
                                                      ? 'فعال'
                                                      : 'غير فعال',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Row(
                                            children: [
                                              Text(
                                                'السعر' '   ',
                                                style: TextStyle(
                                                    color: kBlackLi,
                                                    fontSize: 14.sp),
                                              ),
                                              Text(
                                                '\$${controller.myReservation[index].trip?.price ?? ''}',
                                                style: TextStyle(
                                                    color: kPrimColor,
                                                    fontSize: 16.sp),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Row(
                                            children: [
                                              ...[
                                                Image.asset(Images.calendar,
                                                    color: kBlackLi),
                                                SizedBox(width: 10.w),
                                                Text(
                                                  controller
                                                          .myReservation[index]
                                                          .trip
                                                          ?.startDate ??
                                                      '',
                                                  style: TextStyle(
                                                      color: kPrimColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                              const Spacer(),
                                              if (controller
                                                  .myReservation[index]
                                                  .isActive!)
                                                InkWell(
                                                  onTap: () {
                                                    controller
                                                        .updateReservationStatus(
                                                            controller
                                                                .myReservation[
                                                                    index]
                                                                .trip!
                                                                .id!);
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
      child: Text(
        'قائمة الحجوزات',
        style: TextStyle(
            fontSize: 24.sp, fontWeight: FontWeight.w600, color: kPrimColor),
      ),
    );
  }
}
