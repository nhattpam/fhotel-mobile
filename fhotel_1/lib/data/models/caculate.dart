class Calculate {
  double? totalAmount;
  String? priceBreakdown;

  Calculate({this.totalAmount, this.priceBreakdown});

  Calculate.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    priceBreakdown = json['priceBreakdown'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['totalAmount'] = totalAmount;
    data['priceBreakdown'] = priceBreakdown;
    return data;
  }
}
