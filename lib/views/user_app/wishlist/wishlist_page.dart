import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/home_controller.dart';
import 'package:masarat/views/widgets/loading_widget.dart';
import '../../../config/constants.dart';
import '../../../config/images.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getWishlist();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: kPrimColor),
        elevation: 0,
        title: Text(
          'المفضلة',
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
        builder: (controller) => LoadingWidget(
          statusRequest: controller.statusRequest,
          child: controller.wishlist.isEmpty
              ? const Center(child: Text('لم يتم اضافة اي رحلة'))
              : Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  child: ListView.separated(
                    itemCount: controller.wishlist.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                            color: Colors.white, thickness: 3, height: 0.5),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(15.r),
                        color: kPrimColorLi.withOpacity(.15),
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
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.wishlist[index].titleAr ?? '',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      Text(
                                        'السعر' '   ',
                                        style: TextStyle(
                                            color: kBlackLi, fontSize: 14.sp),
                                      ),
                                      Text(
                                        '\$${controller.wishlist[index].price ?? ''}',
                                        style: TextStyle(
                                            color: kPrimColor, fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      Image.asset(Images.calendar,
                                          color: kBlackLi),
                                      SizedBox(width: 10.w),
                                      Flexible(
                                        child: Text(
                                          controller
                                                  .wishlist[index].startDate ??
                                              "",
                                          style: TextStyle(
                                              color: kPrimColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                          onTap: () {
                                            controller.remove(
                                                controller.allTrips[index]);
                                            controller.update();
                                          },
                                          child: Image.asset(Images.fav,
                                              color: Colors.red)),
                                    ],
                                  ),
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
      ),
    );
  }
}
