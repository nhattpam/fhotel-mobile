import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/models/room.dart';

class RoomStayHistory {
  String? roomStayHistoryId;
  String? reservationId;
  String? roomId;
  String? checkInDate;
  String? checkOutDate;
  String? createdDate;
  String? updatedDate;
  Reservation? reservation;
  Room? room;
  RoomStayHistory(
      {this.roomStayHistoryId,
        this.reservationId,
        this.roomId,
        this.checkInDate,
        this.checkOutDate,
        this.createdDate,
        this.updatedDate,
        this.reservation,
      this.room});

  RoomStayHistory.fromJson(Map<String, dynamic> json) {
    roomStayHistoryId = json['roomStayHistoryId'];
    reservationId = json['reservationId'];
    roomId = json['roomId'];
    checkInDate = json['checkInDate'];
    checkOutDate = json['checkOutDate'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    reservation = json['reservation'] != null ? Reservation.fromJson(json['reservation']) : null;
    room = json['room'] != null ? Room.fromJson(json['room']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['roomStayHistoryId'] = roomStayHistoryId;
    data['reservationId'] = reservationId;
    data['roomId'] = roomId;
    data['checkInDate'] = checkInDate;
    data['checkOutDate'] = checkOutDate;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['reservation'] = reservation;
    data['room'] = room;
    return data;
  }
}
