import '../../data/models/hotel.dart';
import '../../data/models/hotel_amenity.dart';

abstract class HotelDetailView {
  void showLoading();

  void hideLoading();

  void showAmenities(List<HotelAmenity> amenities);

  void onGetHotelSuccess(Hotel hotel);

  void onGetHotelError(String error);
}
