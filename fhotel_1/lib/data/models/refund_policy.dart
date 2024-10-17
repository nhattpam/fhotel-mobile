class RefundPolicy {
  String? refundPolicyId;
  String? cancellationTime;
  double? refundPercentage;
  String? description;
  String? createdDate;
  String? updatedDate;

  RefundPolicy(
      {this.refundPolicyId,
        this.cancellationTime,
        this.refundPercentage,
        this.description,
        this.createdDate,
        this.updatedDate});

  RefundPolicy.fromJson(Map<String, dynamic> json) {
    refundPolicyId = json['refundPolicyId'];
    cancellationTime = json['cancellationTime'];
    refundPercentage = json['refundPercentage'];
    description = json['description'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['refundPolicyId'] = refundPolicyId;
    data['cancellationTime'] = cancellationTime;
    data['refundPercentage'] = refundPercentage;
    data['description'] = description;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
