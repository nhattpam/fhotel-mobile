import 'package:fhotel_1/views/hotel_listing_nearby_screen/list_hotel_view.dart';

import '../data/models/hotel.dart';
import '../data/repository/list_hotel_repo.dart';

class HotelPresenter {
  final ListHotelView _view;
  final ListHotelRepo _hotelService;

  HotelPresenter(this._view, this._hotelService);

  // Method to get the list of hotels
  Future<void> getHotels() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<Hotel> hotels = await _hotelService.getHotels();
      _view.onGetHotelsSuccess(hotels); // Pass the data to the view on success
    } catch (error) {
      _view.onGetHotelsError(error.toString()); // Pass the error to the view on failure
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }
}
