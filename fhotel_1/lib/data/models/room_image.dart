import 'package:fhotel_1/data/models/room_types.dart';

class RoomImage {
  String? roomImageId;
  String? roomTypeId;
  String? image;
  RoomType? roomType;

  RoomImage({this.roomImageId, this.roomTypeId, this.image});

  RoomImage.fromJson(Map<String, dynamic> json) {
    roomImageId = json['roomImageId'];
    roomTypeId = json['roomTypeId'];
    image = json['image'];
    roomType = json['roomType'] != null ? new RoomType.fromJson(json['roomType']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['roomImageId'] = roomImageId;
    data['roomTypeId'] = roomTypeId;
    data['image'] = image;
    if (this.roomType != null) {
      data['roomType'] = this.roomType!.toJson();
    }
    return data;
  }
}
