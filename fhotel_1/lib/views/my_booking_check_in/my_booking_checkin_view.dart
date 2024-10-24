import 'package:fhotel_1/data/models/room_stay_history.dart';

abstract class ListRoomStayHistoryView {
  void showLoading();
  void hideLoading();
  void onGetRoomStayHistorySuccess(List<RoomStayHistory> history);
  void onGetRoomStayHistoryError(String error);
}
