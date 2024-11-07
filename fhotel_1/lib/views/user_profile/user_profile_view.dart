import 'package:fhotel_1/data/models/user.dart';

import '../../data/models/wallet.dart';

abstract class UserProfileView {

  void showValidationError(String field,String message);

  void showLoading();

  void hideLoading();

  void onGetCustomerSuccess(User user);

  void onGetWalletSuccess(Wallet wallet);

  void onGetCustomerError(String error);
}
