import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masarat/services/sp_services.dart';
import 'package:masarat/views/auth/splash_page.dart';

import 'config/constants.dart';
import 'controllers/app_binding.dart';
import 'firebase_options.dart';
import 'locale/locale_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SPService.instance.onInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Watheq',
          themeMode: ThemeMode.light,
          initialBinding: AppBindings(),
          locale: LocaleController.ins.initLocale,
          fallbackLocale: const Locale('ar'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Almarai',
            primaryColor: kPrimColor,
            scaffoldBackgroundColor: Colors.grey.shade100,
            appBarTheme: const AppBarTheme(
              backgroundColor: kPrimColor,
              centerTitle: true,
            ),
            textTheme: Typography.englishLike2018.apply(
              fontSizeFactor: 1.sp,
              displayColor: Colors.black,
              bodyColor: Colors.black,
              decorationColor: Colors.black,
              fontFamily: 'Almarai',
            ),
          ),
          home: const SplashPage(),
          onInit: () {},
        );
      },
    );
  }
}
