import 'package:fhotel_1/data/repository/auth_service.dart';

import '../views/login_screen/login_view.dart';

class LoginPresenter {
  final LoginView
      _view; // This is the interface for the view (e.g., LoginScreen)
  final AuthService _repository =
      AuthService(); // Create an instance of the network class

  LoginPresenter(this._view); // Initialize with the view

  // Validate email logic
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }
    RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    final isEmailValid = regex.hasMatch(email);
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null; // Email is valid
  }

  // Validate password logic
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    return null; // Password is valid
  }

  // This method will call the authenticate API and handle the result
  Future<void> authenticateUser(String email, String password) async {
    // Validate the form
    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    if (emailError != null) {
      _view.showValidationError('email', emailError);
      return;
    }
    if (passwordError != null) {
      _view.showValidationError('password', passwordError);
      return;
    }

    try {
      // Call the authenticate method from the network layer
      final user = await _repository.authenticate(email, password);
      // If successful, notify the view
      _view.onLoginSuccess(user);

    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onLoginError("You are not allowed to login");
    }
  }
}
