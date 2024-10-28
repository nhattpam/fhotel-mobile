import 'package:fhotel_1/data/models/reservation.dart';

class Order {
  String? orderId;
  String? reservationId;
  String? orderedDate;
  String? orderStatus;
  Reservation? reservation;

  Order({this.orderId, this.reservationId, this.orderedDate, this.orderStatus, this.reservation});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    reservationId = json['reservationId'];
    orderedDate = json['orderedDate'];
    orderStatus = json['orderStatus'];
    reservation = json['reservation'] != null ? Reservation.fromJson(json['reservation']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['orderId'] = orderId;
    data['reservationId'] = reservationId;
    data['orderedDate'] = orderedDate;
    data['orderStatus'] = orderStatus;
    if (reservation != null) {
      data['reservation'] = reservation!.toJson();
    }

    return data;
  }
}
