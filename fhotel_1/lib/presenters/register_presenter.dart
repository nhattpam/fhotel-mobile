import 'package:fhotel_1/data/repository/register_customer_repo.dart';
import 'package:fhotel_1/data/repository/search_service.dart';
import 'package:fhotel_1/views/register_fill_information/register_fill_information_view.dart';

import '../data/models/user.dart';

class RegisterPresenter {
  final RegisterFillInformationView _view;// This is the interface for the view (e.g., LoginScreen)

  final RegisterCustomerRepo _repository = RegisterCustomerRepo(); // Create an instance of the network class

  final SearchService _searchService = SearchService(); // Create an instance of the network class

  RegisterPresenter(this._view); // Initialize with the view

  // Validate email logic
  Future<String?> validateEmail(String? email) async {

    if (email == null || email.isEmpty) {
      return 'Không được để trống email';
    }
    final exists = await _searchService.checkEmailExistence(query: email);
    if (exists) {
      return 'Email này đã được đăng kí'; // Notify that the email is already taken
    }
    RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    final isEmailValid = regex.hasMatch(email);
    if (!isEmailValid) {
      return 'Hãy nhập đúng email';
    }
    return null; // Email is valid
  }

  // Validate password logic
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Không được để trống mật khẩu';
    }
    return null; // Password is valid
  }

  // Validate confirm password logic
  String? validateRePassword(String? password, String? repassword) {
    if (repassword == null || repassword.isEmpty) {
      return 'Không được để trống mật khẩu xác nhận';
    }
    if (password != repassword ) {
      return 'Mật khẩu xác nhận đang không giống với mật khẩu';
    }
    return null; // Password is valid
  }

  // Validate First Name logic
  String? validateName(String? firstName) {
    if (firstName == null || firstName.isEmpty) {
      return 'Không được để trống tên';
    }
    return null; // First Name is valid
  }


  // Validate Identification Number logic
  Future<String?> validateIdNumber(String? idNumber) async{
    final exists = await _searchService.checkIdNumberExistence(query: idNumber);
    if (exists) {
      return 'Căn cước công dân này đã được đăng kí'; // Notify that the email is already taken
    }

    if (idNumber == null || idNumber.isEmpty) {
      return 'Không được để trống Căn cước công dân';
    }
    if(idNumber.length != 9 && idNumber.length != 12){
      return 'Căn cước công dân gồm 9 hoặc 12 kí tự';
    }
    return null; // Identification Number is valid
  }

  // Validate Phone Number logic
  Future<String?> validatePhoneNumber(String? phoneNumber) async {
    final exists = await _searchService.checkIdNumberExistence(query: phoneNumber);
    if (exists) {
      return 'Số điện thoại này đã được đăng kí'; // Notify that the email is already taken
    }
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Không được để trống Số điện thoại';
    }
    if(phoneNumber.length != 10 && phoneNumber.length != 11){
      return 'Số điện thoại gồm 10 hoặc 11 kí tự';
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
      String name,
      String address,
      String idNumber,
      String phoneNumber,
      String imageUrl) async {
    try {
      final nameError = validateName(name);
      final idNumberError = await validateIdNumber(idNumber);
      final phoneNumberError = await validatePhoneNumber(phoneNumber);
      final addressError = validateAddress(address);
      // final genderError = validateGender(gender);

      if (nameError != null) {
        _view.showValidationError('name', nameError);
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
      User user = User(email: email, password: password, name: name, address: address, identificationNumber: idNumber, image: imageUrl, phoneNumber: phoneNumber);

      await _repository.register(user);

      _view.onRegisterSuccess();

    } catch (error) {
      // If there's an error, notify the view of the failure
      print(error);
    }
  }
  void registerValidation(String email, String password, String confirmPassword) async {
    // Validate inputs
    final emailError = await validateEmail(email);
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

  Future<bool> activateAccount(String phone, String otp) async {
    try {
      final user = await _repository.activeAccountByOTP(phone, otp);
      // Assuming that a successful activation returns a non-null user
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

}
