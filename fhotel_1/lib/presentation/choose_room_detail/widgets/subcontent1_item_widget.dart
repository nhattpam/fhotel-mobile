import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class SubcontentiItemWidget extends StatelessWidget {
  const SubcontentiItemWidget({Key? key})
      : super(
    key: key,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage180x360,
            height: 180.h,
            width: double.maxFinite,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 80.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.5, 0),
                    end: Alignment(0.5, 1),
                    colors: [
                      appTheme.black900.withOpacity(0.1),
                      appTheme.black900.withOpacity(0.1)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                height: 80.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.5, 0),
                    end: Alignment(0.5, 1),
                    colors: [
                      appTheme.black900.withOpacity(0.4),
                      appTheme.black900.withOpacity(0.4)
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}