import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class CheckoutOneItemWidget extends StatelessWidget {
  const CheckoutOneItemWidget({Key? key})
      : super(
    key: key,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgIconWrapper19,
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
                    "Số đêm",
                    style: theme.textTheme.bodyMedium,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "2 đêm",
                    style: theme.textTheme.titleSmall,
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