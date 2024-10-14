import 'hotel.dart';

class HotelAmenity {
  String? hotelAmenityId;
  String? hotelId;
  String? image;
  Hotel? hotel;

  HotelAmenity({this.hotelAmenityId, this.hotelId, this.image, this.hotel});

  HotelAmenity.fromJson(Map<String, dynamic> json) {
    hotelAmenityId = json['hotelAmenityId'];
    hotelId = json['hotelId'];
    image = json['image'];
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotelAmenityId'] = this.hotelAmenityId;
    data['hotelId'] = this.hotelId;
    data['image'] = this.image;
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    return data;
  }
}

