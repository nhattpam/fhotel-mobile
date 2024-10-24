import 'package:fhotel_1/data/models/user.dart';
import 'package:fhotel_1/presenters/register_presenter.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../presenters/user_profile_presenter.dart';
import '../../widgets/custom_pin_code_text_field.dart';
import '../register_fill_information/register_fill_information_view.dart';
import '../user_profile/user_profile_view.dart';

class OtpSignupDialog extends StatefulWidget {
  final Function() onBackToLogin;
  final User user;
  final String myauth;

  OtpSignupDialog({required this.user, required this.myauth, required this.onBackToLogin});
  @override
  OtpSignupDialogState createState() => OtpSignupDialogState();
}

class OtpSignupDialogState extends State<OtpSignupDialog> implements UserProfileView, RegisterFillInformationView{
  late UserProfilePresenter _presenter;
  String enteredOtp = "";

  late RegisterPresenter _registerpresenter;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = UserProfilePresenter(this); // Initialize presenter with the current view
    _registerpresenter = RegisterPresenter(this);

  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Tạo tài khoản')),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 14.h),
            SizedBox(
              width: double.maxFinite,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Nhập mã đã được gửi về email của bạn ",
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: widget.user.email.toString(),
                      style: CustomTextStyles.titleSmallMedium,
                    )
                  ],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // SizedBox(height: 44.h),
            // Text(
            //   "02:32",
            //   style: CustomTextStyles.titleSmallMedium,
            // ),
            SizedBox(height: 22.h),
            SizedBox(
              width: double.maxFinite,
              child: CustomPinCodeTextField(
                context: context,
                onChanged: (value) {
                  enteredOtp = value;
                },
              ),
            ),
            SizedBox(height: 28.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Tôi chưa nhận được mã",
                    style: CustomTextStyles.bodyMediumGray600,
                  ),
                  const TextSpan(
                    text: " ",
                  ),
                  TextSpan(
                    text: "Gửi lai",
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30.h),
            _buildSubmitSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitSection(BuildContext context) {
    return CustomElevatedButton(
      height: 40.h,
      text: "Submit",
      margin: EdgeInsets.only(right: 8.h),
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      onPressed: () async {
        if (enteredOtp == widget.myauth) {
          await _registerpresenter.activateAccount(widget.user.email.toString());
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            body: const Center(
              child: Text(
                'Hoàn tất đăng kí!!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            // title: 'Warning',
            // desc:   'This is also Ignored',
            btnOkOnPress: () {
              SessionManager().clearSession();
              widget.onBackToLogin();
              // Navigator.pushReplacementNamed(context, AppRoutes.initialRoute);
            },
          ).show();
        } else {
          AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              body: const Center(
                child: Text(
                  'OTP không trùng khớp',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              // title: 'Warning',
              // desc:   'This is also Ignored',
              btnOkOnPress: () {},
              btnOkColor: Colors.red)
            ..show();
        }
      },
    );
  }

  @override
  void showValidationError(String field, String message) {
    // setState(() {
    //   if (field == 'password') {
    //     newPasswordError = message;
    //   } else if (field == 'repassword') {
    //     confirmPasswordError = message;
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

  // Show loading indicator
  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  // Hide loading indicator
  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onGetCustomerSuccess(User customer) {
    setState(() {
      // _customer = customer;
      // _error = null;
    });
  }

  @override
  void onGetCustomerError(String error) {
    setState(() {
      // _error = error;
      // _customer = null;
    });
  }
}