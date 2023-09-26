import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/config/images.dart';
import 'package:masarat/views/user_app/companies/company_trips_page.dart';
import 'package:masarat/views/widgets/loading_widget.dart';
import '../../../config/constants.dart';
import '../../../controllers/home_controller.dart';

class CompaniesPage extends GetView<HomeController> {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.fecthCompanies();
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: GetBuilder(
                init: controller,
                builder: (controller) => LoadingWidget(
                  statusRequest: controller.statusRequest,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // _buildCatList(),
                        // _buildFilterWidget(),
                        _buildCompaniesList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Text(
        'الشركات',
        style: TextStyle(
            fontSize: 24.sp, fontWeight: FontWeight.w600, color: kPrimColor),
      ),
    );
  }

  Widget _buildCompaniesList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: controller.allCompanies.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildCompanyTile(index);
      },
    );
  }

  Widget _buildCompanyTile(int index) {
    return InkWell(
      onTap: () => Get.to(() => CompanyTripsPage(
            companyNew: controller.allCompanies[index],
          )),
      child: Container(
          height: 201.h,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20.w, right: 16.w, left: 16.w),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
              bottom: Radius.circular(12),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  // companies[index].imagePath!,
                  'assets/images/test.png',
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 70.h,
                        color: kPrimColorL2,
                        padding: EdgeInsets.only(
                            right: 27.w, left: 21.w, top: 9.h, bottom: 9.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.allCompanies[index].companyName!,
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                // if (controller.isRatesContainUser(
                                //     controller.allCompanies[index])) ...[
                                //   IconTheme(
                                //     data: const IconThemeData(
                                //         color: Colors.amber, size: 20),
                                //     child: StarDisplay(
                                //         value: controller.userRate.toInt()),
                                //   ),
                                // ] else ...[
                                RatingBar.builder(
                                  onRatingUpdate: (rating) {
                                    // controller.addRating(
                                    //     controller.allCompanies[index].id!,
                                    //     rating);
                                  },
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 25.w,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                              // ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(Images.location),
                                SizedBox(width: 4.w),
                                Text(
                                  controller
                                      .allCompanies[index].companyAddress!,
                                  style: TextStyle(
                                      fontSize: 10.sp, color: kTextColor),
                                ),
                                // const Spacer(),
                                // Image.asset(Images.fav),
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
          )),
    );
  }
}
