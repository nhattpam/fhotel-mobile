import 'package:flutter/material.dart';

import '../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class HotelDetailsFacilitiesScreen extends StatelessWidget {
  HotelDetailsFacilitiesScreen({Key? key})
      : super(
          key: key,
        );
  TextEditingController listmasteroneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: _buildSectionOne(
                    context,
                    titleone: "Tiện nghi chung",
                    descriptionOne:
                        "Bãi gửi xe\nKhu vực hút thuốc \nTiệc chiêu đãi \nSân thượng/ sân hiên",
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: _buildSectionOne(
                    context,
                    titleone: "Tiện nghi văn phòng",
                    descriptionOne:
                        "Phòng hội nghị \nPhòng họp \nDịch vụ văn phòng \nPhòng hội nghị \nMáy tính",
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: _buildSectionOne(
                    context,
                    titleone: "Tiện nghi công cộng",
                    descriptionOne:
                        "Tiệm cà phê\nThang máy \nNhà hàng \nKét an toàn",
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: _buildSectionOne(
                    context,
                    titleone: "Ấm thực",
                    descriptionOne: "Quầy bar\nQuãy bar bên hồ bơi \nBữa sáng",
                  ),
                ),
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
        imagePath: ImageConstant.imgChevronLeft,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.h,
          bottom: 16.h,
        ),
      ),
      title: AppbarTitle(
        text: "Tiện ích",
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

  Widget _buildSectionOne(
    BuildContext context, {
    required String titleone,
    required String descriptionOne,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          Text(
            titleone,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 6.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              border: Border(
                bottom: BorderSide(
                  color: appTheme.blueGray50,
                  width: 1.h,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  descriptionOne,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                    height: 1.50,
                  ),
                ),
                SizedBox(height: 4.h)
              ],
            ),
          )
        ],
      ),
    );
  }
}
