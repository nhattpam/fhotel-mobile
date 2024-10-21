import 'package:fhotel_1/data/models/reservation.dart';

import '../../data/models/hotel.dart';

abstract class ListReservationView {
  void showLoading();
  void hideLoading();
  void onGetReservationsSuccess(List<Reservation> reservations);
  void onGetReservationsError(String error);
}
