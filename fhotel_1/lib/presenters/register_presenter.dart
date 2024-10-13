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

  // Validate confirm password logic
  String? validateRePassword(String? password, String? repassword) {
    if (repassword == null || repassword.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password != repassword ) {
      return 'Passwords do not match';
    }
    return null; // Password is valid
  }

  // Validate First Name logic
  String? validateFirstName(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return 'First Name cannot be empty';
    }
    return null; // First Name is valid
  }

  // Validate Last Name logic
  String? validateLastName(String? lastName) {
    if (lastName == null || lastName.isEmpty) {
      return 'Last Name cannot be empty';
    }
    return null; // Last Name is valid
  }

  // Validate Identification Number logic
  String? validateIdNumber(String? idNumber) {
    if (idNumber == null || idNumber.isEmpty) {
      return 'Identification Number cannot be empty';
    }
    if(idNumber.length != 9 && idNumber.length != 12){
      return 'Identification Number must be either 9 or 12 digits';
    }
    return null; // Identification Number is valid
  }

  // Validate Phone Number logic
  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone Number cannot be empty';
    }
    if(phoneNumber.length != 10 && phoneNumber.length != 11){
      return 'Phone number must be 10 or 11 digits';
    }
    return null; // Phone Number is valid
  }

  // Validate Address logic
  String? validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Address cannot be empty';
    }
    return null; // Address is valid
  }

  // Validate Gender logic
  String? validateGender(String? gender) {
    if (gender == null || gender.isEmpty) {
      return 'Gender cannot be empty';
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
    try {
      final firstNameError = validateFirstName(firstName);
      final lastNameError = validateLastName(lastName);
      final idNumberError = validateIdNumber(idNumber);
      final phoneNumberError = validatePhoneNumber(phoneNumber);
      final addressError = validateAddress(address);
      // final genderError = validateGender(gender);

      if (firstNameError != null) {
        _view.showValidationError('firstName', firstNameError);
        return;
      }
      if (lastNameError != null) {
        _view.showValidationError('lastName', lastNameError);
        return;
      }
      if (idNumberError != null) {
        _view.showValidationError('idNumber', idNumberError);
        return;
      }
      if (phoneNumberError != null) {
        _view.showValidationError('phoneNumber', phoneNumberError);
        return;
      }
      if (addressError != null) {
        _view.showValidationError('address', addressError);
        return;
      }
      // Call the authenticate method from the network layer
      User user = User(email: email, password: password, firstName: firstName, lastName: lastName, address: address, identificationNumber: idNumber, image: imageUrl, phoneNumber: phoneNumber, sex: gender);

      await _repository.register(user);

      _view.onRegisterSuccess();

    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onRegisterError("Your account already register");
    }
  }
  void registerValidation(String email, String password, String confirmPassword) {
    // Validate inputs
    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);
    final repasswordError = validateRePassword(password,confirmPassword);

    if (emailError != null) {
      _view.showValidationError('email', emailError);
      return;
    }
    if (passwordError != null) {
      _view.showValidationError('password',passwordError);
      return;
    }
    if (repasswordError != null) {
      _view.showValidationError('repassword',repasswordError);
      return;
    }

    _view.onRegisterSuccess();

    // If validation passes, navigate to the next screen
  }
}
