import 'package:get/instance_manager.dart';
import 'package:masarat/controllers/auth_controller.dart';
import 'package:masarat/controllers/home_controller.dart';
import 'package:masarat/controllers/user_reservations_controller.dart';

import '../locale/locale_controller.dart';
import 'company_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LocaleController(), permanent: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => CompanyController(), fenix: true);
    Get.lazyPut(() => UserReservationController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
