import 'package:fhotel_1/data/models/order.dart';
import 'package:fhotel_1/data/repository/order_repo.dart';
import 'package:fhotel_1/views/choose_room_detail/create_reservation_view.dart';

class OrderPresenter {

  final CreateReservationView
      _view; // This is the interface for the view (e.g., LoginScreen)

  final OrderRepo _repository = OrderRepo(); // Create an instance of the network class

  OrderPresenter(this._view); // Initialize with the view

  // This method will call the authenticate API and handle the result
  Future<Order> createOrder(
    String reservationId,
  ) async {
    try {
      // Create a reservation object to calculate the total amount
      Order order = Order(reservationId: reservationId, orderStatus: 'Pending');

      // Call the repository to persist the reservation
      Order createdOrder = await _repository.create(order);

      // Notify the view of success
      _view.onCreateSuccess();

      // Return the created reservation
      return createdOrder;
    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onCreateError("Failed to create order");

      // Throw an error if reservation creation fails
      throw Exception("Failed to create order");
    }
  }

  Future<void> updateOrder(Order order) async {
    // Call the authenticate method from the network layer
    Order user = Order(
        orderStatus: "Cancelled",
        orderId: order.orderId,
        orderedDate: order.orderedDate,
        reservationId: order.reservationId,
        totalAmount: order.totalAmount,
        billId: order.billId);

    bool success = await _repository.updateOrder(user);
  }
}
