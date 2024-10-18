import 'package:fhotel_1/data/models/hotel.dart';

class RoomType {
  String? roomTypeId;
  String? hotelId;
  String? typeName;
  String? description;
  double? roomSize;
  double? basePrice;
  int? maxOccupancy;
  int? totalRooms;
  int? availableRooms;
  String? createdDate;
  String? updatedDate;
  String? note;
  bool? isActive;
  Hotel? hotel;

  RoomType(
      {this.roomTypeId,
      this.hotelId,
      this.typeName,
      this.description,
      this.roomSize,
      this.basePrice,
      this.maxOccupancy,
      this.totalRooms,
      this.availableRooms,
      this.createdDate,
      this.updatedDate,
      this.note,
      this.isActive,
      this.hotel});

  RoomType.fromJson(Map<String, dynamic> json) {
    roomTypeId = json['roomTypeId'];
    hotelId = json['hotelId'];
    typeName = json['typeName'];
    description = json['description'];
    roomSize = json['roomSize'];
    basePrice = json['basePrice'];
    maxOccupancy = json['maxOccupancy'];
    totalRooms = json['totalRooms'];
    availableRooms = json['availableRooms'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    note = json['note'];
    isActive = json['isActive'];
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['roomTypeId'] = roomTypeId;
    data['hotelId'] = hotelId;
    data['typeName'] = typeName;
    data['description'] = description;
    data['roomSize'] = roomSize;
    data['basePrice'] = basePrice;
    data['maxOccupancy'] = maxOccupancy;
    data['totalRooms'] = totalRooms;
    data['availableRooms'] = availableRooms;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['note'] = note;
    data['isActive'] = isActive;
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    return data;
  }
}