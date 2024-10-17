import 'package:fhotel_1/data/models/room_image.dart';
import 'package:fhotel_1/data/models/room_types.dart';

abstract class ChooseRoomView {
  void showLoading();

  void hideLoading();

  void showRoomTypes(List<RoomType> roomTypes);

  void onGetRoomImageSuccess(List<RoomImage> roomImage);

  void onGetRoomTypeSuccess(RoomType hotel);

}
