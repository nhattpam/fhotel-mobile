import 'package:fhotel_1/data/models/room_image.dart';
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
  Future<void> loadRoomImages(List<RoomType> roomTypes) async {
    _view.showLoading();
    List<RoomImage> roomImages = [];

    for (var roomType in roomTypes) {
      try {
        List<RoomImage> images = await _listRoomTypeRepo.getRoomImageByRoomTypeId(roomType.roomTypeId.toString());
        roomImages.addAll(images); // Collect all images
      } catch (error) {
        print("Error fetching room images for ${roomType.roomTypeId}: $error");
        // Handle the error appropriately, maybe add a placeholder or null image
        roomImages.add(RoomImage()); // Placeholder for failed requests
      }
    }
    _view.hideLoading();
    _view.onGetRoomImageSuccess(roomImages);
  }

  void getRoomImage(String roomTypeId) async {
    _view.showLoading();
    try {
      final roomImages = await _listRoomTypeRepo.getRoomImageByRoomTypeId(roomTypeId);
      _view.hideLoading();
      _view.onGetRoomImageSuccess(roomImages);
    } catch (e) {
      _view.hideLoading();
      // _view.showError('Failed to load amenities');
    }
  }

  Future<void> getRoomTypeById(String roomTypeId) async {
    _view.showLoading();
    try {
      RoomType roomType = await _listRoomTypeRepo.getRoomTypesByRoomId(roomTypeId);
      _view.onGetRoomTypeSuccess(roomType);
    } catch (error) {
      print("Error fetching room type by ID");
    } finally {
      _view.hideLoading();
    }
  }
}

