import '../../data/models/hotel.dart';

abstract class HotelDetailView {
  void showLoading();

  void hideLoading();

  void onGetHotelSuccess(Hotel hotel);

  void onGetHotelError(String error);
}
