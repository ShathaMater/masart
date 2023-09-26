import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/company_controller.dart';
import 'package:masarat/views/company_app/company_tripes/add_tripe_page.dart';
import 'package:masarat/views/user_app/trip_details/trip_details_page.dart';
import 'package:masarat/views/widgets/loading_widget.dart';

import '../../../config/constants.dart';

class ConpanyTripesPage extends GetView<CompanyController> {
  const ConpanyTripesPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fecthTrips();
    });
    return Scaffold(
      appBar: AppBar(title: const Text('رحلات الشركة')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddTripePage()),
        backgroundColor: kPrimColor,
        child: const Icon(Icons.add),
      ),
      body: GetBuilder(
        init: controller,
        builder: (controller) => LoadingWidget(
          statusRequest: controller.statusRequest,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.companyTrips.length,
            padding: EdgeInsets.all(16.r),
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () => Get.to(
                () => TripDetailsPage(trip: controller.companyTrips[index]),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/onboard_img3.png',
                      fit: BoxFit.cover,
                      height: 100.h,
                      width: double.infinity,
                    ),
                    Container(
                      // height: 88.h,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: kPrimColorL2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.companyTrips[index].titleAr ?? '',
                                style: TextStyle(
                                    color: kTextColor, fontSize: 16.sp),
                              ),
                              //
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  SizedBox(width: 4.w),
                                  Text(
                                    controller.companyTrips[index].locationAr ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: kTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month),
                                  SizedBox(width: 4.w),
                                  Text(
                                    controller.companyTrips[index].startDate ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 10.sp, color: kTextColor),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.w),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month),
                                  SizedBox(width: 4.w),
                                  Text(
                                    controller.companyTrips[index].endDate ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 10.sp, color: kTextColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
