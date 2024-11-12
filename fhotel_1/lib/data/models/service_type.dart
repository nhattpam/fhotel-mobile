class ServiceType {
  String? serviceTypeId;
  String? serviceTypeName;
  bool? isVisibleToCustomer;
  ServiceType({this.serviceTypeId, this.serviceTypeName, this.isVisibleToCustomer});

  ServiceType.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json['serviceTypeId'];
    serviceTypeName = json['serviceTypeName'];
    isVisibleToCustomer = json['isVisibleToCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['serviceTypeId'] = serviceTypeId;
    data['serviceTypeName'] = serviceTypeName;
    data['isVisibleToCustomer'] = isVisibleToCustomer;
    return data;
  }
}
