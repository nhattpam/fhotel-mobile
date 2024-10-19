import 'package:fhotel_1/data/models/hotel.dart';
import 'package:fhotel_1/data/models/room_types.dart';

class RoomSearchRequest {
  String? typeId;
  int? quantity;
  RoomType? roomType;
  Hotel? hotel;

  RoomSearchRequest({this.typeId, this.quantity});

  RoomSearchRequest.fromJson(Map<String, dynamic> json) {
    typeId = json['typeId'];
    quantity = json['quantity'];
    roomType = json['roomType'] != null ? new RoomType.fromJson(json['roomType']) : null;
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['typeId'] = typeId;
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
