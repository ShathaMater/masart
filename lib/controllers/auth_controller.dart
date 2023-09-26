import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:masarat/Networking/status_request.dart';
import 'package:masarat/models/company.dart';
import 'package:masarat/models/user.dart';
import 'package:masarat/services/sp_services.dart';
import 'package:masarat/views/auth/login_page.dart';
import 'package:masarat/views/company_app/company_base/company_base.dart';
import 'package:masarat/views/user_app/base/base_page.dart';
import 'package:masarat/views/widgets/show_toast.dart';

class AuthController extends GetxController {
  StatusRequest statusRequest = StatusRequest.ideal;
  updateStatus(StatusRequest status) {
    statusRequest = status;
    update();
  }

  //
  RxInt onboardingPage = 0.obs;
  UserModel? userModel;
  CompanyNew? companyNew;

  //
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // login
  Future lgoin(String email, String password, bool isCompany) async {
    updateStatus(StatusRequest.loading);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log('id1 ==> ${credential.user!.uid}');
      bool isFound = isCompany
          ? await fetchUserCompanyFirestore(credential.user!.uid)
          : await fetchUserFirestore(credential.user!.uid);
      if (isFound) {
        SPService.instance.setAuthenticate(true);
        if (isCompany) {
          SPService.instance.setUserType('company');
          Get.to(() => const CompanyBasePage());
        } else {
          SPService.instance.setUserType('user');
          Get.to(() => const BasePage());
        }
        ShowToast.show(msg: 'تم التسجيل بنجاح', isSuccess: true);
      } else {
        ShowToast.show(msg: 'المستخدم غير موجود', isSuccess: false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ShowToast.show(
          msg: 'لم يتم العثور على مستخدم لهذا البريد الإلكتروني ، قم بالتسجيل',
        );
      } else if (e.code == 'wrong-password') {
        ShowToast.show(msg: 'كلمة المرور الخاطئة لهذا المستخدم.');
      }
    }
    updateStatus(StatusRequest.ideal);
  }

  // register
  registerUser(String email, String password, String username) async {
    updateStatus(StatusRequest.loading);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // save-data
      try {
        Map<String, dynamic> userData = {
          'uid': credential.user!.uid,
          'email': credential.user!.email,
          'username': username,
          'timestamp': FieldValue.serverTimestamp(),
        };
        userModel = UserModel.fromJson(userData);
        SPService.instance.setAuthenticate(true);
        SPService.instance.setUserType('user');
        SPService.instance.saveUser(userModel!);
        await firestore
            .collection('users_list')
            .doc(credential.user!.uid)
            .set(userData);
        log('User data saved to Firestore successfully.');
      } catch (e) {
        log('Error saving user data to Firestore: $e');
      }
      Get.to(() => const BasePage());
      ShowToast.show(msg: 'تم التسجيل بنجاح', isSuccess: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ShowToast.show(msg: 'كلمة المرور المقدمة ضعيفة للغاية.');
      } else if (e.code == 'email-already-in-use') {
        ShowToast.show(msg: 'الحساب موجود بالفعل لهذا البريد الإلكتروني.');
      }
    } catch (e) {
      ShowToast.show(msg: '$e');
    }
    updateStatus(StatusRequest.ideal);
  }

  // company
  registerCompany(CompanyNew company, String password) async {
    updateStatus(StatusRequest.loading);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: company.email!,
        password: password,
      );
      // save-data
      company.id = credential.user!.uid;
      company.timestamp = FieldValue.serverTimestamp().toString();
      companyNew = company;
      Map<String, dynamic> userData = companyNew!.toJson();
      SPService.instance.setAuthenticate(true);
      SPService.instance.setUserType('company');
      SPService.instance.saveCompany(companyNew!);
      await firestore
          .collection('company_list')
          .doc(credential.user!.uid)
          .set(userData);
      log('User data saved to Firestore successfully.');
      Get.to(() => const CompanyBasePage());
      ShowToast.show(msg: 'تم التسجيل بنجاح', isSuccess: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ShowToast.show(msg: 'كلمة المرور المقدمة ضعيفة للغاية.');
      } else if (e.code == 'email-already-in-use') {
        ShowToast.show(msg: 'الحساب موجود بالفعل لهذا البريد الإلكتروني.');
      }
    } catch (e) {
      ShowToast.show(msg: '$e');
    }
    updateStatus(StatusRequest.ideal);
  }

  // fetch-user
  Future<bool> fetchUserFirestore(String uid) async {
    bool userFound = false;
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('users_list').doc(uid).get();
      if (snapshot.exists) {
        var userData = snapshot.data() as Map<String, dynamic>;
        log('id2 ==> ${userData['id']}');
        userModel = UserModel.fromJson(userData);
        SPService.instance.saveUser(userModel!);
        userFound = true;
      } else {
        log('User data not found in Firestore.');
        userFound = false;
      }
    } catch (e) {
      log('Error fetching user data from Firestore: $e');
    }
    return userFound;
  }

  // fetch-company-user
  Future<bool> fetchUserCompanyFirestore(String uid) async {
    bool userFound = false;
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('company_list').doc(uid).get();
      if (snapshot.exists) {
        var userData = snapshot.data() as Map<String, dynamic>;
        log('id2 ==> ${userData['id']}');
        companyNew = CompanyNew.fromJson(userData);
        SPService.instance.saveCompany(companyNew!);
        userFound = true;
      } else {
        log('User data not found in Firestore.');
        userFound = false;
      }
    } catch (e) {
      log('Error fetching user data from Firestore: $e');
    }
    return userFound;
  }

  // update-user-data
  updateUser() async {
    var userData = userModel!.toJson();
    SPService.instance.saveUser(userModel!);
    await firestore.collection('users_list').doc(userModel!.id).set(userData);
  }

  // logout
  logout() {
    SPService.instance.deleteUser();
    Get.offAll(() => const LoginPage());
  }

  // on-ready
  @override
  void onInit() async {
    super.onInit();
    if (!SPService.instance.isAuth) return;
    if (!SPService.instance.isCompany) {
      var user = await SPService.instance.getUser();
      log('user-id ===>>>> ${user?.id!}');
      await fetchUserFirestore(user!.id!);
    } else if (SPService.instance.isCompany) {
      var user = await SPService.instance.getUserCompany();
      log('company-id ===>>>> ${user?.id!}');
      await fetchUserCompanyFirestore(user!.id!);
    }
  }
}
