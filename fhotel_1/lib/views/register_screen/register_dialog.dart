import 'package:fhotel_1/presenters/register_presenter.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../register_fill_information/register_fill_information_view.dart';

class RegisterDialog extends StatefulWidget {
  final Function() onBackToLogin;
  final Function() onCloseDialog;
  final Function(String, String) onRegisterFillInformation;

  RegisterDialog({
    required this.onBackToLogin, required this.onRegisterFillInformation, required this.onCloseDialog,
  });
  @override
  RegisterDialogState createState() => RegisterDialogState();
}

class RegisterDialogState extends State<RegisterDialog> implements RegisterFillInformationView{
  final List<FocusNode> focusNodes = List.generate(3, (index) => FocusNode());

  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController repasswordInputController = TextEditingController();

  late RegisterPresenter _presenter;
  String? emailError;
  String? passwordError;
  String? repasswordError;

  @override
  void initState() {
    super.initState();
    _presenter = RegisterPresenter(this); // Initialize presenter with the current view
  }

  void _unfocusAllExcept(int index) {
    for (int i = 0; i < focusNodes.length; i++) {
      if (i != index) {
        focusNodes[i].unfocus();
      }
    }
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    emailInputController.dispose();
    passwordInputController.dispose();
    repasswordInputController.dispose();
    // Dispose other controllers here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Tạo tài khoản'),
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
            _buildEmailInput(context),
            SizedBox(height: 16),
            _buildPasswordInput(context),
            SizedBox(height: 16),
            _buildRePasswordInput(context),
            SizedBox(height: 16),
            _buildRegisterButton(context),
            SizedBox(height: 16),
            _buildBackToLoginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(color: Colors.blue),
        ),
        if (emailError != null)
          Text(
            emailError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            focusNode: focusNodes[0],
            textStyle: const TextStyle(color: Colors.black),
            fillColor: appTheme.blue50,
            controller: emailInputController,
            hintText: "Email",
            hintStyle: const TextStyle(color: Colors.grey),
            textInputType: TextInputType.emailAddress,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) async {
              final error = await _presenter.validateEmail(value); // Validate email on change
              setState(() {
                emailError = error; // Clear the error if validation passes
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

  Widget _buildPasswordInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mật khẩu',
          style: TextStyle(color: Colors.blue),
        ),
        if (passwordError != null)
          Text(
            passwordError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            focusNode: focusNodes[1],
            fillColor: appTheme.blue50,
            controller: passwordInputController,
            hintText: "Mật khẩu",
            hintStyle: const TextStyle(color: Colors.grey),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _presenter.validatePassword(value); // Validate password on change
              setState(() {
                passwordError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(1); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRePasswordInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mât khẩu xác nhận',
          style: TextStyle(color: Colors.blue),
        ),
        if (repasswordError != null)
          Text(
            repasswordError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            focusNode: focusNodes[2],
            fillColor: appTheme.blue50,
            controller: repasswordInputController,
            hintText: "Mật khẩu xác nhận",
            hintStyle: const TextStyle(color: Colors.grey),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              // Add validation for confirm password if needed
              final error = _presenter.validateRePassword(value, passwordInputController.text); // Validate repassword
              setState(() {
                repasswordError = error; // Clear the error if validation passes
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

  Widget _buildRegisterButton(BuildContext context) {
    return CustomElevatedButton(
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Tiếp theo",
      margin: EdgeInsets.only(right: 8.h),
      onPressed: () {
        final email = emailInputController.text;
        final password = passwordInputController.text;
        widget.onRegisterFillInformation(
          email,
          password,
        );
      },
    );
  }

  Widget _buildBackToLoginButton(BuildContext context) {
    return CustomElevatedButton(
      height: 40.h,
      onPressed: widget.onBackToLogin,
      text: "Đã có tài khoản?",
      margin: EdgeInsets.only(right: 8.h),
      buttonStyle: CustomButtonStyles.fillwhiteA,
      buttonTextStyle: CustomTextStyles.bodySmallBlack900,
    );
  }
  @override
  void showValidationError(String field, String message) {
    setState(() {
      if (field == 'email') {
        emailError = message;
      } else if (field == 'password') {
        passwordError = message;
      } else if (field == 'repassword') {
        repasswordError = message;
      }
    });
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
