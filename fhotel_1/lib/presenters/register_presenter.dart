import 'package:fhotel_1/data/repository/register_customer_repo.dart';
import 'package:fhotel_1/views/register_fill_information/register_fill_information_view.dart';
import '../data/models/user.dart';

class RegisterPresenter {
  final RegisterFillInformationView _view;// This is the interface for the view (e.g., LoginScreen)

  final RegisterCustomerRepo _repository = RegisterCustomerRepo(); // Create an instance of the network class

  RegisterPresenter(this._view); // Initialize with the view

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
  Future<void> registerUser(String email,
      String password,
      String firstName,
      String lastName,
      String address,
      bool gender,
      String idNumber,
      String phoneNumber,
      String imageUrl) async {
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
      User user = User(email: email, password: password, firstName: firstName, lastName: lastName, address: address, identificationNumber: idNumber, image: imageUrl, phoneNumber: phoneNumber, sex: gender);

      await _repository.register(user);

      _view.onRegisterSuccess();

    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onRegisterError("Your account already register");
    }
  }
}
