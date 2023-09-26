import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../config/constants.dart';

class ShowProgress {
  static Widget show() {
    return Container(
      width: MediaQuery.of(Get.context!).size.width,
      height: MediaQuery.of(Get.context!).size.height,
      color: Colors.black12.withOpacity(0.16),
      alignment: Alignment.center,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
        ),
        child: SpinKitFadingCircle(
          size: 50.r,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven ? kPrimColor : kPrimColorLi,
                borderRadius: BorderRadius.circular(20.r),
              ),
            );
          },
        ),
      ),
    );
  }
}
