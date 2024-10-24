import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/user.dart';
import '../../presenters/login_presenter.dart';
import 'login_view.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginView {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  late LoginPresenter _presenter;
  bool isLoading = false;
  String? emailError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this); // Initialize presenter with the current view
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            height: SizeUtils.height,
            child: Container(
              padding: EdgeInsets.all(30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Đăng nhập",
                    style: TextStyle(fontSize: 25, color: Colors.indigoAccent),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Xin chào! Đăng nhập để nhận ưu đãi tốt nhất",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                  SizedBox(height: 74.h),
                  _buildEmailInput(context),
                  SizedBox(height: 28.h),
                  _buildPasswordInput(context),
                  SizedBox(height: 30.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.h),
                      child: Text(
                        "Quên mật khẩu?",
                        style: CustomTextStyles.bodyLargeBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  _buildSignInButton(context),
                  SizedBox(height: 30.h),
                  _buildCreateAccountButton(context),
                  SizedBox(height: 8.h),
                  _buildGuetsAccountButton(context)
                ],
              ),
            ),
          ),
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
            focusNode: emailFocusNode,
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
              passwordFocusNode.unfocus(); // Remove focus from password field
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
            focusNode: passwordFocusNode,
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
              emailFocusNode.unfocus(); // Remove focus from password field
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
        _presenter.authenticateUser(email, password); // Call login method from presenter
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Đăng nhập",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return CustomElevatedButton(
      height: 40.h,
      text: "Tạo tài khoản",
      margin: EdgeInsets.only(right: 8.h),
      buttonStyle: CustomButtonStyles.fillwhiteA,
      buttonTextStyle: CustomTextStyles.bodySmallBlack900,
      onPressed: () {
        onTapCreateAccountButton(context);
      },
    );
  }
  Widget _buildGuetsAccountButton(BuildContext context) {
    return CustomElevatedButton(
      height: 40.h,
      text: "Tôi sẽ đăng kí sau",
      margin: EdgeInsets.only(right: 8.h),
      buttonStyle: CustomButtonStyles.fillwhiteA,
      buttonTextStyle: CustomTextStyles.bodyLargeBlue,
      onPressed: () {
        SessionManager().setGuest('guest');
        Navigator.pushReplacementNamed(context, AppRoutes.homePage);
      },
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
    Navigator.pushReplacementNamed(context, AppRoutes.homePage);
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
