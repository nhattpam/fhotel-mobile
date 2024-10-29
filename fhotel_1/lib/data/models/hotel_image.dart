import 'package:fhotel_1/data/models/hotel.dart';

class HotelImage {
  String? hotelImageId;
  String? hotelId;
  String? image;
  Hotel? hotel;

  HotelImage({this.hotelImageId, this.hotelId, this.image, this.hotel});

  HotelImage.fromJson(Map<String, dynamic> json) {
    hotelImageId = json['hotelImageId'];
    hotelId = json['hotelId'];
    image = json['image'];
    hotel = json['hotel'] != null ? Hotel.fromJson(json['hotel']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['hotelImageId'] = hotelImageId;
    data['hotelId'] = hotelId;
    data['image'] = image;
    if (hotel != null) {
      data['hotel'] = hotel!.toJson();
    }
    return data;
  }
}
