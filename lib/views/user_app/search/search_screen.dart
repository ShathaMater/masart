import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/home_controller.dart';
import '../../../config/constants.dart';
import '../../../config/images.dart';
import '../../widgets/text_field.dart';
import '../trip_details/trip_details_page.dart';

class SearchPage extends GetView<HomeController> {
  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.searchTrips.clear();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: kPrimColor),
        elevation: 0,
        title: Text(
          'بحث',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: kPrimColor,
          ),
        ),
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) => Container(
          margin: EdgeInsets.only(top: 10.h),
          height: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              CustomTextField(
                onChanged: (p0) async {
                  await controller.search(p0);
                  controller.update();
                },
                hintTxt: 'عن ماذا تبحث؟',
                prefixIcon: Image.asset(Images.search),
              ),
              SizedBox(height: 20.h),
              Expanded(child: _buildTripsList()),
            ],
          ),
        ),
      ),
    );
  }
  //

  Widget _buildTripsList() {
    return GridView.builder(
      itemCount: controller.searchTrips.length,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 40),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 12 / 14,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _buildTripsTile(index);
      },
    );
  }

  Widget _buildTripsTile(int index) {
    return InkWell(
        onTap: () =>
            Get.to(() => TripDetailsPage(trip: controller.searchTrips[index])),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12),
            bottom: Radius.circular(12),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                controller.searchTrips[index].imagePath ?? "",
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () {
                      // wishlistController.wishlist
                      //         .contains(controller.searchTrips[index])
                      //     ? wishlistController
                      //         .remove(controller.searchTrips[index])
                      //     : wishlistController
                      //         .add(controller.searchTrips[index]);
                      // controller.update();
                    },
                    child: controller.wishlist
                            .contains(controller.searchTrips[index])
                        ? Image.asset(Images.fav, color: Colors.red)
                        : Image.asset(Images.fav),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(
                    //   width: 60.w,
                    //   height: 27.h,
                    //   child: Card(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(4.0),
                    //     ),
                    //     margin: EdgeInsets.zero,
                    //     child: Center(
                    //       child: Text(
                    //         controller.allTrips[index].price!,
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(color: kGreenColor, fontSize: 16.sp),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: 88.h,
                      color: kPrimColorL2,
                      padding: EdgeInsets.all(7.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.searchTrips[index].titleAr!,
                                  style: TextStyle(
                                      color: kTextColor, fontSize: 16.sp),
                                ),
                              ),
                              Text(
                                '${controller.searchTrips[index].price!}\$',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 16.sp),
                              ),
                              // const IconTheme(
                              //   data: IconThemeData(color: Colors.amber, size: 20),
                              //   child: StarDisplay(value: 3),
                              // ),
                            ],
                          ),
                          Text(
                            controller.searchTrips[index].companyAr!,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                children: [
                                  Image.asset(Images.location),
                                  SizedBox(width: 4.w),
                                  Text(
                                    controller.searchTrips[index].locationAr!,
                                    style: TextStyle(
                                        fontSize: 12.sp, color: kTextColor),
                                  ),
                                ],
                              ),
                              SizedBox(width: 12.w),
                              Wrap(
                                children: [
                                  Image.asset(Images.calendar),
                                  SizedBox(width: 4.w),
                                  Text(
                                    controller.searchTrips[index].startDate!,
                                    style: TextStyle(
                                        fontSize: 10.sp, color: kTextColor),
                                  )
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
            ],
          ),
        ));
  }

  //
}
