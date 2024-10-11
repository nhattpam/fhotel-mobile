import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class HomeRoomGuestFilledBottomsheet extends StatelessWidget {
  HomeRoomGuestFilledBottomsheet({Key? key})
      : super(
          key: key,
        );
  TextEditingController inputOneController = TextEditingController();
  TextEditingController inputThreeController = TextEditingController();
  TextEditingController inputFiveController = TextEditingController();
  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            borderRadius: BorderRadiusStyle.customBorderTL8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSheetheader(context),
              SizedBox(height: 10.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(
                  left: 16.h,
                  right: 92.h,
                ),
                child: Column(
                  children: [
                    Text(
                      "Tối đa 8 phòng, 32 người lớn, 6 trẻ em",
                      style: theme.textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildColumniconwrapp(context),

                    /// In case have to design for kid
                    // SizedBox(height: 16.h),
                    // Text(
                    //   "Vui lòng chọn tuổi của trẻ vào thời điểm nhận phòng",
                    //   style: CustomTextStyles.bodyLargeOnPrimary_1,
                    // ),
                    // SizedBox(height: 12.h),
                    // Text(
                    //   "Trẻ em 1",
                    //   style: theme.textTheme.titleSmall,
                    // ),
                    // SizedBox(height: 4.h),
                    // _buildStatusiconone(context),
                    // SizedBox(height: 4.h),
                    // Text(
                    //   "Vui lòng điền thông tin",
                    //   style: CustomTextStyles.bodySmallRedA200,
                    // )
                  ],
                ),
              ),
              _buildButtonbar(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetheader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Chọn số phòng và khách",
              style: theme.textTheme.titleMedium,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 44.h),
          )
        ],
      ),
    );
  }

  Widget _buildInputone(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        borderDecoration: OutlineInputBorder(
            borderSide: BorderSide(
                color: appTheme.black900.withOpacity(0.15), width: 2)),
        readOnly: true,
        controller: inputOneController,
        hintText: "1",
        hintStyle: const TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 8.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildInputthree(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        borderDecoration: OutlineInputBorder(
            borderSide: BorderSide(
                color: appTheme.black900.withOpacity(0.15), width: 2)),
        readOnly: true,
        controller: inputThreeController,
        hintText: "1",
        hintStyle: const TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 8.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildInputfive(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        borderDecoration: OutlineInputBorder(
            borderSide: BorderSide(
                color: appTheme.black900.withOpacity(0.15), width: 2)),
        alignment: Alignment.center,
        readOnly: true,
        controller: inputFiveController,
        hintText: "1",
        hintStyle: const TextStyle(color: Colors.black),
        textInputAction: TextInputAction.done,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 8.h,
        ),
      ),
    );
  }

  Widget _buildColumniconwrapp(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                    ),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgIconWrapper5,
                          height: 24.h,
                          width: 24.h,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.h),
                            child: Text(
                              "Phòng",
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 148.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.h,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                color: Colors.blue,
                                imagePath: ImageConstant.imgContentMinus,
                                height: 24.h,
                                width: 24.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 4.h),
                      _buildInputone(context),
                      SizedBox(width: 4.h),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.h,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                color: Colors.blue,
                                imagePath: ImageConstant.imgIconWrapper6,
                                height: 24.h,
                                width: 24.h,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(),
          ),
          SizedBox(height: 6.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: _buildWrapperThree(
                    context,
                    iconwrapper: ImageConstant.imgIconWrapper7,
                    labelchildone: "Người lớn",
                    descriptionone: "Từ 18 tuổi",
                  ),
                ),
                SizedBox(
                  width: 148.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.h,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                color: Colors.blue,
                                imagePath: ImageConstant.imgContentMinus,
                                height: 24.h,
                                width: 24.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 4.h),
                      _buildInputthree(context),
                      SizedBox(width: 4.h),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.h,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                color: Colors.blue,
                                imagePath: ImageConstant.imgIconWrapper6,
                                height: 24.h,
                                width: 24.h,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(),
          ),
          SizedBox(height: 6.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: _buildWrapperThree(
                    context,
                    iconwrapper: ImageConstant.imgIconWrapper8,
                    labelchildone: "Trẻ em",
                    descriptionone: "Từ 0 đến 17 tuổi",
                  ),
                ),
                SizedBox(
                  width: 148.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.h,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                color: Colors.blue,
                                imagePath: ImageConstant.imgContentMinus,
                                height: 24.h,
                                width: 24.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 4.h),
                      _buildInputfive(context),
                      SizedBox(width: 4.h),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.h,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                color: Colors.blue,
                                imagePath: ImageConstant.imgIconWrapper6,
                                height: 24.h,
                                width: 24.h,
                              )
                            ],
                          ),
                        ),
                      )
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

  Widget _buildStatusiconone(BuildContext context) {
    return CustomDropDown(
      width: 160.h,
      icon: Container(
        margin: EdgeInsets.only(left: 16.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgStatusIcon,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      iconSize: 24.h,
      hintText: "Chọn tuổi",
      items: dropdownItemList,
      contentPadding: EdgeInsets.fromLTRB(16.h, 8.h, 10.h, 8.h),
    );
  }

  /// Section Widget
  Widget _buildHontt(BuildContext context) {
    return CustomElevatedButton(
      text: "Hoàn tất",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
    );
  }

  Widget _buildButtonbar(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 8.h),
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
        mainAxisSize: MainAxisSize.min,
        children: [_buildHontt(context)],
      ),
    );
  }

  Widget _buildWrapperThree(
    BuildContext context, {
    required String iconwrapper,
    required String labelchildone,
    required String descriptionone,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: iconwrapper,
            height: 24.h,
            width: 24.h,
          ),
          SizedBox(width: 8.h),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelchildone,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    descriptionone,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: appTheme.gray600,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
