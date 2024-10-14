import 'package:fhotel_1/data/repository/user_profile_repo.dart';

import '../data/models/user.dart';
import '../views/user_profile/user_profile_view.dart';

class UserProfilePresenter {
  final UserProfileView _view;
  final UserProfile _repository = UserProfile(); // Initialize the network model

  UserProfilePresenter(this._view);

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


  // Function to get customer data by ID
  Future<void> getCustomerById() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      // Call the network method to get the customer by ID
      final customer = await _repository.getUserByCustomerId();
      // Notify the view about success
      _view.onGetCustomerSuccess(customer);
    } catch (error) {
      // Notify the view about failure
      _view.onGetCustomerError('Error fetching customer: $error');
    } finally{
      _view.hideLoading(); // Hide loading after the process
    }
  }

  Future<void> updateCustomer(String customerId,String email,
      String password,
      String firstName,
      String lastName,
      String address,
      bool gender,
      String idNumber,
      String phoneNumber,
      String imageUrl,) async {
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
    print("Update in presenter");
    // Call the authenticate method from the network layer
    // User user = User(userId: customerId,email: email, password: password, firstName: firstName, lastName: lastName, address: address, identificationNumber: idNumber, image: imageUrl, phoneNumber: phoneNumber, sex: gender, isActive: true, roleId: 'db52666c-e02b-4ad5-9197-81fef586da44', createdDate: createdDate, updatedDate: DateTime.now().toString());
    User user = User(userId: customerId,email: email, password: password, firstName: firstName, lastName: lastName, address: address, identificationNumber: idNumber, image: imageUrl, phoneNumber: phoneNumber, sex: gender, isActive: true, roleId: 'db52666c-e02b-4ad5-9197-81fef586da44');

    _view.showLoading();

    bool success = await _repository.updateCustomer(user);

    if (success) {
      _view.hideLoading();
    } else {
      _view.showLoading();
    }
  }
}
