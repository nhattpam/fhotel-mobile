import 'package:fhotel_1/data/models/feedback.dart';

import '../../data/models/hotel.dart';
import '../../data/models/hotel_amenity.dart';

abstract class HotelDetailView {
  void showLoading();

  void hideLoading();

  void showAmenities(List<HotelAmenity> amenities);

  void showFeedbacks(List<Feedbacks> feedbacks);

  void onGetHotelSuccess(Hotel hotel);

  void onGetHotelError(String error);
}
