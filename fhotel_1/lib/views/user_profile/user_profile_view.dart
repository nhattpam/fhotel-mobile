import 'package:fhotel_1/data/models/user.dart';

abstract class UserProfileView {

  void showValidationError(String field,String message);

  void showLoading();

  void hideLoading();

  void onGetCustomerSuccess(User user);

  void onGetCustomerError(String error);
}
