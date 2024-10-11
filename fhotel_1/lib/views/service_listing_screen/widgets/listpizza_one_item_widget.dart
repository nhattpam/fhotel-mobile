import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class ListpizzaOneItemWidget extends StatelessWidget {
  const ListpizzaOneItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 122.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 122.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 122.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.blueGray20001,
                      spreadRadius: 2.h,
                      blurRadius: 2.h,
                      offset: Offset(
                        1,
                        12,
                      ),
                    )
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage170x129,
                      height: 80.h,
                      width: 96.h,
                      radius: BorderRadius.circular(
                        14.h,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.only(left: 30.h),
                child: Text(
                  "Pizza",
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleSmallGray600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
