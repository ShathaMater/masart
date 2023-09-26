import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/models/new_trip.dart';
import 'package:masarat/views/widgets/loading_widget.dart';
import 'package:masarat/views/widgets/show_toast.dart';
import 'package:moyasar/moyasar.dart';

import '../../../config/env.dart';
import '../../../controllers/user_reservations_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.trip});
  final NewTrip trip;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  //
  final controller = Get.find<UserReservationController>();
  //
  final paymentConfig = PaymentConfig(
    publishableApiKey: Env.publishableApiKey,
    amount: 25758, // SAR 257.58
    description: 'order #1324',
    currency: 'SAR',
    applePay: ApplePayConfig(merchantId: Env.merchantId, label: Env.appName),
  );
  //
  void onPaymentResult(result) {
    log('result ===>>>>  $result');
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          // handle success.
          controller.reserveTrip(widget.trip);
          break;
        case PaymentStatus.failed:
          // handle failure.
          ShowToast.show(msg: result.description ?? '');
          log('errorr ${result.description}');
          break;
        case PaymentStatus.initiated:
          break;
      }
    }

    // handle other type of failures.
    if (result is AuthError) {}
    if (result is ValidationError) {
      log(result.message);
      log(result.errors?.entries.toList().toString() ?? "");
    }
    if (result is PaymentCanceledError) {}
  }

  //
  @override
  Widget build(BuildContext context) {
    paymentConfig.amount =
        (int.tryParse(widget.trip.price ?? '00') ?? 0000) * 100;
    return Scaffold(
      appBar: AppBar(title: const Text('صفحة الدفع')),
      body: GetBuilder(
        init: controller,
        builder: (controller) => LoadingWidget(
          statusRequest: controller.statusRequest,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (Platform.isIOS) ...[
                    ApplePay(
                      config: paymentConfig,
                      onPaymentResult: onPaymentResult,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                      child: Text(
                        'او',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  CreditCard(
                    config: paymentConfig,
                    onPaymentResult: onPaymentResult,
                    locale: const Localization.ar(),
                  ),
                  SizedBox(height: 50.h),
                  // CustomElevatedBtn(
                  //   onPressed: () {
                  //   controller.reserveTrip(widget.trip);
                  //   },
                  //   child: Text(
                  //     'ادفع الان',
                  //     style: TextStyle(
                  //       fontSize: 16.sp,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
