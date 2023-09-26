import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masarat/models/new_trip.dart';
import 'package:masarat/models/reservation.dart';
import 'package:masarat/views/user_app/base/base_page.dart';
import 'package:masarat/views/widgets/show_toast.dart';

import '../Networking/status_request.dart';
import 'auth_controller.dart';

class UserReservationController extends GetxController {
  //
  StatusRequest statusRequest = StatusRequest.ideal;
  updateStatus(StatusRequest status) {
    statusRequest = status;
    update();
  }
  //

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final authController = Get.find<AuthController>();
  //
  List<Reservation> myReservation = [];
  //

  reserveTrip(NewTrip trip) async {
    updateStatus(StatusRequest.loading);
    try {
      final rese = Reservation();
      rese.userId = authController.userModel?.id;
      rese.companyId = trip.companyId;
      rese.timestamp = FieldValue.serverTimestamp().toString();
      rese.trip = trip;
      firestore
          .collection('user_reservations')
          .doc(authController.userModel?.id)
          .collection('reservations')
          .doc(trip.id)
          .set(rese.toJson());
      firestore.collection('reservations').add(rese.toJson());
      Get.offUntil(
        MaterialPageRoute(builder: (context) => const BasePage()),
        (route) => false,
      );
      ShowToast.show(msg: 'تم اضافة حجز بنجاح', isSuccess: true);
    } catch (e) {
      ShowToast.show(msg: '$e');
    }
    updateStatus(StatusRequest.ideal);
  }

  Future<bool> isTripFoundInDB(String tripID) async {
    bool found = false;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> tripsIds =
        (await firestore
                .collection('user_reservations')
                .doc(authController.userModel?.id)
                .collection('reservations')
                .get())
            .docs;

    for (var trip in tripsIds) {
      if (trip.id == tripID) {
        found = true;
        continue;
      }
    }
    return found;
  }

  getMyReservations() async {
    updateStatus(StatusRequest.loading);
    myReservation.clear();
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> myReservationData =
          (await firestore
                  .collection('user_reservations')
                  .doc(authController.userModel?.id)
                  .collection('reservations')
                  .get())
              .docs;

      log(myReservationData.length.toString());

      for (var reservation in myReservationData) {
        log(reservation.data().toString());
        myReservation.add(Reservation.fromJson(reservation.data()));
      }
    } catch (e) {
      ShowToast.show(msg: '$e');
      log(e.toString());
    }
    updateStatus(StatusRequest.ideal);
  }

  Future<void> updateReservationStatus(String reservationId) async {
    try {
      await firestore
          .collection('user_reservations')
          .doc(authController.userModel?.id)
          .collection('reservations')
          .doc(reservationId)
          .update({'is_active': false});
      await getMyReservations();
      print('Reservation status updated successfully.');
    } catch (e) {
      print('Error updating reservation status: $e');
    }
  }

  //
}
