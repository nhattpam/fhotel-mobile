import 'package:fhotel_1/data/models/Amenity.dart';

import 'hotel.dart';

class HotelAmenity {
  String? hotelAmenityId;
  String? hotelId;
  String? image;
  Hotel? hotel;
  Amenity? amenity;

  HotelAmenity({this.hotelAmenityId, this.hotelId, this.image, this.hotel, this.amenity});

  HotelAmenity.fromJson(Map<String, dynamic> json) {
    hotelAmenityId = json['hotelAmenityId'];
    hotelId = json['hotelId'];
    image = json['image'];
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
    amenity = json['amenity'] != null ? new Amenity.fromJson(json['amenity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotelAmenityId'] = this.hotelAmenityId;
    data['hotelId'] = this.hotelId;
    data['image'] = this.image;
    if (this.hotel != null) {
      data['hotel'] = this.hotel!.toJson();
    }
    if (this.amenity != null) {
      data['amenity'] = this.amenity!.toJson();
    }
    return data;
  }
}

