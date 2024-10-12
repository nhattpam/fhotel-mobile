import 'package:fhotel_1/views/register_fill_information/register_fill_information_view.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../presenters/register_presenter.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterFillInformationView {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          height: SizeUtils.height,
          child: Container(
            padding: EdgeInsets.all(30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 25, color: Colors.indigoAccent),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Create an account so you can book hotel!",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleSmallMedium,
                ),
                SizedBox(height: 74.h),
                _buildEmailInput(context),
                SizedBox(height: 28.h),
                _buildPasswordInput(context),
                SizedBox(height: 28.h),
                _buildRePasswordInput(context),
                SizedBox(height: 30.h),
                _buildSignInButton(context),
                SizedBox(height: 30.h),
                _buildCreateAccountButton(context),
                SizedBox(height: 8.h),
              ],
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
        if (emailError != null)
          Text(
            emailError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(color: Colors.black),
            fillColor: appTheme.blue50,
            controller: emailInputController,
            hintText: "Email",
            hintStyle: const TextStyle(color: Colors.grey),
            textInputType: TextInputType.emailAddress,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              final error = _presenter.validateEmail(value); // Validate email on change
              setState(() {
                emailError = error; // Clear the error if validation passes
              });
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
        if (passwordError != null)
          Text(
            passwordError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            fillColor: appTheme.blue50,
            controller: passwordInputController,
            hintText: "Password",
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
          ),
        ),
      ],
    );
  }

  Widget _buildRePasswordInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (repasswordError != null)
          Text(
            repasswordError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            fillColor: appTheme.blue50,
            controller: repasswordInputController,
            hintText: "Confirm Password",
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
        final repassword = repasswordInputController.text;

        if (email.isEmpty) {
          setState(() {
            emailError = 'Email cannot be empty';
          });
        }
        if (password.isEmpty) {
          setState(() {
            passwordError = 'Password cannot be empty';
          });
        }
        if (repassword.isEmpty) {
          setState(() {
            repasswordError = 'Confirm Password cannot be empty';
          });
        }
        // Perform final validation
        _presenter.registerValidation(email, password, repassword);
        if (emailError == null && passwordError == null && repasswordError == null) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.registerFillInformation,
            arguments: {
              'email': email,
              'password': password,
            },
          );
        }
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Next Step",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return CustomElevatedButton(
      height: 40.h,
      text: "Already have an account",
      margin: EdgeInsets.only(right: 8.h),
      buttonStyle: CustomButtonStyles.fillwhiteA,
      buttonTextStyle: CustomTextStyles.bodySmallBlack900,
      onPressed: () {
        onTapCreateAccountButton(context);
      },
    );
  }

  void onTapCreateAccountButton(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.initialRoute);
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
