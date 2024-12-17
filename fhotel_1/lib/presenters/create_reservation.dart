import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/data/models/caculate.dart';
import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/repository/create_reservation_repo.dart';
import 'package:fhotel_1/views/choose_room_detail/create_reservation_view.dart';

class CreateReservation {
  final CreateReservationView _view;// This is the interface for the view (e.g., LoginScreen)

  final CreateReservationRepo _repository = CreateReservationRepo(); // Create an instance of the network class

  CreateReservation(this._view); // Initialize with the view


  // This method will call the authenticate API and handle the result
  Future<Reservation> createReservation(
      String checkInDate,
      String checkOutDate,
      String roomTypeId,
      int numberOfRooms,
      ) async {

    try {
      // Create a reservation object to calculate the total amount
      Reservation reservationToCalculate = Reservation(
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        numberOfRooms: numberOfRooms,
        roomTypeId: roomTypeId,
      );

      // Calculate the total amount for the reservation
      PricingResult totalAmount = await _repository.calculate(reservationToCalculate);

      // Create the final reservation with the calculated total amount
      Reservation reservation = Reservation(
        customerId: SessionManager().getUserId(),
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        numberOfRooms: numberOfRooms,
        roomTypeId: roomTypeId,
        totalAmount: totalAmount.totalAmount,
      );

      // Call the repository to persist the reservation
      Reservation createdReservation = await _repository.create(reservation);

      // Notify the view of success
      _view.onCreateSuccess();

      // Return the created reservation
      return createdReservation;
    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onCreateError("Failed to create reservation");

      // Throw an error if reservation creation fails
      throw Exception("Failed to create reservation");
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
      print('AAA');
      PricingResult totalAmount = await _repository.calculate(reservationToCalculate);
      print("This" + (totalAmount.totalAmount).toString());
      _view.onCreateTotalAmountSuccess((totalAmount.totalAmount) ?? 1);
      return totalAmount.totalAmount;
    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onCreateError("Failed to create reservation");
    }
  }

  Future<void> createReservationToCalculate2(String checkInDate,
      String checkOutDate,
      String roomTypeId,
      int numberOfRooms,
      ) async {
    try {
      Reservation reservationToCalculate = Reservation(checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfRooms: numberOfRooms, roomTypeId: roomTypeId);
      PricingResult totalAmount = await _repository.calculate(reservationToCalculate);
      print("This is " + (totalAmount.priceBreakdown).toString());
      _view.onCalculateSuccess(totalAmount);
    } catch (error) {
      _view.onCreateError(error.toString());
    }
  }

  Future<int?> calculateAvailable(
      String checkInDate,
      String checkOutDate,
      String roomTypeId,
      ) async {
    try {

      int totalAmount = await _repository.availableRoom(roomTypeId,checkInDate,checkOutDate);
      _view.onCreateAvailableRoomSuccess(totalAmount);
      return totalAmount;
    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onCreateError("Failed to create reservation");
    }
  }

  Future<void> createRefund(String reservationId) async {
    try {
      String message = await _repository.refund(reservationId);
      print(message);
      _view.onCreateRefundSuccess(message);

    } catch (error) {
      // If there's an error, notify the view of the failure
      print(error);
    }
  }
}
