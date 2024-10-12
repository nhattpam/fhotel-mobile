import 'package:fhotel_1/presenters/user_profile_presenter.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/user.dart';
import '../user_profile/user_profile_view.dart';

  class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
  }

  class EditProfileScreenState extends State<EditProfileScreen>
  implements UserProfileView {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailoneController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ilovefastController = TextEditingController();

  late UserProfilePresenter _presenter;
  User? _customer;
  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = UserProfilePresenter(this); // Initialize the presenter
    _presenter.getCustomerById(); // Fetch customer data
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 24.h,
                top: 18.h,
                right: 24.h,
              ),
              child: Column(
                children: [
                  Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: BoxDecoration(
                      color: appTheme.gray10002,
                      borderRadius: BorderRadiusStyle.circleBorder50,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // CustomImageView(
                        //   imagePath: ImageConstant.imageNotFound,
                        //   height: 100.h,
                        //   width: double.maxFinite,
                        // )
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildName(context),
                  SizedBox(height: 24.h),
                  _buildEmail(context),
                  SizedBox(height: 24.h),
                  _buildPhone(context),
                  // SizedBox(height: 24.h),
                  // buildBioone(context),
                  SizedBox(height: 30.h)
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildColumnsave(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
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
          text: "Edit Profile",
          margin: EdgeInsets.only(left: 8.h),
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.only(
        //       top: 16.h,
        //       right: 16.h,
        //       bottom: 16.h,
        //     ),
        //     decoration: BoxDecoration(
        //       color: appTheme.black900.withOpacity(0.2),
        //       borderRadius: BorderRadius.circular(
        //         12.h,
        //       ),
        //     ),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         AppbarImage(
        //           imagePath: ImageConstant.imgIconLeft,
        //           margin: EdgeInsets.only(
        //             left: 8.h,
        //             top: 4.h,
        //             bottom: 4.h,
        //           ),
        //         ),
        //         // SizedBox(width: 8.h),
        //         Padding(
        //           padding:
        //           EdgeInsets.only(left: 17.h),
        //           child: const Text(
        //             "|",
        //             style: TextStyle(
        //                 color: Colors.black
        //             ),
        //           ),
        //         ),
        //         AppbarIconbutton(
        //           imagePath: ImageConstant.imgDivider,
        //           margin: EdgeInsets.symmetric(
        //             horizontal: 8.h,
        //             vertical: 4.h,
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        // ],
        styleType: Style.bgFill);
  }

  Widget _buildName(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Full Name".toUpperCase(),
            style: CustomTextStyles.bodyLargeGray600,
          ),
          SizedBox(
            height: 8.h,
          ),
          CustomTextFormField(
            controller: fullNameController,
            hintText: "${_customer?.firstName} ${_customer?.lastName}",
            hintStyle: CustomTextStyles.bodyLargeGray600,
            contentPadding: EdgeInsets.all(20.h),
          )
        ],
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email".toUpperCase(),
            style: CustomTextStyles.bodyLargeGray600,
          ),
          SizedBox(
            height: 8.h,
          ),
          CustomTextFormField(
            controller: emailoneController,
            hintText: "${_customer?.email}",
            hintStyle: CustomTextStyles.bodyLargeGray600,
            textInputType: TextInputType.emailAddress,
            contentPadding: EdgeInsets.all(20.h),
          )
        ],
      ),
    );
  }

  Widget _buildPhone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Phone Number".toUpperCase(),
            style: CustomTextStyles.bodyLargeGray600,
          ),
          SizedBox(
            height: 8.h,
          ),
          CustomTextFormField(
            controller: phoneNumberController,
            hintText: "${_customer?.phoneNumber}",
            hintStyle: CustomTextStyles.bodyLargeGray600,
            contentPadding: EdgeInsets.all(20.h),
          )
        ],
      ),
    );
  }

  Widget _buildColumnsave(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            text: "Save".toUpperCase(),
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.fillBlue,
            buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
          )
        ],
      ),
    );
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
      _customer = customer;
      _error = null;
    });
  }

  @override
  void onGetCustomerError(String error) {
    setState(() {
      _error = error;
      _customer = null;
    });
  }
}
