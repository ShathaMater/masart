import 'dart:convert';
import 'package:masarat/models/company.dart';
import 'package:masarat/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPService {
  SPService._();
  static final SPService instance = SPService._();
  late SharedPreferences sp;
  //
  //
  bool isCompany = false;
  bool isAuth = false;
  //
  //
  onInit() async {
    sp = await SharedPreferences.getInstance();
    isAuth = isAuthenticated();
    if (isAuth) isCompany = getUserType() == 'company';
  }

  //

  setAuthenticate(bool value) => sp.setBool('isAuthenticated', value);
  bool isAuthenticated() => sp.getBool('isAuthenticated') ?? false;

  setUserType(String value) => sp.setString('user_type', value);
  String getUserType() => sp.getString('user_type') ?? 'user';

  saveUser(UserModel user) => sp.setString(
        'user_model',
        jsonEncode(user.toJson()),
      );

  saveCompany(CompanyNew companyNew) => sp.setString(
        'company_model',
        jsonEncode(companyNew.toJson()),
      );

  Future<UserModel?> getUser() async {
    UserModel? user;
    var userData = sp.getString('user_model');
    try {
      if (userData != null) {
        var userMap = Map<String, dynamic>.from(jsonDecode(userData));
        user = UserModel.fromJson(userMap);
      }
    } catch (_) {}
    return user;
  }

  Future<CompanyNew?> getUserCompany() async {
    CompanyNew? user;
    var userData = sp.getString('company_model');
    try {
      if (userData != null) {
        var userMap = Map<String, dynamic>.from(jsonDecode(userData));
        user = CompanyNew.fromJson(userMap);
      }
    } catch (_) {}
    return user;
  }

  //
  deleteUser() => sp.clear();

  //
  //
}
