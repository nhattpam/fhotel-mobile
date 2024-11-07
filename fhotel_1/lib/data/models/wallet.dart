class Wallet {
  String? walletId;
  String? userId;
  int? bankAccountNumber;
  String? bankName;
  double? balance;

  Wallet(
      {this.walletId,
        this.userId,
        this.bankAccountNumber,
        this.bankName,
        this.balance});

  Wallet.fromJson(Map<String, dynamic> json) {
    walletId = json['walletId'];
    userId = json['userId'];
    bankAccountNumber = json['bankAccountNumber'];
    bankName = json['bankName'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['walletId'] = walletId;
    data['userId'] = userId;
    data['bankAccountNumber'] = bankAccountNumber;
    data['bankName'] = bankName;
    data['balance'] = balance;
    return data;
  }
}
