import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/constants.dart';
import '../../../controllers/home_controller.dart';
import '../booking/booking_page.dart';
import '../companies/companies_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final controller = Get.find<HomeController>();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (_) {
        switch (currentIndex) {
          case 0:
            return HomePage();
          case 1:
            return const CompaniesPage();
          case 2:
            return BookingPage();
          case 3:
            return ProfilePage();
          default:
            return Container();
        }
      }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimColorL,
        selectedItemColor: kPrimColor,
        unselectedItemColor: kPrimColorLi,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'الشركات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'الحجوزات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }
}
