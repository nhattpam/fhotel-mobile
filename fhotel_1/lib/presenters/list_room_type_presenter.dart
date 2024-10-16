import 'package:fhotel_1/data/repository/list_room_type_repo.dart';
import 'package:fhotel_1/views/choose_room/choose_room_view.dart';

import '../data/models/room_types.dart';


class ListRoomTypePresenter {
  final ChooseRoomView _view;
  final ListRoomTypeRepo _listRoomTypeRepo;

  ListRoomTypePresenter(this._view, this._listRoomTypeRepo);

  void getRoomTypes(String hotelId) async {
    print('getRoomTypes called with hotelId: $hotelId'); // Log method call
    _view.showLoading(); // Show loading indicator
    try {
      final roomTypes = await _listRoomTypeRepo.fetchRoomTypesByHotelId(hotelId);
      print('Before showing room types: $roomTypes'); // Print room types
      _view.showRoomTypes(roomTypes); // Call this method to pass data
    } catch (e) {
      print('Error occurred while fetching room types: $e'); // Log the error
      _view.hideLoading(); // Hide loading on error
    }
  }

}

