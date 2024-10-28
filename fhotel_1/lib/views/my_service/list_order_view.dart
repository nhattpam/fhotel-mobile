import 'package:fhotel_1/data/models/order.dart';

abstract class ListOrderView {
  void showLoading();
  void hideLoading();
  void onGetOrdersSuccess(List<Order> orders);
  void onGetOrdersError(String error);
}
