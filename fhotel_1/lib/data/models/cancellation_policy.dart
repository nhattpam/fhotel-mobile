class CancellationPolicy {
  String? cancellationPolicyId;
  String? hotelId;
  double? refundPercentage;
  int? cancellationDays;
  String? cancellationTime;
  String? createdDate;
  String? updatedDate;

  CancellationPolicy(
      {this.cancellationPolicyId,
        this.hotelId,
        this.refundPercentage,
        this.cancellationDays,
        this.cancellationTime,
        this.createdDate,
        this.updatedDate});

  CancellationPolicy.fromJson(Map<String, dynamic> json) {
    cancellationPolicyId = json['cancellationPolicyId'];
    hotelId = json['hotelId'];
    refundPercentage = json['refundPercentage'];
    cancellationDays = json['cancellationDays'];
    cancellationTime = json['cancellationTime'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cancellationPolicyId'] = cancellationPolicyId;
    data['hotelId'] = hotelId;
    data['refundPercentage'] = refundPercentage;
    data['cancellationDays'] = cancellationDays;
    data['cancellationTime'] = cancellationTime;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}
