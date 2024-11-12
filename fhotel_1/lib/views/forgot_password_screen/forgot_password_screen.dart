import 'package:fhotel_1/views/otp_signup_screen/otp_forgot_screen.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailInputController = TextEditingController();

  bool isLoading = false;
  String? emailError;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailInputController.dispose();
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
                    "Quên mật khẩu",
                    style: TextStyle(fontSize: 25, color: Colors.indigoAccent),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Hãy nhập email của bạn để thay đổi mật khẩu!!",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleSmallMedium,
                  ),
                  SizedBox(height: 74.h),
                  _buildEmailInput(context),
                  SizedBox(height: 30.h),
                  _buildSignInButton(context),
                  SizedBox(height: 30.h),
                  _buildCreateAccountButton(context),
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
            fillColor: appTheme.blue50,
            controller: emailInputController,
            hintText: "Email",
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            textInputType: TextInputType.emailAddress,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              // final error = _presenter.validateEmail(value); // Validate email on change
              // setState(() {
              //   emailError = error; // Clear the error if validation passes
              // });
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
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  OtpForgotScreen()),
        );
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Tiếp theo",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return CustomElevatedButton(
      height: 40.h,
      text: "Đăng nhập",
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
}
