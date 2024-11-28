import 'package:fhotel_1/data/models/reservation.dart';

class Bill {
  String? billId;
  String? reservationId;
  double? totalAmount;
  String? createdDate;
  String? billStatus;
  String? lastUpdated;
  Reservation? reservation;

  Bill(
      {this.billId,
        this.reservationId,
        this.totalAmount,
        this.createdDate,
        this.billStatus,
        this.lastUpdated, this.reservation});

  Bill.fromJson(Map<String, dynamic> json) {
    billId = json['billId'];
    reservationId = json['reservationId'];
    totalAmount = json['totalAmount'];
    createdDate = json['createdDate'];
    billStatus = json['billStatus'];
    lastUpdated = json['lastUpdated'];
    reservation = json['reservation'] != null ? Reservation.fromJson(json['reservation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['billId'] = billId;
    data['reservationId'] = reservationId;
    data['totalAmount'] = totalAmount;
    data['createdDate'] = createdDate;
    data['billStatus'] = billStatus;
    data['lastUpdated'] = lastUpdated;
    if (reservation != null) {
      data['reservation'] = reservation!.toJson();
    }
    return data;
  }
}
