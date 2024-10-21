import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/repository/list_reservation_repo.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/list_hotel_view.dart';
import 'package:fhotel_1/views/tabbar_booking_and_service/list_reservation_view.dart';

import '../data/models/hotel.dart';
import '../data/repository/list_hotel_repo.dart';

class ListReservationPresenter {
  final ListReservationView _view;
  final ListReservationRepo _reservationRepo;

  ListReservationPresenter(this._view, this._reservationRepo);

  // Method to get the list of hotels
  Future<void> getListReservationByCustomerId() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<Reservation> reservations = await _reservationRepo.getListReservationByCustomerId();

      _view.onGetReservationsSuccess(reservations); // Pass the data to the view on success
    } catch (error) {
      _view.onGetReservationsError(error.toString()); // Pass the error to the view on failure
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }

}
