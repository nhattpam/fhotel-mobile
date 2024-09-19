import 'package:flutter/material.dart';
import 'package:fhotel_1/core/app_export.dart';

class MaincontentOneltemWidget extends StatelessWidget {
  const MaincontentOneltemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.h,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Container(
          height: 170.h,
          width: 128.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgImage170x128,
                height: 170.h,
                width: double.maxFinite,
                radius: BorderRadius.circular(
                  8.h,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 6.h,
                    bottom: 6.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.5, 0),
                      end: Alignment(0.5, 1),
                      colors: [
                        theme.colorScheme.primary.withOpacity(0),
                        theme.colorScheme.primary
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 26.h),
                      Text(
                        "Tên điểm đến",
                        style: CustomTextStyles.titleSmallwhiteA700,
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "1000+ khách sạn",
                        style: CustomTextStyles.bodySmallWhiteA700,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
