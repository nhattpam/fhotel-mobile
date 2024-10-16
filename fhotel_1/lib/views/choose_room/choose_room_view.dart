import 'package:fhotel_1/data/models/hotel_amenity.dart';
import 'package:fhotel_1/data/models/room_types.dart';

abstract class ChooseRoomView {
  void showLoading();

  void hideLoading();

  void showRoomTypes(List<RoomType> roomTypes);

  void onGetHotelSuccess(RoomType roomType);

}
