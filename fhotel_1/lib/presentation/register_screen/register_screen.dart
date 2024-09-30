import 'package:fhotel_1/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../home_hotel_region_empty/home_hotel_region_empty.dart';

// ignore_for_file: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key})
      : super(
    key: key,
  );
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController repasswordInputController = TextEditingController();
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
          // decoration: BoxDecoration(
          //   color: appTheme.whiteA700,
          //   image: DecorationImage(
          //     image: AssetImage(
          //       ImageConstant.imgLoginScreen,
          //     ),
          //     fit: BoxFit.fill,
          //   ),
          // ),
          child: Container(
            padding: EdgeInsets.all(30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.indigoAccent
                  ),
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
  Widget _buildRePasswordInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: CustomTextFormField(
        fillColor: appTheme.blue50,
        controller: repasswordInputController,
        hintText: "Confirm Password",
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
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  HomeHotelRegionEmptyScreen()),
        );
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Sign up",
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
        });
  }

  /// Navigates to the registerScreen when the action is triggered.
  onTapCreateAccountButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>  LoginScreen()),
    );
  }
}
