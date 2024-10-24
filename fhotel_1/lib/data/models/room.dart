import 'package:fhotel_1/data/models/room_types.dart';

class Room {
  String? roomId;
  int? roomNumber;
  String? roomTypeId;
  String? status;
  String? createdDate;
  String? updatedDate;
  String? note;
  RoomType? roomType;

  Room(
      {this.roomId,
        this.roomNumber,
        this.roomTypeId,
        this.status,
        this.createdDate,
        this.updatedDate,
        this.note,
      this.roomType});

  Room.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    roomNumber = json['roomNumber'];
    roomTypeId = json['roomTypeId'];
    status = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    note = json['note'];
    roomType = json['roomType'] != null ? RoomType.fromJson(json['roomType']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['roomId'] = roomId;
    data['roomNumber'] = roomNumber;
    data['roomTypeId'] = roomTypeId;
    data['status'] = status;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['note'] = note;
    data['roomType'] = roomType;
    return data;
  }
}
