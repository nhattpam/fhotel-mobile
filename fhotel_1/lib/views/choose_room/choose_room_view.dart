import 'package:fhotel_1/data/models/room_facility.dart';
import 'package:fhotel_1/data/models/room_image.dart';
import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/type.dart';

abstract class ChooseRoomView {
  void showLoading();

  void hideLoading();

  void showRoomTypes(List<RoomType> roomTypes);

  void showFacility(List<RoomFacility> facilities);

  void showTypes(List<Types> types);

  void onGetRoomImageSuccess(List<RoomImage> roomImage);
  void onGetSingleRoomImageSuccess(RoomImage roomImage);

  void onGetPriceSuccess(double price);

  void onGetRoomTypeSuccess(RoomType hotel);

}
