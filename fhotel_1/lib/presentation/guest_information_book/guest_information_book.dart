import 'package:fhotel_1/widgets/custom_text_form_field_for_guest.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
  class GuestInformationBookForOthersScreen extends StatefulWidget {
  const GuestInformationBookForOthersScreen({Key? key}) : super(key: key);

  @override
  GuestInformationBookForOthersScreenState createState() =>
  GuestInformationBookForOthersScreenState();
  }

  class GuestInformationBookForOthersScreenState extends State<GuestInformationBookForOthersScreen>{

  TextEditingController inputoneController = TextEditingController();
  TextEditingController inputthreeController = TextEditingController();
  TextEditingController inputfiveController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isSelectedSwitch = false;
  TextEditingController inputsevenController = TextEditingController();
  TextEditingController inputnineController = TextEditingController();
  TextEditingController inputelevenController = TextEditingController();



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
              padding: EdgeInsets.only(top: 8.h),
              child: Column(
                children: [
                  _buildSection(context),
                  SizedBox(height: 16.h),
                  _buildGuest(context)
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildSumsectionat(context),
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
        text: "Thông tin khách",
        margin: EdgeInsets.only(left: 7.h),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(
            top: 16.h,
            right: 16.h,
            bottom: 16.h,
          ),
          decoration: BoxDecoration(
            color: appTheme.black900.withOpacity(0.2),
            borderRadius: BorderRadius.circular(
              12.h,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppbarImage(
                imagePath: ImageConstant.imgIconLeft,
                margin: EdgeInsets.only(
                  left: 8.h,
                  top: 4.h,
                  bottom: 4.h,
                ),
              ),
              SizedBox(width: 8.h),
              AppbarIconbutton(
                imagePath: ImageConstant.imgDivider,
                margin: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 4.h,
                ),
              )
            ],
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildInputone(BuildContext context) {
    return CustomTextFormFieldForGuest(
      controller: inputoneController,
      hintText: "Vi du: NGUYEN",
      hintStyle: CustomTextStyles.bodyMediumGray600,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 8.h,
      ),
    );
  }

  Widget _buildInputthree(BuildContext context) {
    return CustomTextFormFieldForGuest(
      controller: inputthreeController,
      hintText: "Ví dụ: VAN ANH",
      hintStyle: CustomTextStyles.bodyMediumGray600,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 8.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildInputfive(BuildContext context) {
    return CustomTextFormFieldForGuest(
      controller: inputfiveController,
      hintText: "Ví dụ: 0900123456",
      hintStyle: CustomTextStyles.bodyMediumGray600,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 8.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormFieldForGuest(
      controller: emailController,
      hintText: "Ví du: nguyenvananh@gmail.com",
      hintStyle: CustomTextStyles.bodyMediumGray600,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 8.h,
      ),
    );
  }

  Widget _buildSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Thông tin liên hệ",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Họ",
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 2.h),
                _buildInputone(context),
                SizedBox(height: 18.h),
                Text(
                  "Tên đệm và tên",
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 2.h),
                _buildInputthree(context),
                SizedBox(height: 18.h),
                Text(
                  "Sõ điện thoại",
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 2.h),
                _buildInputfive(context),
                SizedBox(height: 16.h),
                Text(
                  "Email",
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 4.h),
                _buildEmail(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputseven(BuildContext context) {
    return CustomTextFormFieldForGuest(
      controller: inputsevenController,
      hintText: "Ví dụ: NGUYEN",
      hintStyle: CustomTextStyles.bodyMediumGray600,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 8.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildInputnine(BuildContext context) {
    return CustomTextFormFieldForGuest(
      controller: inputnineController,
      hintText: "Ví dụ: VAN ANH",
      hintStyle: CustomTextStyles.bodyMediumGray600,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 8.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildInputeleven(BuildContext context) {
    return CustomTextFormFieldForGuest(
      controller: inputelevenController,
      hintText: "Ví dụ: 0900123456",
      hintStyle: CustomTextStyles.bodyMediumGray600,
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 8.h,
      ),
    );
  }

  Widget _buildGuest(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Tôi đặt cho người khác",
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      CustomSwitch(
                        value: isSelectedSwitch,
                        onChange: (value) {
                          setState(() {
                            isSelectedSwitch = value;
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8.h),
          if(isSelectedSwitch == true)
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Thông tin khách lưu trú",
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Họ",
                        style: theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 2.h),
                      _buildInputseven(context),
                      SizedBox(height: 18.h),
                      Text(
                        "Tên đệm và tên",
                        style: theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 2.h),
                      _buildInputnine(context),
                      SizedBox(height: 18.h),
                      Text(
                        "Số điện thoại",
                        style: theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 2.h),
                      _buildInputeleven(context)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChnphng(BuildContext context) {
    return CustomElevatedButton(
      onPressed: (){
        Navigator.pushNamed(context, AppRoutes.guestCheckout);
      },
      text: "Đặt phòng",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
    );
  }

  /// Section Widget
  Widget _buildSumsectionat(BuildContext context) {
    return Container(
      height: 115.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Tổng giá tiền",
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "8.000.000 ₫",
                          style: CustomTextStyles.titleSmallBlue,
                        ),
                      ),
                      CustomImageView(
                        color: appTheme.black900.withOpacity(0.3),
                        imagePath: ImageConstant.imgIconWrapper17,
                        height: 24.h,
                        width: 24.h,
                        margin: EdgeInsets.only(left: 4.h),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(right: 14.h),
            child: Text(
              "Đã bao gồm thuế",
              style: TextStyle(
                color: appTheme.black900.withOpacity(0.5)
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_buildChnphng(context)],
            ),
          )
        ],
      ),
    );
  }

  }
