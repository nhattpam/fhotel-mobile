import 'package:fhotel_1/data/models/transaction.dart';

abstract class MyTransactionView {
  void showLoading();
  void hideLoading();
  void onGetTransactionsSuccess(List<Transaction> transactions);
  void onGetTransactionsError(String error);
}
