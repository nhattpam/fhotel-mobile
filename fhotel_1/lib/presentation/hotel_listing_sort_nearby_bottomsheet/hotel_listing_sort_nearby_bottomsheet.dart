import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';

class HotellistingSortNearbyBottomsheet extends StatelessWidget {
  HotellistingSortNearbyBottomsheet({Key? key})
      : super(
          key: key,
        );

  TextEditingController listmasteroneController = TextEditingController();
  TextEditingController listmasterController = TextEditingController();
  TextEditingController listmasterfiveController = TextEditingController();
  TextEditingController listmaster1Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildScrollview(context);
  }

  /// Section Widget
  Widget _buildListmasterone(BuildContext context) {
    return CustomTextFormField(
      controller: listmasteroneController,
      hintText: "Phổ biến nhãt",
      hintStyle: theme.textTheme.bodyMedium!,
      contentPadding: EdgeInsets.fromLTRB(16.h, 12.h, 16.h, 10.h),
      // borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
      filled: false,
    );
  }

  Widget _buildListmaster(BuildContext context) {
    return CustomTextFormField(
      controller: listmasterController,
      hintText: "Giá thấp nhất",
      hintStyle: theme.textTheme.bodyMedium!,
      contentPadding: EdgeInsets.fromLTRB(16.h, 12.h, 16.h, 10.h),
      // borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
      filled: false,
    );
  }

  /// Section Widget
  Widget _buildListmasterfive(BuildContext context) {
    return CustomTextFormField(
      controller: listmasterfiveController,
      hintText: "Giá cao nhãt",
      hintStyle: theme.textTheme.bodyMedium!,
      contentPadding: EdgeInsets.fromLTRB(16.h, 12.h, 16.h, 10.h),
      // borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
      filled: false,
    );
  }

  Widget _buildListmaster1(BuildContext context) {
    return CustomTextFormField(
      controller: listmaster1Controller,
      hintText: "Xếp hạng cao nhất",
      hintStyle: theme.textTheme.bodyMedium!,
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.fromLTRB(16.h, 12.h, 16.h, 10.h),
      // borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
      filled: false,
    );
  }

  Widget _buildScrollview(BuildContext context) {
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
            children: [
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapper(
                  context,
                  labelsortfive: "Sắp xếp",
                  iconwrapperOne: ImageConstant.imgCloseIcon,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(
                        children: [
                          _buildListmasterone(context),
                          SizedBox(height: 8.h),
                          _buildListmaster(context),
                          SizedBox(height: 8.h),
                          _buildListmasterfive(context),
                          SizedBox(height: 8.h),
                          _buildListmaster1(context)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: _buildWrapper(
                        context,
                        labelsortfive: "Gần nhất",
                        iconwrapperOne:
                            ImageConstant.imgIconWrapperGreenA70024x24,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWrapper(
    BuildContext context, {
    required String labelsortfive,
    required String iconwrapperOne,
  }) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            labelsortfive,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        CustomImageView(
          imagePath: iconwrapperOne,
          height: 24.h,
          width: 24.h,
        ),
      ]),
    );
  }
}
