import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';

import '../../../config/env.dart';

class PeymentCreditCardSheet extends StatefulWidget {
  const PeymentCreditCardSheet({super.key});

  @override
  State<PeymentCreditCardSheet> createState() => _PeymentCreditCardSheetState();
}

class _PeymentCreditCardSheetState extends State<PeymentCreditCardSheet> {
  //
  final paymentConfig = PaymentConfig(
    publishableApiKey: Env.publishableApiKey,
    amount: 25758, // SAR 257.58
    description: 'order #1324',
    // metadata: {'size': '250g'},
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
          break;
        case PaymentStatus.failed:
          // handle failure.
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      constraints: BoxConstraints(maxHeight: context.height - 100),
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 5.h,
                width: 70.w,
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Text(
                'بيانات الدفع',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              if (Platform.isIOS)
                ApplePay(
                  config: paymentConfig,
                  onPaymentResult: onPaymentResult,
                ),
              Container(
                margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: Text(
                  'او',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
              CreditCard(
                config: paymentConfig,
                onPaymentResult: onPaymentResult,
                locale: const Localization.ar(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
