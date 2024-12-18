import 'package:fhotel_1/data/models/reservation.dart';

abstract class ListReservationView {
  void showLoading();
  void hideLoading();
  void onGetReservationsSuccess(List<Reservation> reservations);
  void onGetReservationSuccess(Reservation reservation);
  void onGetReservationsError(String error);
}
