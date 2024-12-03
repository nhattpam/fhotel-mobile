import 'package:fhotel_1/data/repository/get_order_detail_repo.dart';
import 'package:fhotel_1/views/my_service/get_order_detail_view.dart';


class GetOrderDetailPresenter {
  final GetOrderDetailView _view;
  final GetOrderDetailRepo _orderDetailRepo = GetOrderDetailRepo();

  GetOrderDetailPresenter(this._view);

  void getOrderDetailByOrderId(String orderId) async {
    _view.showLoading(); // Show loading indicator
    try {
      final orderDetails = await _orderDetailRepo.getOrderDetailByOrderId(orderId);
      print(orderDetails);
      // Ensure that showFacility is called even if the facilities list is empty
      _view.showOrderDetail(orderDetails);

      // Optionally, you can handle UI updates or messages for empty lists

    } catch (e) {
      print('Error occurred while fetching order detail: $e'); // Log the error
    } finally {
      _view.hideLoading(); // Hide loading indicator in finally block
    }
  }

  void getOrderDetailByReservationId(String reservationId) async {
    _view.showLoading(); // Show loading indicator
    try {
      final reservations = await _orderDetailRepo.getOrderDetailByReservationId(reservationId);
      print(reservations);
      // Ensure that showFacility is called even if the facilities list is empty
      _view.showOrderDetail(reservations);

      // Optionally, you can handle UI updates or messages for empty lists

    } catch (e) {
      print('Error occurred while fetching order detail: $e'); // Log the error
    } finally {
      _view.hideLoading(); // Hide loading indicator in finally block
    }
  }
  void getListOrderDetailByReservationId(String reservationId) async {
    _view.showLoading(); // Show loading indicator
    try {
      final reservations = await _orderDetailRepo.getOrderDetailsByReservationId(reservationId);
      print(reservations);
      // Ensure that showFacility is called even if the facilities list is empty
      _view.onGetOrderDetailsSuccess(reservations);

      // Optionally, you can handle UI updates or messages for empty lists

    } catch (e) {
      print('Error occurred while fetching order detail: $e'); // Log the error
    } finally {
      _view.hideLoading(); // Hide loading indicator in finally block
    }
  }

  void getListOrderDetailByCustomerId() async {
    _view.showLoading();
    try {
      final orders = await _orderDetailRepo.getOrderDetailByCustomerId();
      _view.hideLoading();
      _view.onGetOrderDetailsSuccess(orders);
    } catch (e) {
      _view.hideLoading();
      // _view.showError('Failed to load amenities');
    }
  }
}

