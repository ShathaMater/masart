import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/config/constants.dart';
import 'package:masarat/models/category.dart';
import 'package:masarat/views/user_app/category_trips/category_trips_page.dart';
import 'package:masarat/views/user_app/home/show_all_trips_page.dart';
import 'package:masarat/views/user_app/search/search_screen.dart';
import 'package:masarat/views/user_app/trip_details/trip_details_page.dart';
import 'package:masarat/views/widgets/loading_widget.dart';

import '../../../config/images.dart';
import '../../../controllers/home_controller.dart';
import '../../widgets/text_field.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.find<HomeController>();

  getDate() async {
    await controller.fecthTrips();
    await controller.getWishlist();
    controller.update();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: HomeController(),
        builder: (controller) => LoadingWidget(
          statusRequest: controller.statusRequest,
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'التصنيفات',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: kTextColor),
                      ),
                      _buildCatList(),
                      SizedBox(height: 20.h),
                      //
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'جديد الرحلات ',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: kTextColor),
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => ShowAllTripsPage()),
                            child: const Text('عرض الكل'),
                          ),
                        ],
                      ),
                      _buildTripsList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
        height: 120.h,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.to(() => SearchPage()),
                  child: CustomTextField(
                    hintTxt: 'عن ماذا تبحث؟',
                    prefixIcon: Image.asset(Images.search),
                    isEnabled: false,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                Images.bell,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }

  Widget _buildCatList() {
    return SizedBox(
      height: 192.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () =>
                Get.to(() => CatgeoryTripsPage(category: categories[index])),
            child: SizedBox(
                height: 192.h,
                width: 192.h,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                    bottom: Radius.circular(30),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        categories[index].imagePath!,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 46.h,
                          color: kPrimColorL2,
                          child: Center(
                            child: Text(
                              categories[index].titleAr!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget _buildTripsList() {
    return GridView.builder(
      itemCount:
          controller.allTrips.length > 6 ? 6 : controller.allTrips.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
        onTap: () => Get.to(
              () => TripDetailsPage(trip: controller.allTrips[index]),
            ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(12),
            bottom: Radius.circular(12),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                controller.allTrips[index].imagePath ?? "",
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
                child: Container(
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
                              controller.allTrips[index].titleAr!,
                              style:
                                  TextStyle(color: kTextColor, fontSize: 16.sp),
                            ),
                          ),
                          Text(
                            '${controller.allTrips[index].price!}\$',
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
                        controller.allTrips[index].companyAr!,
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Image.asset(Images.location),
                              SizedBox(width: 4.w),
                              Text(
                                controller.allTrips[index].locationAr!,
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
                                controller.allTrips[index].startDate!,
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
              ),
            ],
          ),
        ));
  }
}
