import 'package:fhotel_1/data/models/order_detail.dart';

abstract class GetOrderDetailView {
  void showLoading();

  void hideLoading();

  void showOrderDetail(OrderDetail orderDetail);

  void onGetOrderDetailsSuccess(List<OrderDetail> orderDetails);

}
