class Services {
  String? serviceId;
  String? serviceName;
  double? price;
  String? image;
  String? description;
  String? serviceTypeId;
  bool? isActive;

  Services(
      {this.serviceId,
        this.serviceName,
        this.price,
        this.image,
        this.description,
        this.serviceTypeId,
        this.isActive});

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    serviceTypeId = json['serviceTypeId'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = serviceId;
    data['serviceName'] = serviceName;
    data['price'] = price;
    data['image'] = image;
    data['description'] = description;
    data['serviceTypeId'] = serviceTypeId;
    data['isActive'] = isActive;
    return data;
  }
}
