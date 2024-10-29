class Facility {
  String? facilityId;
  String? facilityName;

  Facility({this.facilityId, this.facilityName});

  Facility.fromJson(Map<String, dynamic> json) {
    facilityId = json['facilityId'];
    facilityName = json['facilityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['facilityId'] = facilityId;
    data['facilityName'] = facilityName;
    return data;
  }
}
