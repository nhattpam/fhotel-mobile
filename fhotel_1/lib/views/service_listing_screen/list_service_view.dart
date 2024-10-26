import 'package:fhotel_1/data/models/service.dart';

import '../../data/models/service_type.dart';

abstract class ListServiceView {
  void showLoading();
  void hideLoading();
  void onGetServicesSuccess(List<Services> hotels);
  void onGetServiceTypesSuccess(List<ServiceType> types);
  void onGetServicesError(String error);
}
