import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:masarat/models/company.dart';
import 'package:masarat/models/new_trip.dart';
import 'package:masarat/views/widgets/show_toast.dart';

import '../Networking/status_request.dart';
import '../services/sp_services.dart';

class HomeController extends GetxController {
  StatusRequest statusRequest = StatusRequest.ideal;
  updateStatus(StatusRequest status) {
    statusRequest = status;
    update();
  }

  //
  String? userId;
  //
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  List<NewTrip> allTrips = [];
  List<NewTrip> tourismTrips = [];
  List<NewTrip> religiousTrips = [];
  List<NewTrip> medicalTrips = [];
  List<NewTrip> scientificTrips = [];
  List<NewTrip> searchTrips = [];
  //
  List<CompanyNew> allCompanies = [];
  //
  List<NewTrip> wishlist = [];

  //
  Future fecthTrips() async {
    updateStatus(StatusRequest.loading);
    try {
      CollectionReference trips = firestore.collection('trips');
      QuerySnapshot querySnapshot = await trips.get();
      //
      allTrips = querySnapshot.docs.map((doc) {
        return NewTrip.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      log('all-trips-length ===>> ${allTrips.length}');
      //
    } catch (e) {
      ShowToast.show(msg: 'Error fetching users from Firestore: $e');
    }
    updateStatus(StatusRequest.ideal);
  }

  //
  fetchCategoryTrips() async {
    tourismTrips.clear();
    religiousTrips.clear();
    medicalTrips.clear();
    scientificTrips.clear();

    for (var trip in allTrips) {
      switch (trip.categoryAr) {
        case 'رحلة سياحية':
        case 'سياحية':
          tourismTrips.add(trip);
          break;
        case 'رحلة دينية':
        case 'دينية':
          religiousTrips.add(trip);
          break;
        case 'رحلة علمية':
        case 'علمية':
          scientificTrips.add(trip);
          break;
        case 'رحلة علاجية':
        case 'علاجية':
          medicalTrips.add(trip);
          break;
        default:
        //
      }
    }

    update();
  }

  //
  fecthCompanies() async {
    allCompanies.clear();
    updateStatus(StatusRequest.loading);
    try {
      //
      CollectionReference trips = firestore.collection('company_list');
      QuerySnapshot querySnapshot = await trips.get();
      //
      allCompanies = querySnapshot.docs.map((doc) {
        return CompanyNew.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      print('all-CompanyNew-length ===>> ${allCompanies.length}');
      //
    } catch (e) {
      ShowToast.show(msg: 'Error fetching allCompanies from Firestore: $e');
    }
    updateStatus(StatusRequest.ideal);
  }

  // search
  search(String txt) async {
    List<NewTrip> list = allTrips
        .where(
          (element) =>
              element.titleAr!.contains(txt) ||
              element.categoryAr!.contains(txt) ||
              element.companyAr!.contains(txt),
        )
        .toList();
    searchTrips = list;
    update();
  }

  // //
  // double userRate = 0.0;
  // bool isRatesContainUser(CompanyNew companyNew) {
  //   bool isContain = false;
  //   companyNew.ratings?.forEach((c) {
  //     if (c.userId == userModel.id) {
  //       userRate = c.rating;
  //       isContain = true;
  //     }
  //   });
  //   return isContain;
  // }

  //

  Future getWishlist() async {
    updateStatus(StatusRequest.loading);
    wishlist.clear();
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> favs = (await firestore
              .collection('wishlist')
              .doc(userId)
              .collection('user_wishlist')
              .get())
          .docs;
      log('fav ==> ${favs.length}');
      for (var trip in favs) {
        // log(trip.data().toString());
        wishlist.add(NewTrip.fromJson(trip.data()));
      }
      log('number of wishlist ===>> ${wishlist.length}');
    } catch (e) {
      ShowToast.show(msg: 'e');
    }
    updateStatus(StatusRequest.ideal);
  }

  add(NewTrip newTrip) async {
    log(newTrip.titleAr!);
    log(userId!);
    if (wishlist.contains(newTrip)) {
      ShowToast.show(msg: 'الرحلة موجودة في المفضلة');
      return;
    }
    updateStatus(StatusRequest.loading);
    try {
      firestore
          .collection('wishlist')
          .doc(userId)
          .collection('user_wishlist')
          .doc(newTrip.id)
          .set(newTrip.toJson());
      await getWishlist();
      fecthTrips();
      ShowToast.show(msg: 'تم الاضافة الي المفضلة بنجاح', isSuccess: true);
    } catch (e) {
      ShowToast.show(msg: 'e');
    }
    updateStatus(StatusRequest.ideal);
  }

  remove(NewTrip newTrip) async {
    log(newTrip.titleAr!);
    log(userId!);
    updateStatus(StatusRequest.loading);
    try {
      firestore
          .collection('wishlist')
          .doc(userId)
          .collection('user_wishlist')
          .doc(newTrip.id)
          .delete();

      log('trip ${newTrip.id}' +
          firestore
              .collection('wishlist')
              .doc(userId)
              .collection('user_wishlist')
              .doc(newTrip.id)
              .toString());

      await getWishlist();
      // fecthTrips();
      ShowToast.show(msg: 'تم ازالة الرحلة من المفضلة بنجاح', isSuccess: true);
    } catch (e) {
      ShowToast.show(msg: 'e');
    }
    updateStatus(StatusRequest.ideal);
  }

  ///
  @override
  void onInit() async {
    super.onInit();
    var user = await SPService.instance.getUser();
    userId = user?.id;
    log('home-user-id ===>>>> $userId');
  }

  ///
}
