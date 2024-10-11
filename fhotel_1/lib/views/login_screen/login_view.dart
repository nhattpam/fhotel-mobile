import '../../data/models/user.dart';

abstract class LoginView {
  void onLoginSuccess(User user);

  void onLoginError(String error);
}
