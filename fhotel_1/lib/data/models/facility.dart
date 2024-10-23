class Facility {
  String? facilityId;
  String? facilityName;
  int? price;

  Facility({this.facilityId, this.facilityName, this.price});

  Facility.fromJson(Map<String, dynamic> json) {
    facilityId = json['facilityId'];
    facilityName = json['facilityName'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['facilityId'] = facilityId;
    data['facilityName'] = facilityName;
    data['price'] = price;
    return data;
  }
}
