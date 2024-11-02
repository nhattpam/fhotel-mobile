import 'package:fhotel_1/data/repository/hotel_detail_repo.dart';
import 'package:fhotel_1/views/hotel_detail/hotel_detail_view.dart';

import '../data/models/hotel.dart';

class HotelDetailPresenter {
  final HotelDetailView _view;
  final HotelDetailRepo _repository = HotelDetailRepo(); // Initialize the network model

  HotelDetailPresenter(this._view);

  // Function to get customer data by ID
  Future<void> getHotelById(String hotelId) async {
    _view.showLoading();
    try {
      Hotel hotel = await _repository.getHotelByHotelId(hotelId);
      _view.onGetHotelSuccess(hotel);
    } catch (error) {
      _view.onGetHotelError(error.toString());
    } finally {
      _view.hideLoading();
    }
  }
  void getHotelAmenities(String hotelId) async {
    _view.showLoading();
    try {
      final amenities = await _repository.fetchAmenitiesByHotelId(hotelId);
      _view.hideLoading();
      _view.showAmenities(amenities);
    } catch (e) {
      _view.hideLoading();
      // _view.showError('Failed to load amenities');
    }
  }
  void getHotelFeedbacks(String hotelId) async {
    _view.showLoading();
    try {
      final feedbacks = await _repository.fetchFeedbacksByHotelId(hotelId);
      _view.hideLoading();
      _view.showFeedbacks(feedbacks);
    } catch (e) {
      _view.hideLoading();
      // _view.showError('Failed to load amenities');
    }
  }
}
