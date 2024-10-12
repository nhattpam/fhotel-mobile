import '../../data/models/hotel.dart';

abstract class ListHotelView {
  void showLoading();
  void hideLoading();
  void onGetHotelsSuccess(List<Hotel> hotels);
  void onGetHotelsError(String error);
}
