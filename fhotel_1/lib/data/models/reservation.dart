import 'package:fhotel_1/data/models/payment_method.dart';
import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/user.dart';

class Reservation {
  String? customerId;
  String? reservationId;
  String? code;
  String? checkInDate;
  String? checkOutDate;
  double? totalAmount;
  String? reservationStatus;
  String? paymentStatus;
  bool? isPrePaid;
  String? paymentMethodId;
  String? roomTypeId;
  int? numberOfRooms;
  String? createdDate;
  String? actualCheckInTime;
  String? actualCheckOutDate;
  User? customer;
  RoomType? roomType;
  PaymentMethod? paymentMethod;

  Reservation(
      {this.customerId,
      this.reservationId,
      this.code,
        this.checkInDate,
        this.checkOutDate,
        this.totalAmount,
        this.reservationStatus,
        this.paymentStatus,
        this.isPrePaid,
        this.paymentMethodId,
        this.roomTypeId,
        this.numberOfRooms,
        this.createdDate,
        this.actualCheckInTime,
        this.actualCheckOutDate,
        this.customer,
        this.roomType,
        this.paymentMethod
      });

  Reservation.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    reservationId = json['reservationId'];
    code = json['code'];
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    totalAmount = json['totalAmount'];
    reservationStatus = json['reservationStatus'];
    paymentStatus = json['paymentStatus'];
    isPrePaid = json['isPrePaid'];
    paymentMethodId = json['paymentMethodId'];
    roomTypeId = json['roomTypeId'];
    numberOfRooms = json['numberOfRooms'];
    createdDate = json['createdDate'];
    actualCheckInTime = json['actualCheckInTime'];
    actualCheckOutDate = json['actualCheckOutDate'];
    customer = json['customer'] != null ? User.fromJson(json['customer']) : null;
    roomType = json['roomType'] != null ? RoomType.fromJson(json['roomType']) : null;
    paymentMethod = json['paymentMethod'] != null ? PaymentMethod.fromJson(json['paymentMethod']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['customerId'] = customerId;
    data['reservationId'] = reservationId;
    data['code'] = code;
    data['checkInDate'] = checkInDate;
    data['checkOutDate'] = checkOutDate;
    data['totalAmount'] = totalAmount;
    data['reservationStatus'] = reservationStatus;
    data['paymentStatus'] = paymentStatus;
    data['isPrePaid'] = isPrePaid;
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
    if (paymentMethod != null) {
      data['paymentMethod'] = paymentMethod!.toJson();
    }
    return data;
  }
}
