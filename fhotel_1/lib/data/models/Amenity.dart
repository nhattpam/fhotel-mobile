class Amenity {
  String? amenityId;
  String? amenityName;
  String? image;

  Amenity({this.amenityId, this.amenityName, this.image});

  Amenity.fromJson(Map<String, dynamic> json) {
    amenityId = json['amenityId'];
    amenityName = json['amenityName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['amenityId'] = amenityId;
    data['amenityName'] = amenityName;
    data['image'] = image;
    return data;
  }
}
