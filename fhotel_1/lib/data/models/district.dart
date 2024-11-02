class District {
  String? districtId;
  String? districtName;
  String? cityId;
  City? city;

  District({this.districtId, this.districtName, this.cityId, this.city});

  District.fromJson(Map<String, dynamic> json) {
    districtId = json['districtId'];
    districtName = json['districtName'];
    cityId = json['cityId'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtId'] = districtId;
    data['districtName'] = districtName;
    data['cityId'] = cityId;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class City {
  String? cityId;
  String? cityName;
  String? postalCode;

  City({this.cityId, this.cityName, this.postalCode});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'];
    cityName = json['cityName'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['postalCode'] = postalCode;
    return data;
  }
}
