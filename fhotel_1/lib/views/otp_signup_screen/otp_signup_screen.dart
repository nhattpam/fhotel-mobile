import 'package:fhotel_1/views/register_fill_information/register_fill_information_view.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/user.dart';
import '../../presenters/register_presenter.dart';
import '../../presenters/user_profile_presenter.dart';
import '../../widgets/custom_pin_code_text_field.dart';
import '../user_profile/user_profile_view.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key})
      : super(
          key: key,
        );

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> implements UserProfileView, RegisterFillInformationView {
  late UserProfilePresenter _presenter;
  String enteredOtp = "";
  User? _user;
  String? myauth;
  bool _isLoading = false;
  late RegisterPresenter _registerpresenter;

  @override
  void initState() {
    super.initState();
    _presenter = UserProfilePresenter(
        this); // Initialize presenter with the current view
    _registerpresenter = RegisterPresenter(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the arguments passed safely in didChangeDependencies
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      _user = arguments['user'] as User?; // Extract the User object
      myauth = arguments['otp'] as String?; // Extract the OTP string
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 20.h,
            top: 74.h,
            right: 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "OTP Verification",
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 14.h),
              SizedBox(
                width: double.maxFinite,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Enter the code from the email we sent to ",
                        style: theme.textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: _user?.email.toString(),
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
                      text: "I didn't receive any code.",
                      style: CustomTextStyles.bodyMediumGray600,
                    ),
                    const TextSpan(
                      text: " ",
                    ),
                    TextSpan(
                      text: "RESEND",
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
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
          onTap: () {
            Navigator.pop(context);
          },
          imagePath: ImageConstant.imgChevronLeft,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 16.h,
            bottom: 16.h,
          ),
        ),
        title: AppbarTitle(
          text: "OTP Verify",
          margin: EdgeInsets.only(left: 8.h),
        ),
        styleType: Style.bgFill);
  }

  Widget _buildSubmitSection(BuildContext context) {
    return CustomElevatedButton(
      height: 40.h,
      text: "Submit",
      margin: EdgeInsets.only(right: 8.h),
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      onPressed: () async {
        final customerId = SessionManager().getUserId();
        if (enteredOtp == myauth) {
          await _registerpresenter.activateAccount(_user!.email.toString());
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
              Navigator.pushReplacementNamed(context, AppRoutes.initialRoute);
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
