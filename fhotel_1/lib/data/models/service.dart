class Service {
  String? serviceId;
  String? serviceName;
  int? price;
  String? image;
  String? description;
  String? serviceTypeId;
  bool? isActive;
  ServiceType? serviceType;

  Service(
      {this.serviceId,
        this.serviceName,
        this.price,
        this.image,
        this.description,
        this.serviceTypeId,
        this.isActive,
        this.serviceType});

  Service.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    serviceTypeId = json['serviceTypeId'];
    isActive = json['isActive'];
    serviceType = json['serviceType'] != null
        ? ServiceType.fromJson(json['serviceType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['serviceId'] = serviceId;
    data['serviceName'] = serviceName;
    data['price'] = price;
    data['image'] = image;
    data['description'] = description;
    data['serviceTypeId'] = serviceTypeId;
    data['isActive'] = isActive;
    if (serviceType != null) {
      data['serviceType'] = serviceType!.toJson();
    }
    return data;
  }
}

class ServiceType {
  String? serviceTypeId;
  String? serviceTypeName;

  ServiceType({this.serviceTypeId, this.serviceTypeName});

  ServiceType.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json['serviceTypeId'];
    serviceTypeName = json['serviceTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['serviceTypeId'] = serviceTypeId;
    data['serviceTypeName'] = serviceTypeName;
    return data;
  }
}
