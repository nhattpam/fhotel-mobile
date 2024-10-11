import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';

class AppbarTrailingIconbutton extends StatelessWidget {
  AppbarTrailingIconbutton({Key? key, this.imagePath, this.margin, this.onTap})
      : super(
          key: key,
        );
  final String? imagePath;
  final EdgeInsetsGeometry? margin;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 16.h,
          width: 24.h,
          padding: EdgeInsets.all(4.h),
          decoration: IconButtonStyleHelper.fillBlack,
          child: CustomImageView(
            imagePath: ImageConstant.imgIconWrapper,
          ),
        ),
      ),
    );
  }
}
