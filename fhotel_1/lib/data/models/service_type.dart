class ServiceType {
  String? serviceTypeId;
  String? serviceTypeName;

  ServiceType({this.serviceTypeId, this.serviceTypeName});

  ServiceType.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json['serviceTypeId'];
    serviceTypeName = json['serviceTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['serviceTypeId'] = serviceTypeId;
    data['serviceTypeName'] = serviceTypeName;
    return data;
  }
}
