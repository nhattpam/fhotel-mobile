import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/user.dart';

class Reservation {
  String? customerId;
  String? reservationId;
  String? checkInDate;
  String? checkOutDate;
  double? totalAmount;
  String? reservationStatus;
  String? paymentMethodStatus;
  String? paymentMethodId;
  String? roomTypeId;
  int? numberOfRooms;
  String? createdDate;
  String? actualCheckInTime;
  String? actualCheckOutDate;
  User? customer;
  RoomType? roomType;

  Reservation(
      {this.customerId,
      this.reservationId,
        this.checkInDate,
        this.checkOutDate,
        this.totalAmount,
        this.reservationStatus,
        this.paymentMethodStatus,
        this.paymentMethodId,
        this.roomTypeId,
        this.numberOfRooms,
        this.createdDate,
        this.actualCheckInTime,
        this.actualCheckOutDate,
        this.customer,
        this.roomType
      });

  Reservation.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    reservationId = json['reservationId'];
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    totalAmount = json['totalAmount'];
    reservationStatus = json['reservationStatus'];
    paymentMethodStatus = json['paymentMethodStatus'];
    paymentMethodId = json['paymentMethodId'];
    roomTypeId = json['roomTypeId'];
    numberOfRooms = json['numberOfRooms'];
    createdDate = json['createdDate'];
    actualCheckInTime = json['actualCheckInTime'];
    actualCheckOutDate = json['actualCheckOutDate'];
    customer = json['customer'] != null ? User.fromJson(json['customer']) : null;
    roomType = json['roomType'] != null ? RoomType.fromJson(json['roomType']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['customerId'] = customerId;
    data['reservationId'] = reservationId;
    data['checkInDate'] = checkInDate;
    data['checkOutDate'] = checkOutDate;
    data['totalAmount'] = totalAmount;
    data['reservationStatus'] = reservationStatus;
    data['paymentMethodStatus'] = paymentMethodStatus;
    data['paymentMethodId'] = paymentMethodId;
    data['roomTypeId'] = roomTypeId;
    data['numberOfRooms'] = numberOfRooms;
    data['createdDate'] = createdDate;
    data['actualCheckInTime'] = actualCheckInTime;
    data['actualCheckOutDate'] = actualCheckOutDate;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (roomType != null) {
      data['roomType'] = roomType!.toJson();
    }
    return data;
  }
}
