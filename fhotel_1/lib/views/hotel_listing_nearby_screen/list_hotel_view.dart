import 'package:fhotel_1/data/models/hotel_image.dart';

import '../../data/models/hotel.dart';

abstract class ListHotelView {
  void showLoading();
  void hideLoading();
  void onGetHotelsSuccess(List<Hotel> hotels);
  void onGetHotelImagesSuccess(List<HotelImage> hotels);
  void onGetSingleHotelImageSuccess(HotelImage hotels);
  void onGetHotelsError(String error);
}
