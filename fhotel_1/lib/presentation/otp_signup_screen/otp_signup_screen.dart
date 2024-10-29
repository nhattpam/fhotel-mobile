import 'package:fhotel_1/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_pin_code_text_field.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key})
      : super(
          key: key,
        );

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
                        text: "Enter the code from the sms we sent to ",
                        style: theme.textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: "+8801774280874",
                        style: CustomTextStyles.titleSmallMedium,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 44.h),
              Text(
                "02:32",
                style: CustomTextStyles.titleSmallMedium,
              ),
              SizedBox(height: 22.h),
              SizedBox(
                width: double.maxFinite,
                child: CustomPinCodeTextField(
                  context: context,
                  onChanged: (value) {},
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
        styleType: Style.bgFill
    );
  }

  Widget _buildSubmitSection(BuildContext context) {
    return CustomElevatedButton(
      height: 40.h,
      text: "Submit",
      margin: EdgeInsets.only(right: 8.h),
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
    );
  }
}
