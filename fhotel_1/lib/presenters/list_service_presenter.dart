import 'package:fhotel_1/data/models/hotel_image.dart';
import 'package:fhotel_1/data/models/service.dart';
import 'package:fhotel_1/data/repository/list_service.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/list_hotel_view.dart';
import 'package:fhotel_1/views/service_listing_screen/list_service_view.dart';

class ListServicePresenter {
  final ListServiceView _view;
  final ListServiceRepo _serviceRepo;

  ListServicePresenter(this._view, this._serviceRepo);

  // Method to get the list of hotels
  Future<void> getServices() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<Service> services = await _serviceRepo.getServices();
      _view.onGetServicesSuccess(services); // Pass the data to the view on success
    } catch (error) {
      _view.onGetServicesError(error.toString()); // Pass the error to the view on failure
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }

}
