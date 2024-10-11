import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
// ignore_for_file: must_be_immutable
class ListphNgOneItemWidget extends StatelessWidget {
  ListphNgOneItemWidget({Key? key})
      : super(
    key: key,
  );
  TextEditingController inputOneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
              ),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgIconWrapper5,
                    height: 24.h,
                    width: 24.h,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Text(
                        "Phòng",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 148.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder4,
                      border: Border.all(
                        color: appTheme.black900.withOpacity(0.05),
                        width: 1.h,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          color: appTheme.black900.withOpacity(0.15),
                          imagePath: ImageConstant.imgIconWrapperBlack900,
                          height: 24.h,
                          width: 24.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4.h),
                _buildInputone(context),
                SizedBox(width: 4.h),
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.roundedBorder4,
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.h,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          color: Colors.blue,
                          imagePath: ImageConstant.imgIconWrapper6,
                          height: 24.h,
                          width: 24.h,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _buildInputone(BuildContext context) {
    return Expanded (
        child: CustomTextFormField(
        readOnly: true,
        controller: inputOneController,
        hintText: "1",
        contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 8.h,
    ),
    ),
    );
  }
}
