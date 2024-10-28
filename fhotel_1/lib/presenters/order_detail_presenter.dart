import 'package:fhotel_1/data/models/order_detail.dart';
import 'package:fhotel_1/data/repository/order_detail_repo.dart';
import 'package:fhotel_1/views/choose_room_detail/create_reservation_view.dart';

class OrderDetailPresenter {
  final CreateReservationView _view;// This is the interface for the view (e.g., LoginScreen)

  final OrderDetailRepo _repository = OrderDetailRepo(); // Create an instance of the network class

  OrderDetailPresenter(this._view); // Initialize with the view


  // This method will call the authenticate API and handle the result
  Future<OrderDetail> createOrderDetail(
      String orderId,
      String serviceId,
      int quantity,
      ) async {

    try {
      // Create a reservation object to calculate the total amount
      OrderDetail orderDetail = OrderDetail(orderId: orderId, serviceId: serviceId, quantity:  quantity);

      // Call the repository to persist the reservation
      OrderDetail createdOrderDetail = await _repository.create(orderDetail);

      // Notify the view of success
      _view.onCreateSuccess();

      // Return the created reservation
      return createdOrderDetail;
    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onCreateError("Failed to create order detail");

      // Throw an error if reservation creation fails
      throw Exception("Failed to create order detail");
    }
  }
}
