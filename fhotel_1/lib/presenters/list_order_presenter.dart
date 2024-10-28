import 'package:fhotel_1/data/repository/order_repo.dart';
import 'package:fhotel_1/views/my_service/list_order_view.dart';

class ListOrderPresenter {
  final ListOrderView _view;
  final OrderRepo _orderService = OrderRepo();

  ListOrderPresenter(this._view);

  // Method to get the list of hotels
  void getOrderByCustomerlId() async {
    _view.showLoading();
    try {
      final orders = await _orderService.getOrderByCustomerlId();
      _view.hideLoading();
      _view.onGetOrdersSuccess(orders);
    } catch (e) {
      _view.hideLoading();
      // _view.showError('Failed to load amenities');
    }
  }

}
