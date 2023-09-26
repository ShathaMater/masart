import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/company_controller.dart';
import 'package:masarat/models/new_trip.dart';
import 'package:masarat/utils/date_time.dart';
import 'package:masarat/utils/extensions.dart';
import 'package:masarat/views/widgets/buttons.dart';
import 'package:masarat/views/widgets/dropdown_menu.dart';
import 'package:masarat/views/widgets/loading_widget.dart';

import '../../widgets/text_field.dart';

class AddTripePage extends StatefulWidget {
  const AddTripePage({super.key});

  @override
  State<AddTripePage> createState() => _AddTripePageState();
}

class _AddTripePageState extends State<AddTripePage> {
  //
  // final companyController = Get.find<CompanyController>();
  //
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();
  final duration = TextEditingController();
  final price = TextEditingController();
  final location = TextEditingController();
  String startDate = '';
  String endDate = '';
  dynamic tripType;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اضافة رحلة')),
      body: GetBuilder(
        init: CompanyController(),
        builder: (controller) => LoadingWidget(
          statusRequest: controller.statusRequest,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // title
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'عنوان الرحلة',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        CustomTextField(
                          controller: title,
                        ),
                      ],
                    ),
                  ),
                  // description
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'وصف الرحلة',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        CustomTextField(
                          controller: description,
                        ),
                      ],
                    ),
                  ),
                  // type
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'تصنيف الرحلة',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        CustomDropDown(
                          items: [
                            'رحلة سياحية',
                            'رحلة دينية',
                            'رحلة علاجية',
                            'رحلة علمية'
                          ]
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                              .toList(),
                          value: tripType,
                          hint: 'اختر تصنيف الرحلة',
                          onChanged: (p0) {
                            setState(() => tripType = p0);
                          },
                        ),
                      ],
                    ),
                  ),
                  // duration
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'مدة الرحلة',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        CustomTextField(
                          controller: duration,
                        ),
                      ],
                    ),
                  ),
                  // price
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'سعر الرحلة',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        CustomTextField(
                          controller: price,
                        ),
                      ],
                    ),
                  ),
                  // place
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'مكان الرحلة',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        CustomTextField(
                          controller: location,
                        ),
                      ],
                    ),
                  ),
                  // start-date
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'تاريخ بداية الرحلة',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        CustomElevatedBtn(
                          onPressed: () async {
                            var date = await DateTimeUtils.pickDate(context);
                            if (date != null) {
                              startDate = '$date'.toDateTimeString()!;
                              setState(() {});
                            }
                          },
                          bgColor: Colors.white,
                          child: Row(
                            children: [
                              Text(
                                startDate,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ), // end-date
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'تاريخ نهاية الرحلة',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                        CustomElevatedBtn(
                          onPressed: () async {
                            var date = await DateTimeUtils.pickDate(context);
                            if (date != null) {
                              endDate = '$date'.toDateTimeString()!;
                              setState(() {});
                            }
                          },
                          bgColor: Colors.white,
                          child: Row(
                            children: [
                              Text(
                                endDate,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                  Container(
                    margin: EdgeInsets.only(top: 20.h, bottom: 40.h),
                    child: CustomElevatedBtn(
                      onPressed: () async {
                        NewTrip trip = NewTrip();
                        trip.id = DateTime.now().toString();
                        trip.titleAr = title.text;
                        trip.descriptionAr = description.text;
                        trip.categoryAr = '$tripType';
                        trip.duration = duration.text;
                        trip.price = price.text;
                        trip.locationAr = location.text;
                        trip.startDate = startDate;
                        trip.endDate = endDate;
                        await controller.addTrip(trip);
                        // for (var trip in NewTrip.newTrips) {
                        //   await controller.addTrip(trip);
                        // }
                      },
                      child: const Text('اضافة'),
                    ),
                  ),

                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
