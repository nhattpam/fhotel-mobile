import 'package:fhotel_1/data/models/user.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../presenters/user_profile_presenter.dart';
import '../user_profile/user_profile_view.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    implements UserProfileView {
  final List<FocusNode> focusNodes = List.generate(3, (index) => FocusNode());

  TextEditingController currentPasswordInputController =
      TextEditingController();
  TextEditingController newPasswordInputController = TextEditingController();
  TextEditingController confirmPasswordInputController =
      TextEditingController();

  late UserProfilePresenter _presenter;
  String? currentPasswordError;
  String? newPasswordError;
  String? confirmPasswordError;

  User? _user;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = UserProfilePresenter(
        this); // Initialize presenter with the current view
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the arguments passed safely in didChangeDependencies
    _user = ModalRoute.of(context)?.settings.arguments as User?;
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
    currentPasswordInputController.dispose();
    newPasswordInputController.dispose();
    confirmPasswordInputController.dispose();
    // Dispose other controllers here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
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
                  "Change Password",
                  style: TextStyle(fontSize: 25, color: Colors.indigoAccent),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Protect your account by change password",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleSmallMedium,
                ),
                SizedBox(height: 74.h),
                _buildCurrentPasswordInput(context),
                SizedBox(height: 28.h),
                _buildNewPasswordInput(context),
                SizedBox(height: 28.h),
                _buildConfirmPasswordInput(context),
                SizedBox(height: 30.h),
                _buildSignInButton(context),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
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
          text: "Change Password",
          margin: EdgeInsets.only(left: 8.h),
        ),
        styleType: Style.bgFill);
  }

  Widget _buildNewPasswordInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (newPasswordError != null)
          Text(
            newPasswordError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            focusNode: focusNodes[0],
            fillColor: appTheme.blue50,
            controller: newPasswordInputController,
            hintText: "New Password",
            hintStyle: const TextStyle(color: Colors.grey),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) async {
              final error = await _presenter
                  .validatePassword(value); // Validate password on change
              setState(() {
                newPasswordError =
                    error; // Clear the error if validation passes
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

  Widget _buildCurrentPasswordInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (currentPasswordError != null)
          Text(
            currentPasswordError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            focusNode: focusNodes[1],
            fillColor: appTheme.blue50,
            controller: currentPasswordInputController,
            hintText: "Current Password",
            hintStyle: const TextStyle(color: Colors.grey),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) async {
              final error = await _presenter.validateCurrentPassword(
                  value); // Validate password on change
              setState(() {
                currentPasswordError =
                    error; // Clear the error if validation passes
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

  Widget _buildConfirmPasswordInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (confirmPasswordError != null)
          Text(
            confirmPasswordError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            focusNode: focusNodes[2],
            fillColor: appTheme.blue50,
            controller: confirmPasswordInputController,
            hintText: "Confirm Password",
            hintStyle: const TextStyle(color: Colors.grey),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) {
              // Add validation for confirm password if needed
              final error = _presenter.validateRePassword(value,
                  newPasswordInputController.text); // Validate repassword
              setState(() {
                confirmPasswordError =
                    error; // Clear the error if validation passes
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
      onPressed: () async {
        final currentPassword = currentPasswordInputController.text;
        final newPassword = newPasswordInputController.text;
        final confirmPassword = confirmPasswordInputController.text;

        if (currentPassword.isEmpty) {
          setState(() {
            currentPasswordError = 'Current Password cannot be empty';
          });
        }
        if (newPassword.isEmpty) {
          setState(() {
            newPasswordError = 'New Password cannot be empty';
          });
        }
        if (confirmPassword.isEmpty) {
          setState(() {
            confirmPasswordError = 'Confirm Password cannot be empty';
          });
        }
        // Perform final validation
        if (currentPasswordError == null &&
            newPasswordError == null &&
            confirmPasswordError == null) {
          await _presenter.updateCustomer(
              _user!.userId.toString(),
              // Assuming User has userId
              _user!.email.toString(),
              // User email
              newPassword,
              // Update with the new password
              _user!.name.toString(),
              // User name
              _user!.address.toString(),
              // User address
              _user!.identificationNumber.toString(),
              // User ID number
              _user!.phoneNumber.toString(),
              // User phone number
              _user!.image.toString(),
              true); // User image
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            body: const Center(
              child: Text(
                'Change Password Success!!!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            // title: 'Warning',
            // desc:   'This is also Ignored',
            btnOkOnPress: () {
              Navigator.pushReplacementNamed(context, AppRoutes.initialRoute);
            },
          ).show();
        }
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Change Password",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  @override
  void showValidationError(String field, String message) {
    setState(() {
      if (field == 'password') {
        newPasswordError = message;
      } else if (field == 'repassword') {
        confirmPasswordError = message;
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
