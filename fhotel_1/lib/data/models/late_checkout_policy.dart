class LateCheckOutPolicy {
  String? lateCheckOutPolicyId;
  String? description;
  double? chargePercentage;
  String? createdDate;
  String? updatedDate;

  LateCheckOutPolicy(
      {this.lateCheckOutPolicyId,
        this.description,
        this.chargePercentage,
        this.createdDate,
        this.updatedDate});

  LateCheckOutPolicy.fromJson(Map<String, dynamic> json) {
    lateCheckOutPolicyId = json['lateCheckOutPolicyId'];
    description = json['description'];
    chargePercentage = json['chargePercentage'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lateCheckOutPolicyId'] = lateCheckOutPolicyId;
    data['description'] = description;
    data['chargePercentage'] = chargePercentage;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
