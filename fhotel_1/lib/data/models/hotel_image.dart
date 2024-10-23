class HotelImage {
  String? hotelImageId;
  String? hotelId;
  String? image;

  HotelImage({this.hotelImageId, this.hotelId, this.image});

  HotelImage.fromJson(Map<String, dynamic> json) {
    hotelImageId = json['hotelImageId'];
    hotelId = json['hotelId'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['hotelImageId'] = hotelImageId;
    data['hotelId'] = hotelId;
    data['image'] = image;
    return data;
  }
}
