import 'package:fhotel_1/data/models/bill.dart';
import 'package:fhotel_1/data/models/wallet.dart';

class Transaction {
  String? transactionId;
  String? billId;
  String? walletId;
  String? escrowWalletId;
  String? description;
  double? amount;
  String? transactionDate;
  Bill? bill;
  Wallet? wallet;

  Transaction(
      {this.transactionId,
      this.billId,
      this.walletId,
      this.escrowWalletId,
      this.description,
      this.amount,
      this.transactionDate,
      this.bill,
      this.wallet
      });

  Transaction.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    billId = json['billId'];
    walletId = json['walletId'];
    escrowWalletId = json['escrowWalletId'];
    description = json['description'];
    amount = json['amount'];
    transactionDate = json['transactionDate'];
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    bill = json['bill'] != null ? Bill.fromJson(json['bill']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['transactionId'] = transactionId;
    data['billId'] = billId;
    data['walletId'] = walletId;
    data['escrowWalletId'] = escrowWalletId;
    data['description'] = description;
    data['amount'] = amount;
    data['transactionDate'] = transactionDate;
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    if (bill != null) {
      data['bill'] = bill!.toJson();
    }
    return data;
  }
}
