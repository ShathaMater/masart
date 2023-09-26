import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/models/category.dart';

import '../../../config/constants.dart';
import '../../../config/images.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/new_trip.dart';
import '../trip_details/trip_details_page.dart';

class CatgeoryTripsPage extends GetView<HomeController> {
  CatgeoryTripsPage({super.key, required this.category});
  final Categories category;

  List<NewTrip> trips = [];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      trips.clear();
      await controller.fetchCategoryTrips();
      switch (category.id) {
        case 1:
          trips = controller.tourismTrips;
          break;
        case 2:
          trips = controller.religiousTrips;
          break;
        case 3:
          trips = controller.medicalTrips;
          break;
        case 4:
          trips = controller.scientificTrips;
          break;
        default:
      }
      controller.update();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(category.titleAr!),
      ),
      body: GetBuilder(
        init: controller,
        builder: (controller) => GridView.builder(
          itemCount: trips.length,
          shrinkWrap: true,
          padding: EdgeInsets.all(15.r),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 12 / 14,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _buildTripsTile(index);
          },
        ),
      ),
    );
  }

  //

  Widget _buildTripsTile(int index) {
    return InkWell(
      onTap: () => Get.to(() => TripDetailsPage(trip: trips[index])),
      // height: 218.h,
      // width: 192.h,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
          bottom: Radius.circular(12),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              trips[index].imagePath ?? '',
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    controller.wishlist
                            .any((e) => e.id == controller.allTrips[index].id)
                        ? controller.remove(controller.allTrips[index])
                        : controller.add(controller.allTrips[index]);
                    controller.update();
                  },
                  child: controller.wishlist
                          .any((e) => e.id == controller.allTrips[index].id)
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
                                trips[index].titleAr!,
                                style: TextStyle(
                                    color: kTextColor, fontSize: 16.sp),
                              ),
                            ),
                            Text(
                              '${trips[index].price!}\$',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16.sp),
                            ),
                            // const IconTheme(
                            //   data: IconThemeData(color: Colors.amber, size: 20),
                            //   child: StarDisplay(value: 3),
                            // ),
                          ],
                        ),
                        Text(
                          trips[index].companyAr!,
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
                                  trips[index].locationAr!,
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
                                  trips[index].startDate!,
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
      ),
    );
  }

  //
}
