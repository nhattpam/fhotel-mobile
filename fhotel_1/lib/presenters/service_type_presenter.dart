import 'package:fhotel_1/data/repository/service_type_repo.dart';
import 'package:fhotel_1/views/service_listing_screen/list_service_view.dart';

import '../data/models/service_type.dart';

class ServiceTypePresenter {
  final ListServiceView _view;
  final ServiceTypeRepo _serviceTypeRepo;

  ServiceTypePresenter(this._view, this._serviceTypeRepo);

  // Method to get the list of hotels
  Future<void> getServiceTypes() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<ServiceType> types = await _serviceTypeRepo.getServiceTypes();
      _view.onGetServiceTypesSuccess(types); // Pass the data to the view on success
    } catch (error) {
      _view.onGetServicesError(
          error.toString()); // Pass the error to the view on failure
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }
}