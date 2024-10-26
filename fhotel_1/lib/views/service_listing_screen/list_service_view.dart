import 'package:fhotel_1/data/models/service.dart';

abstract class ListServiceView {
  void showLoading();
  void hideLoading();
  void onGetServicesSuccess(List<Service> hotels);
  void onGetServicesError(String error);
}
