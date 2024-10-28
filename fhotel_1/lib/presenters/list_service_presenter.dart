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
      List<Services> services = await _serviceRepo.getServices();
      print(services);
      _view.onGetServicesSuccess(services); // Pass the data to the view on success
    } catch (error) {
      _view.onGetServicesError(error.toString()); // Pass the error to the view on failure
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }

  Future<void> getServiceById(String serviceId) async {
    _view.showLoading(); // Show loading before fetching data
    try {
      // Call the network method to get the customer by ID
      final service = await _serviceRepo.getServiceById(serviceId);
      // Notify the view about success
      _view.onGetServiceSuccess(service);
    } catch (error) {
      // Notify the view about failure
      _view.onGetServicesError('Error fetching services: $error');
    } finally{
      _view.hideLoading(); // Hide loading after the process
    }
  }
}
