import 'package:fhotel_1/data/models/hotel.dart';
import 'package:fhotel_1/data/models/room_types.dart';

class RoomSearchRequest {
  String? roomTypeName;
  int? quantity;
  RoomType? roomType;
  Hotel? hotel;

  RoomSearchRequest({this.roomTypeName, this.quantity});

  RoomSearchRequest.fromJson(Map<String, dynamic> json) {
    roomTypeName = json['roomTypeName'];
    quantity = json['quantity'];
    roomType = json['roomType'] != null ? new RoomType.fromJson(json['roomType']) : null;
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['roomTypeName'] = roomTypeName;
    data['quantity'] = quantity;
    if (this.roomType != null) {
      data['roomType'] = this.roomType!.toJson();
    }
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    return data;
  }
}
