import 'package:email_otp/email_otp.dart';
import 'package:fhotel_1/presenters/register_presenter.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/user.dart';
import '../register_fill_information/register_fill_information_view.dart';

class RegisterFillInformationDialog extends StatefulWidget {
  final String email;
  final String password;
  final Function() onCloseDialog;
  final Function(User) onRegisterFillInformation;

  RegisterFillInformationDialog(
      {required this.email,
      required this.password,
      required this.onRegisterFillInformation,
      required this.onCloseDialog});

  @override
  RegisterFillInformationDialogState createState() =>
      RegisterFillInformationDialogState();
}

class RegisterFillInformationDialogState
    extends State<RegisterFillInformationDialog>
    implements RegisterFillInformationView {
  final List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());

  TextEditingController firstNameInputController = TextEditingController();
  TextEditingController lastNameInputController = TextEditingController();
  TextEditingController iDNumberInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController addressInputController = TextEditingController();

  late RegisterPresenter _registerpresenter;
  final picker = ImagePicker();
  bool _isLoading = false;

  EmailOTP myauth = EmailOTP();

  String? firstNameError;
  String? lastNameError;
  String? idNumberError;
  String? phoneNumberError;
  String? addressError;

  @override
  void initState() {
    super.initState();
    _registerpresenter =
        RegisterPresenter(this); // Initialize presenter with the current view
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    // Cancel any subscriptions or async operations here
    firstNameInputController.dispose();
    lastNameInputController.dispose();
    iDNumberInputController.dispose();
    phoneNumberInputController.dispose();
    addressInputController.dispose();
    super.dispose();
  }

  void _unfocusAllExcept(int index) {
    for (int i = 0; i < focusNodes.length; i++) {
      if (i != index) {
        focusNodes[i].unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Điền thông tin'),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              widget.onCloseDialog(); // Close the dialog
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            _buildFirstNameInput(context),
            SizedBox(height: 16.h),
            _buildIDNumberInput(context),
            SizedBox(height: 16.h),
            _buildPhoneNumberInput(context),
            SizedBox(height: 16.h),
            _buildAddressInput(context),
            SizedBox(height: 16.h),
            _buildSignInButton(context),
            SizedBox(height: 8.h)
          ],
        ),
      ),
    );
  }

  Widget _buildFirstNameInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Họ và tên",
          style: TextStyle(color: Colors.blue),
        ),
        if (firstNameError != null)
          Text(
            firstNameError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            focusNode: focusNodes[0],
            fillColor: appTheme.blue50,
            controller: firstNameInputController,
            hintText: "Nhập họ và tên",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.emailAddress,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _registerpresenter
                  .validateName(value); // Validate password on change
              setState(() {
                firstNameError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(0); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIDNumberInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Căn cước công dân",
          style: TextStyle(color: Colors.blue),
        ),
        if (idNumberError != null)
          Text(
            idNumberError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            focusNode: focusNodes[2],
            fillColor: appTheme.blue50,
            controller: iDNumberInputController,
            hintText: "Nhập căn cước công dân",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.number,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) async {
              final error = await _registerpresenter
                  .validateIdNumber(value); // Validate password on change
              setState(() {
                idNumberError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(2); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Số điện thoại",
          style: TextStyle(color: Colors.blue),
        ),
        if (phoneNumberError != null)
          Text(
            phoneNumberError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            focusNode: focusNodes[3],
            fillColor: appTheme.blue50,
            controller: phoneNumberInputController,
            hintText: "Nhập số điện thoại",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.phone,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) async {
              final error = await _registerpresenter
                  .validatePhoneNumber(value); // Validate password on change
              setState(() {
                phoneNumberError =
                    error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(3); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddressInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Địa chỉ",
          style: TextStyle(color: Colors.blue),
        ),
        if (addressError != null)
          Text(
            addressError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            focusNode: focusNodes[4],
            fillColor: appTheme.blue50,
            controller: addressInputController,
            hintText: "Nhập địa chỉ",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.emailAddress,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _registerpresenter
                  .validateAddress(value); // Validate password on change
              setState(() {
                addressError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(4); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        final name = firstNameInputController.text;
        final idNumber = iDNumberInputController.text;
        final phoneNumber = phoneNumberInputController.text;
        final address = addressInputController.text;
        if (name.isEmpty) {
          setState(() {
            firstNameError = 'Không được để trống tên';
          });
        }
        if (idNumber.isEmpty) {
          setState(() {
            idNumberError = 'Không được để trống Căn cước công dân';
          });
        }
        if (phoneNumber.isEmpty) {
          setState(() {
            phoneNumberError = 'Không được để trống số điện thoại';
          });
        }
        if (address.isEmpty) {
          setState(() {
            addressError = 'Không được để trống địa chỉ';
          });
        }
        if (firstNameError == null &&
            lastNameError == null &&
            idNumberError == null &&
            phoneNumberError == null &&
            addressError == null) {
          User user = User(
              email: widget.email,
              password: widget.password,
              name: name,
              address: address,
              identificationNumber: idNumber,
              phoneNumber: phoneNumber,
              isActive: false);
          await _registerpresenter.registerUser(widget.email, widget.password, name, address, idNumber, phoneNumber, '');
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            body: const Center(
              child: Text(
                'Vui lòng kiểm tra OTP đã được gửi về số điện thoại của bạn!!!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            btnOkText: 'Đóng',
            btnOkOnPress: () async {
              widget.onRegisterFillInformation(user);
            },
          ).show();
        }
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Đăng ký",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  @override
  void showValidationError(String field, String message) {
    // setState(() {
    //   if (field == 'email') {
    //     emailError = message;
    //   } else if (field == 'password') {
    //     passwordError = message;
    //   } else if (field == 'repassword') {
    //     repasswordError = message;
    //   }
    // });
  }

  @override
  void onRegisterError(String error) {
    // Display an error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }

  @override
  void onRegisterSuccess() {
    // Handle successful registration (e.g., navigate to a new screen)
    // Navigator.pushReplacementNamed(context, AppRoutes.homePage);
  }
}
