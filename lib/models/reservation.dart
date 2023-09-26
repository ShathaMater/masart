import 'package:masarat/models/new_trip.dart';

class Reservation {
  String? id;
  String? companyId;
  String? userId;
  NewTrip? trip;
  String? timestamp;
  bool? isActive;

  Reservation(
      {this.id,
      this.companyId,
      this.userId,
      this.trip,
      this.timestamp,
      this.isActive = true});

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        id: json['id'].toString(),
        companyId: json['companyId'],
        userId: json['userId'],
        timestamp: json['timestamp'].toString(),
        trip: NewTrip.fromJson(json['trip']),
        isActive: json['is_active'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyId': companyId,
        'userId': userId,
        'timestamp': timestamp,
        'trip': trip?.toJson(),
        'is_active': isActive,
      };
}
