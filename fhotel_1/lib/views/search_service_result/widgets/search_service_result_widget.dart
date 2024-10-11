import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class FoodBurgersItemWidget extends StatelessWidget {
  const FoodBurgersItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 180.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 10.h,
            ),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: fs.Svg(
            //       ImageConstant.imgGroup907,
            //     ),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 38.h),
                Text(
                  "Burger Bistro",
                  style: CustomTextStyles.titleSmallBlue,
                ),
                Text(
                  "Rose garden",
                  style: CustomTextStyles.titleSmallGray600,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            "\$40",
                            style: CustomTextStyles.titleSmallGray600,
                          ),
                        ),
                      ),
                      CustomIconButton(
                        height: 30.h,
                        width: 30.h,
                        padding: EdgeInsets.all(8.h),
                        decoration: BoxDecoration(
                          color: Colors.blue, // Set background color to blue
                          shape: BoxShape
                              .circle, // Optional: If you want a circular button
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgIconWrapper6,
                          color: Colors.white, // Set the icon color to white
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage170x129,
            height: 84.h,
            width: 122.h,
            radius: BorderRadius.circular(
              14.h,
            ),
            alignment: Alignment.topCenter,
          )
        ],
      ),
    );
  }
}
