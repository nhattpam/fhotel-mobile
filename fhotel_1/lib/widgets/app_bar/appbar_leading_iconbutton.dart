import 'package:flutter/material.dart';
import '../../core/app_export.dart';
class AppbarLeadingIconbutton extends StatelessWidget {
  AppbarLeadingIconbutton({Key? key, this.imagePath, this.margin, this.onTap})
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
            imagePath: ImageConstant.imgArrowLeftWhiteA700,
          ),
        ),
      ),
    );
  }
}