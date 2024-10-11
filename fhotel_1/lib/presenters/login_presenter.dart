import 'package:fhotel_1/data/repository/auth_service.dart';

import '../views/login_screen/login_screen.dart';

class LoginPresenter {
  final LoginView _view; // This is the interface for the view (e.g., LoginScreen)
  final AuthService _network = AuthService(); // Create an instance of the network class

  LoginPresenter(this._view); // Initialize with the view

  // This method will call the authenticate API and handle the result
  Future<void> authenticateUser(String email, String password) async {
    try {
      // Call the authenticate method from the network layer
      final user = await _network.authenticate(email, password);
      // If successful, notify the view
      _view.onLoginSuccess(user);

    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onLoginError("You are not allowed to login");
    }
  }
}

