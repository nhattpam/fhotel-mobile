import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';

class CarouselunitItemWidget extends StatelessWidget {
  const CarouselunitItemWidget ({Key? key})
      : super(
    key: key,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgImage,
          height: 108.h,
          width: 8.h,
          radius: BorderRadius.circular(
            4.h,
          ),
        ),
        SizedBox(width: 8.h),
        Expanded(
          child: CustomImageView(
            imagePath: ImageConstant.imgImage108x328,
            height: 108.h,
            radius: BorderRadius.circular(
              8.h,
            ),
          ),
        ),
        SizedBox(width: 8.h),
        CustomImageView(
          imagePath: ImageConstant.imgImage,
          height: 108.h,
          width: 8.h,
          radius: BorderRadius.circular(
            4.h,
          ),
        )
      ],
    );
  }
}