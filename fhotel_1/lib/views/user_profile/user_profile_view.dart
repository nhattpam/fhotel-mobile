import 'package:fhotel_1/data/models/user.dart';

abstract class UserProfileView {
  void onGetCustomerSuccess(User user);

  void onGetCustomerError(String error);
}
