import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/repository/create_reservation_repo.dart';
import 'package:fhotel_1/views/choose_room_detail/create_reservation_view.dart';

class CreateReservation {
  final CreateReservationView _view;// This is the interface for the view (e.g., LoginScreen)

  final CreateReservationRepo _repository = CreateReservationRepo(); // Create an instance of the network class

  CreateReservation(this._view); // Initialize with the view


  // This method will call the authenticate API and handle the result
  Future<void> createReservation(
      String checkInDate,
      String checkOutDate,
      String roomTypeId,
      int numberOfRooms,
      ) async {
    try {
      // final genderError = validateGender(gender);

      // Call the authenticate method from the network layer
      Reservation reservationToCalculate = Reservation(checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfRooms: numberOfRooms, roomTypeId: roomTypeId);
      double totalAmount = await _repository.calculate(reservationToCalculate);
      Reservation reservation = Reservation(customerId: SessionManager().getUserId(), checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfRooms: numberOfRooms, roomTypeId: roomTypeId,totalAmount: totalAmount);
      await _repository.create(reservation);

      _view.onCreateSuccess();

    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onCreateError("Failed to create reservation");
    }
  }
  Future<double?> createReservationToCalculate(
      String checkInDate,
      String checkOutDate,
      String roomTypeId,
      int numberOfRooms,
      ) async {
    try {
      // final genderError = validateGender(gender);

      // Call the authenticate method from the network layer
      Reservation reservationToCalculate = Reservation(checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfRooms: numberOfRooms, roomTypeId: roomTypeId);
      double totalAmount = await _repository.calculate(reservationToCalculate);

      _view.onCreateTotalAmountSuccess(totalAmount);
      return totalAmount;
    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onCreateError("Failed to create reservation");
    }
  }
}
