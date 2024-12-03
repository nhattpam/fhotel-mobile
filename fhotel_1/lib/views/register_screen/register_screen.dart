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
                  "Tạo tài khoản",
                  style: TextStyle(fontSize: 25, color: Colors.indigoAccent),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Tạo tài khoản để trải nghiệm những dịch vụ của chúng tôi!!",
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
            hintText: "Nhập email",
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
            hintText: "Nhập mật khẩu",
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
            hintText: "Nhập mật khẩu xác nhận",
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

  Widget _buildSignInButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        final email = emailInputController.text;
        final password = passwordInputController.text;
        final repassword = repasswordInputController.text;

        if (email.isEmpty) {
          setState(() {
            emailError = 'Không được để trống Email';
          });
        }
        if (password.isEmpty) {
          setState(() {
            passwordError = 'Không được để trống mật khẩu';
          });
        }
        if (password.length < 7) {
          setState(() {
            passwordError = 'Mật khẩu phải lớn hơn 6 kí tự';
          });
        }
        if (repassword.isEmpty) {
          setState(() {
            repasswordError = 'Không được để trống mật khẩu xác nhận';
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
      text: "Bước kế tiếp",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return CustomElevatedButton(
      height: 40.h,
      text: "Đã có tài khoản",
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
