import '../../data/models/user.dart';

abstract class LoginView {

  void showValidationError(String field, String message);

  void showLoading();

  void hideLoading();

  void onLoginSuccess(User user);

  void onLoginError(String error);
}
