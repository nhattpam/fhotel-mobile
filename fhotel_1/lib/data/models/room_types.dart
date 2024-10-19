import 'package:fhotel_1/data/models/hotel.dart';
import 'package:fhotel_1/data/models/type.dart';

class RoomType {
  String? roomTypeId;
  String? hotelId;
  String? typeId;
  String? description;
  double? roomSize;
  // double? basePrice;
  int? totalRooms;
  int? availableRooms;
  String? createdDate;
  String? updatedDate;
  String? note;
  bool? isActive;
  Hotel? hotel;
  Types? type;

  RoomType(
      {this.roomTypeId,
      this.hotelId,
      this.description,
      this.roomSize,
      this.totalRooms,
      this.availableRooms,
      this.createdDate,
      this.updatedDate,
      this.note,
      this.isActive,
      this.hotel,
      this.type});

  RoomType.fromJson(Map<String, dynamic> json) {
    roomTypeId = json['roomTypeId'];
    hotelId = json['hotelId'];
    description = json['description'];
    roomSize = json['roomSize'];
    totalRooms = json['totalRooms'];
    availableRooms = json['availableRooms'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    note = json['note'];
    isActive = json['isActive'];
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
    type = json['type'] != null ? new Types.fromJson(json['type']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['roomTypeId'] = roomTypeId;
    data['hotelId'] = hotelId;
    data['description'] = description;
    data['roomSize'] = roomSize;
    data['totalRooms'] = totalRooms;
    data['availableRooms'] = availableRooms;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['note'] = note;
    data['isActive'] = isActive;
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}
