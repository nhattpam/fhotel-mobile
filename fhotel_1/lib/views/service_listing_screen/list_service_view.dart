import 'package:fhotel_1/data/models/service.dart';

import '../../data/models/service_type.dart';

abstract class ListServiceView {
  void showLoading();
  void hideLoading();
  void onGetServiceSuccess(Services service);
  void onGetServicesSuccess(List<Services> services);
  void onGetServiceTypesSuccess(List<ServiceType> types);
  void onGetServicesError(String error);
}
