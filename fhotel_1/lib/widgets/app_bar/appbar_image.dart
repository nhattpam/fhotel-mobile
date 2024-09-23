import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';

class AppbarImage extends StatelessWidget {
AppbarImage({Key? key, this.imagePath, this.margin, this.onTap})
    : super(
key: key,
);
final String? imagePath;
final EdgeInsetsGeometry? margin;
final Function? onTap;
@override
Widget build(BuildContext context) {
  return InkWell(
    onTap: () {
      onTap?.call();
    },
    child: Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomImageView(
        color: Colors.white,
        imagePath: imagePath!,
        height: 16.h,
        width: 16.h,
        fit: BoxFit.contain,
      ),
    ),
  );
}
}