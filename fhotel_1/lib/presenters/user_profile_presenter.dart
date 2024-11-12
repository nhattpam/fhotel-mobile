import 'package:fhotel_1/data/models/wallet.dart';
import 'package:fhotel_1/data/repository/user_profile_repo.dart';

import '../data/models/user.dart';
import '../data/repository/search_service.dart';
import '../views/user_profile/user_profile_view.dart';

class UserProfilePresenter {
  final UserProfileView _view;
  final UserProfile _repository = UserProfile(); // Initialize the network model
  final SearchService _searchService = SearchService(); // Create an instance of the network class

  UserProfilePresenter(this._view);

  // Validate email logic
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Không được để trống email';
    }
    RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    final isEmailValid = regex.hasMatch(email);
    if (!isEmailValid) {
      return 'Hãy nhập đúng định dạng email';
    }
    return null; // Email is valid
  }

  // Validate password logic
  Future<String?> validateCurrentPassword(String? password) async{
    final exists = await _searchService.checkPasswordExistence(query: password);
    if (!exists) {
      return 'Đây không phải mật khẩu của bạn'; // Notify that the email is already taken
    }
    if (password == null || password.isEmpty) {
      return 'Mật khẩu hiện tại không được để trống';
    }
    return null; // Password is valid
  }

  Future<String?> validatePassword(String? password) async{
    final exists = await _searchService.checkPasswordExistence(query: password);
    if (exists) {
      return 'Mật khẩu mới trùng với mật khẩu hiện tại'; // Notify that the email is already taken
    }
    if (password == null || password.isEmpty) {
      return 'Không được để trống mật khẩu';
    }
    if (password.length < 7) {
      return 'Mật khẩu phải nhiều hơn 6 kí tự';
    }
    return null; // Password is valid
  }

  // Validate confirm password logic
  String? validateRePassword(String? password, String? repassword) {
    if (repassword == null || repassword.isEmpty) {
      return 'Mật khẩu xac nhận không được để trống';
    }
    if (password != repassword ) {
      return 'Mật khẩu không trùng khớp';
    }
    return null; // Password is valid
  }

  // Validate First Name logic
  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Không được để trống tên';
    }
    return null; // First Name is valid
  }
  String? validateBankName(String? bankName) {
    if (bankName == null || bankName.isEmpty) {
      return 'Không được để trống tên tài khoản ngân hàng';
    }
    return null; // First Name is valid
  }
  String? validateBankNumber(String? bankNumber) {
    if (bankNumber == null || bankNumber.isEmpty) {
      return 'Không được để trống số tài khoản ngân hàng';
    }
    return null; // First Name is valid
  }

  // Validate Identification Number logic
  String? validateIdNumber(String? idNumber) {
    if (idNumber == null || idNumber.isEmpty) {
      return 'Không được để trống căn cước công dân';
    }
    if(idNumber.length != 9 && idNumber.length != 12){
      return 'Căn cước công dân phải có 9 hoặc 12 số';
    }
    return null; // Identification Number is valid
  }

  // Validate Phone Number logic
  Future<String?> validatePhoneNumber(String? phoneNumber) async {
    final exists = await _searchService.checkIdNumberExistence(query: phoneNumber);
    if (exists) {
      return 'Số điện thoại này đã được sử dụng'; // Notify that the email is already taken
    }
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Không được để trống số điện thoại';
    }
    if(phoneNumber.length != 10 && phoneNumber.length != 11){
      return 'Số điện thoại phải gồm 10 hoặc 11 số';
    }
    return null; // Phone Number is valid
  }


  // Validate Address logic
  String? validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Không được để trống địa chỉ';
    }
    return null; // Address is valid
  }


  // Function to get customer data by ID
  Future<void> getCustomerById() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      // Call the network method to get the customer by ID
      final customer = await _repository.getUserByCustomerId();
      final wallet = await _repository.getWalletByCustomerId();
      // Notify the view about success
      _view.onGetCustomerSuccess(customer);
      _view.onGetWalletSuccess(wallet);
    } catch (error) {
      // Notify the view about failure
      _view.onGetCustomerError('Error fetching customer: $error');
    } finally{
      _view.hideLoading(); // Hide loading after the process
    }
  }

  Future<void> updateCustomer(
      String customerId,String email,
      String password,
      String name,
      String code,
      String address,
      String idNumber,
      String phoneNumber,
      String imageUrl, bool isActive) async {
    // final nameError = validateName(name);
    // final newPasswordError = await validatePassword(password);
    // final idNumberError = validateIdNumber(idNumber);
    // final phoneNumberError = await validatePhoneNumber(phoneNumber);
    // final addressError = validateAddress(address);
    // // final genderError = validateGender(gender);
    User user = User(userId: customerId,email: email, password: password, name: name, address: address, identificationNumber: idNumber, image: imageUrl, phoneNumber: phoneNumber, isActive: isActive, roleId: 'ef0bf69d-f6c1-4d42-a631-0ed26ec4e879', code: code);
    bool success = await _repository.updateCustomer(user);
    print(user);
    // Call the authenticate method from the network layer
    _view.showLoading();

    if (success) {
      _view.hideLoading();
    } else {
      _view.showLoading();
    }
  }

  Future<void> updateWallet(String customerId,
      String walletId,
      int bankAccountNumber,
      String bankName,
      double balance) async {
    final bankNameError = await validateBankName(bankName);
    final bankNumberError = await validateBankNumber(bankAccountNumber.toString());

    if (bankNameError != null) {
      _view.showValidationError('bankName', bankNameError);
      return;
    }
    if (bankNumberError != null) {
      _view.showValidationError('bankNumber', bankNumberError);
      return;
    }
    // Call the authenticate method from the network layer
    Wallet wallet = Wallet(userId: customerId,balance: balance, bankAccountNumber: bankAccountNumber, bankName: bankName, walletId: walletId);

    _view.showLoading();

    bool success = await _repository.updateWallet(wallet);

    if (success) {
      _view.hideLoading();
    } else {
      _view.showLoading();
    }
  }
}
