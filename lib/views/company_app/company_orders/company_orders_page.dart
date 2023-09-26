import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/auth_controller.dart';
import 'package:masarat/views/company_app/company_orders/order_page.dart';

import '../../../config/constants.dart';
import '../../../config/images.dart';
import '../../../controllers/company_controller.dart';
import '../../widgets/loading_widget.dart';

class CompanyOrdersPage extends StatefulWidget {
  const CompanyOrdersPage({super.key});
  @override
  State<CompanyOrdersPage> createState() => _CompanyOrdersPageState();
}

class _CompanyOrdersPageState extends State<CompanyOrdersPage> {
  final authController = Get.find<AuthController>();
  final companyController = Get.find<CompanyController>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      companyController.getMyReservations();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحجوزات والطلبات'),
        elevation: 0,
      ),
      body: GetBuilder(
        init: companyController,
        builder: (controller) => LoadingWidget(
          statusRequest: controller.statusRequest,
          child: controller.companyReservation.isEmpty
              ? const Center(child: Text('لم يتم اضافة اي حجوزات'))
              : Container(
                  margin: EdgeInsets.only(top: 0.h),
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.companyReservation.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                            color: Colors.white, thickness: 1, height: 0.2),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => Get.to(() => OrderPage(
                            reservation: controller.companyReservation[index])),
                        child: Container(
                          color: kPrimColorLi.withOpacity(.15),
                          child: Padding(
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
                                      Text(
                                        controller.companyReservation[index]
                                                .trip?.titleAr ??
                                            '',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp),
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
                                            '\$${controller.companyReservation[index].trip?.price ?? ''}',
                                            style: TextStyle(
                                                color: kPrimColor,
                                                fontSize: 16.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Image.asset(Images.calendar,
                                              color: kBlackLi),
                                          SizedBox(width: 10.w),
                                          Text(
                                            controller.companyReservation[index]
                                                    .trip?.startDate ??
                                                '',
                                            style: TextStyle(
                                                color: kPrimColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
