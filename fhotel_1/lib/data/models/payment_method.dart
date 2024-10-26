class PaymentMethod {
  String? paymentMethodId;
  String? paymentMethodName;

  PaymentMethod({this.paymentMethodId, this.paymentMethodName});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['paymentMethodId'];
    paymentMethodName = json['paymentMethodName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentMethodId'] = this.paymentMethodId;
    data['paymentMethodName'] = this.paymentMethodName;
    return data;
  }
}
