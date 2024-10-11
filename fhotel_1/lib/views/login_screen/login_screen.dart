import 'package:fhotel_1/views/register_screen/register_screen.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/user.dart';
import '../../presenters/login_presenter.dart';

abstract class LoginView {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginView {
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  late LoginPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this); // Initialize presenter with the current view
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          height: SizeUtils.height,
          child: Container(
            padding: EdgeInsets.all(30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login here",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.indigoAccent
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Welcome back you've\nbeen missed!",
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
                      "Forgot your password?",
                      style: CustomTextStyles.bodyLargeBlue,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                _buildSignInButton(context),
                SizedBox(height: 30.h),
                _buildCreateAccountButton(context),
                ///If Login by Facebook or Apple
                // SizedBox(height: 64.h),
                // Text(
                //   "Or continue with",
                //   style: theme.textTheme.titleSmall,
                // ),
                // SizedBox(height: 20.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     CustomIconButton(
                //       height: 44.h,
                //       width: 60.h,
                //       padding: EdgeInsets.all(10.h),
                //       child: CustomImageView(
                //         imagePath: ImageConstant.imgIcSharpFacebook,
                //       ),
                //     ),
                //     SizedBox(width: 10.h),
                //     CustomIconButton(
                //       height: 44.h,
                //       width: 60.h,
                //       padding: EdgeInsets.all(10.h),
                //       child: CustomImageView(
                //         imagePath: ImageConstant.imgIcBaselineApple,
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(height: 8.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: CustomTextFormField(
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        fillColor: appTheme.blue50,
        controller: emailInputController,
        hintText: "Email",
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        textInputType: TextInputType.emailAddress,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: CustomTextFormField(
        fillColor: appTheme.blue50,
        controller: passwordInputController,
        hintText: "Password",
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        obscureText: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      ),
    );
  }

  /// Section Widget
  Widget _buildSignInButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: (){
        _presenter.authenticateUser(emailInputController.text, passwordInputController.text);
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Sign in",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return CustomElevatedButton(
        height: 40.h,
        text: "Create new account",
        margin: EdgeInsets.only(right: 8.h),
        buttonStyle: CustomButtonStyles.fillwhiteA,
        buttonTextStyle: CustomTextStyles.bodySmallBlack900,
        onPressed: () {
          onTapCreateAccountButton(context);
        });
  }

  /// Navigates to the registerScreen 

  @override
  void onLoginSuccess(User user) {
    // Handle login success, e.g., navigate to another screen
    // Navigator.pushReplacementNamed(context, '/home_hotel_region_empty');
    Navigator.pushReplacementNamed(context, AppRoutes.homePage);
  }

  @override
  void onLoginError(String error) {
    // Display an error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }

  onTapCreateAccountButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>  RegisterScreen()),
    );}
}
