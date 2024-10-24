import '../data/repository/list_room_stay_history.dart';
import '../views/my_booking_check_in/my_booking_checkin_view.dart';

class ListRoomStayHistoryPresenter {
  final ListRoomStayHistoryView _view;
  final ListRoomStayHistory _listRoomStayHistory;

  ListRoomStayHistoryPresenter(this._view, this._listRoomStayHistory);

  void getRoomStayHistoryByReservationId(String reservationId) async {
    _view.showLoading();
    try {
      final histories = await _listRoomStayHistory.getRoomStayHistoryByReservationId(reservationId);
      _view.onGetRoomStayHistorySuccess(histories);
    } catch (e) {
      _view.hideLoading();
      // _view.showError('Failed to load amenities');
    }
  }

}
