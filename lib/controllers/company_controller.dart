import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:masarat/controllers/auth_controller.dart';
import 'package:masarat/views/widgets/show_toast.dart';

import '../Networking/status_request.dart';
import '../models/new_trip.dart';
import '../models/reservation.dart';
import '../models/user.dart';

class CompanyController extends GetxController {
  StatusRequest statusRequest = StatusRequest.ideal;
  updateStatus(StatusRequest status) {
    statusRequest = status;
    update();
  }

//

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final authController = Get.find<AuthController>();
  //
  List<NewTrip> companyTrips = [];
  List<Reservation> companyReservation = [];
  UserModel? userModel;

  addTrip(NewTrip trip) async {
    updateStatus(StatusRequest.loading);
    try {
      trip.companyId = authController.companyNew?.id;
      trip.companyAr = authController.companyNew?.companyName;
      trip.timestamp = FieldValue.serverTimestamp().toString();
      Map<String, dynamic> jsonTirp = trip.toJson();
      //
      firestore.collection('trips').add(jsonTirp);
      //
      // await firestore.collection('trips').doc(trip.id).set(jsonTirp);
      Get.back();
      ShowToast.show(msg: 'تم اضافة الرحلة بنجاح', isSuccess: true);
    } catch (e) {
      ShowToast.show(msg: '$e');
    }
    updateStatus(StatusRequest.ideal);
  }

  //
  fecthTrips() async {
    updateStatus(StatusRequest.loading);
    try {
      CollectionReference trips = firestore.collection('trips');
      QuerySnapshot querySnapshot = await trips.get();
      //
      List<NewTrip> allTrips = querySnapshot.docs.map((doc) {
        return NewTrip.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      companyTrips.clear();
      for (var trip in allTrips) {
        if (trip.companyId == authController.companyNew!.id) {
          companyTrips.add(trip);
        }
      }
      log('companyTrips-length ===>> ${companyTrips.length}');
      //
    } catch (e) {
      ShowToast.show(msg: 'Error fetching users from Firestore: $e');
    }
    updateStatus(StatusRequest.ideal);
  }
  //

  getMyReservations() async {
    updateStatus(StatusRequest.loading);
    companyReservation.clear();
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> myReservationData =
          (await firestore.collection('reservations').get()).docs;

      for (var reservation in myReservationData) {
        log(reservation.data().toString());
        var res = Reservation.fromJson(reservation.data());
        if (res.companyId == authController.companyNew!.id) {
          companyReservation.add(res);
        }
      }
    } catch (e) {
      ShowToast.show(msg: '$e');
      log(e.toString());
    }
    updateStatus(StatusRequest.ideal);
  }

  Future fetchUser(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('users_list').doc(uid).get();
      var userData = snapshot.data() as Map<String, dynamic>;
      log('id2 ==> ${userData['uid']}');
      userModel = UserModel.fromJson(userData);
    } catch (e) {
      log('Error fetching user data from Firestore: $e');
    }
    update();
  }
  //

  //
}
