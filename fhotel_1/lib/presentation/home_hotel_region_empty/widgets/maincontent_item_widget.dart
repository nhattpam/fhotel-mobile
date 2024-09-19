import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';

class MaincontentItemWidget extends StatelessWidget {
  const MaincontentItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.h,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgIconWrapperPrimary,
            height: 24.h,
            width: 24.h,
          ),
          SizedBox(width: 8.h),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Khách sạn Pullman Vũng Tàu",
                      style: CustomTextStyles.titleSmallPrimary.copyWith(
                        color: Colors.blue
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "02/02/2022 - 04/02/2022",
                      style: theme.textTheme.bodySmall,
                    ),
                    SizedBox(height: 4.h),
                    Flexible(
                      child: Text(
                        "2 phòng, 2 người lớn, 1 trẻ em",
                        style: theme.textTheme.bodySmall,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
