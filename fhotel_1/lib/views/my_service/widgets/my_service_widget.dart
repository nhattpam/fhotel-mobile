import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class MyServiceWidget extends StatelessWidget {
  const MyServiceWidget({Key? key})
      : super(
    key: key,
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Text(
                  "Food",
                  style: CustomTextStyles.titleSmallBlue,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.h),
                  child: Text(
                    "Completed",
                    style: CustomTextStyles.titleMediumGreenA700,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Container(
                  height: 60.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                    color: appTheme.blueGray20001,
                    borderRadius: BorderRadius.circular(
                      8.h,
                    ),
                  ),
                  child: CustomImageView(
                    fit: BoxFit.cover,
                    imagePath: ImageConstant.imgImage170x129,
                    height: 24.h,
                    width: 24.h,
                  ),
                ),
                SizedBox(width: 14.h),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pizza Hut",
                              style: CustomTextStyles.titleSmallGray600,
                            ),
                            Text(
                              "#162432",
                              style:
                              CustomTextStyles.bodyLargeGray600.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Text(
                              "\$35.25",
                              style: CustomTextStyles.titleSmallGray600,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 14.h),
                              child: VerticalDivider(
                                width: 1.h,
                                thickness: 1.h,
                                color: appTheme.blueGray100,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.h),
                              child: Text(
                                "29 Jan, 12:30".toUpperCase(),
                                style: CustomTextStyles.bodyLargeGray600,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 4.h,
                                width: 4.h,
                                margin: EdgeInsets.only(
                                  left: 8.h,
                                  top: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: appTheme.gray10002,
                                  borderRadius: BorderRadius.circular(
                                    2.h,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: Text(
                                "03 Items",
                                style: CustomTextStyles.bodyMediumGray600,
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
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlinedButton(
                  height: 38.h,
                  width: 138.h,
                  text: "Rate",
                  buttonStyle: CustomButtonStyles.outlineBlue,
                  buttonTextStyle: CustomTextStyles.bodyLargeBlue,

                ),
                CustomElevatedButton(
                  height: 38.h,
                  width: 138.h,
                  text: "Re-Order",
                  buttonStyle: CustomButtonStyles.fillBlue,
                  buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
