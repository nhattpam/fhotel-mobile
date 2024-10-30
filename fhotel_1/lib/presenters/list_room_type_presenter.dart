import 'package:fhotel_1/data/models/room_image.dart';
import 'package:fhotel_1/data/repository/list_room_type_repo.dart';
import 'package:fhotel_1/views/choose_room/choose_room_view.dart';

import '../data/models/room_types.dart';
import '../data/models/type.dart';


class ListRoomTypePresenter {
  final ChooseRoomView _view;
  final ListRoomTypeRepo _listRoomTypeRepo;

  ListRoomTypePresenter(this._view, this._listRoomTypeRepo);

  void getRoomTypesByHotelId(String hotelId) async {
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


  // Future<void> loadRoomPrice(List<RoomType> roomTypes) async {
  //   _view.showLoading();
  //
  //   List<double?> prices = []; // Declare a list to store prices for each room type
  //
  //   for (var roomType in roomTypes) {
  //     try {
  //       double price = await _listRoomTypeRepo.getRoomPriceByRoomId(roomType.roomTypeId.toString());
  //       prices.add(price); // Add the fetched price to the list
  //     } catch (error) {
  //       print("Error fetching room price for ${roomType.roomTypeId}: $error");
  //       prices.add(null); // Add null or some placeholder value in case of error
  //     }
  //   }
  //
  //   _view.hideLoading();
  //
  //   // Pass the list of prices to the success callback
  //   _view.onGetPriceSuccess(prices);
  // }

  void loadRoomPrice(String roomTypeId) async {
    _view.showLoading();
    try {
      final roomImages = await _listRoomTypeRepo.getRoomPriceByRoomId(roomTypeId);
      _view.hideLoading();
      _view.onGetPriceSuccess(roomImages);
    } catch (e) {
      _view.hideLoading();
      // _view.showError('Failed to load amenities');
    }
  }
  void getRoomImage(String roomTypeId) async {
    _view.showLoading();
    try {
      final roomImages = await _listRoomTypeRepo.getSingleRoomImageByRoomTypeId(roomTypeId);
      _view.hideLoading();
      _view.onGetSingleRoomImageSuccess(roomImages);
    } catch (e) {
      _view.hideLoading();
      // _view.showError('Failed to load amenities');
    }
  }
  void getRoomImages(String roomTypeId) async {
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
  Future<void> getRoomTypes() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<RoomType> hotels = await _listRoomTypeRepo.getRoomTypes();
      _view.showRoomTypes(hotels); // Pass the data to the view on success
    } catch (error) {
      print(error);
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }
  Future<void> getTypes() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<Types> types = await _listRoomTypeRepo.getTypes();
      _view.showTypes(types); // Pass the data to the view on success
    } catch (error) {
      print(error);
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }

  void getFacilityByRoomTypeId(String roomTypeId) async {
    _view.showLoading(); // Show loading indicator
    try {
      final facilities = await _listRoomTypeRepo.getFacilityByRoomTypeId(roomTypeId);

      // Ensure that showFacility is called even if the facilities list is empty
      _view.showFacility(facilities);

      // Optionally, you can handle UI updates or messages for empty lists
      if (facilities.isEmpty) {
        // Handle the case for empty list if needed (e.g., showing a message)
        print('No facilities found for room type ID: $roomTypeId');
      }
    } catch (e) {
      print('Error occurred while fetching facilities: $e'); // Log the error
    } finally {
      _view.hideLoading(); // Hide loading indicator in finally block
    }
  }

}

