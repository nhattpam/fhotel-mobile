import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/data/models/user.dart';
import 'package:fhotel_1/views/login_screen/login_view.dart';
import 'package:flutter/material.dart';

import '../../presenters/login_presenter.dart';

class LoginDialog extends StatefulWidget {
  final Function() onCreateAccount;
  final Function() onLogin;

  LoginDialog({
    required this.onCreateAccount, required this.onLogin,
  });
  @override
  LoginDialogState createState() => LoginDialogState();
}

class LoginDialogState extends State<LoginDialog> implements LoginView{

  final List<FocusNode> focusNodes = List.generate(2, (index) => FocusNode());

  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  bool isLoading = false;
  String? emailError;
  String? passwordError;
  late LoginPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this); // Initialize presenter with the current view
  }

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();
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
      title: Center(child: Text('Đăng nhập')),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEmailInput(context),
            SizedBox(height: 16.h),
            _buildPasswordInput(context),
            SizedBox(height: 16.h),
            _buildSignInButton(context),
            SizedBox(height: 16.h),
            _buildCreateAccountButton(context),
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
            textStyle: const TextStyle(
              color: Colors.black,
            ),
            focusNode: focusNodes[0],
            fillColor: appTheme.blue50,
            controller: emailInputController,
            hintText: "Email",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.emailAddress,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _presenter.validateEmail(value); // Validate email on change
              setState(() {
                emailError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(0); // Remove focus from password field
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
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
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
              _unfocusAllExcept(1); // Remove focus from password field
            },
          ),
        ),
      ],
    );
  }


  Widget _buildSignInButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        final email = emailInputController.text;
        final password = passwordInputController.text;
        _presenter.authenticateUser(email, password); // Handle login
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Đăng nhập",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: widget.onCreateAccount, // Go to register dialog
      text: "Tạo tài khoản",
      height: 40.h,
      margin: EdgeInsets.only(right: 8.h),
      buttonStyle: CustomButtonStyles.fillwhiteA,
      buttonTextStyle: CustomTextStyles.bodyLargeBlue,
    );
  }

  @override
  void showValidationError(String field, String message) {
    setState(() {
      if (field == 'email') {
        emailError = message;
      } else if (field == 'password') {
        passwordError = message;
      }
    });
  }

  @override
  void showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) {
    // Handle login success, e.g., navigate to another screen
    widget.onLogin();
  }

  @override
  void onLoginError(String error) {
    // Display an error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }

  void onTapCreateAccountButton(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.registerPage);
  }
}
