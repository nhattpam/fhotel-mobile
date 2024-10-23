import 'package:fhotel_1/data/models/facility.dart';
import 'package:fhotel_1/data/models/room_image.dart';
import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/type.dart';

abstract class ChooseRoomView {
  void showLoading();

  void hideLoading();

  void showRoomTypes(List<RoomType> roomTypes);

  void showFacility(List<Facility> facilities);

  void showTypes(List<Types> types);

  void onGetRoomImageSuccess(List<RoomImage> roomImage);

  void onGetPriceSuccess(List<double?> price);

  void onGetRoomTypeSuccess(RoomType hotel);

}
