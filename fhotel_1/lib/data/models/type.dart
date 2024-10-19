class Types {
  String? typeId;
  String? typeName;
  int? maxOccupancy;
  String? createdDate;
  String? updatedDate;

  Types(
      {this.typeId,
        this.typeName,
        this.maxOccupancy,
        this.createdDate,
        this.updatedDate});

  Types.fromJson(Map<String, dynamic> json) {
    typeId = json['typeId'];
    typeName = json['typeName'];
    maxOccupancy = json['maxOccupancy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['typeId'] = typeId;
    data['typeName'] = typeName;
    data['maxOccupancy'] = maxOccupancy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
