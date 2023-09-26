import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/auth_controller.dart';

import '../../../config/constants.dart';
import '../../../controllers/home_controller.dart';
import '../compant_profile/profile_c_page.dart';
import '../company_orders/company_orders_page.dart';
import '../company_tripes/company_tripes_page.dart';

class CompanyBasePage extends StatefulWidget {
  const CompanyBasePage({super.key});

  @override
  State<CompanyBasePage> createState() => _CompanyBasePageState();
}

class _CompanyBasePageState extends State<CompanyBasePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>();
    return Scaffold(
      body: Builder(builder: (_) {
        switch (currentIndex) {
          case 0:
            return const CompanyOrdersPage();
          case 1:
            return const ConpanyTripesPage();
          case 2:
            return const CompanyProfile();
          default:
            return Container();
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 5,
          selectedItemColor: kPrimColor,
          unselectedItemColor: kPrimColorL,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.flight),
              label: 'الحجوزات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'الرحلات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_rounded),
              label: 'الملف الشخصي',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.book),
            //   label: 'الحجوزات',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: 'الملف الشخصي',
            // ),
          ],
        ),
      ),
    );
  }
}
