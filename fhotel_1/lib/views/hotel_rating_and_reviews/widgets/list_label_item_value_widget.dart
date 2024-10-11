import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class ListlabelvalueltemWidget extends StatelessWidget {
  const ListlabelvalueltemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(right: 32.h),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
              ),
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgCircle24x24,
                    height: 24.h,
                    width: 24.h,
                    margin: EdgeInsets.only(top: 8.h),
                  ),
                  SizedBox(width: 8.h),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tran V.A.",
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "9,0/10",
                              style: theme.textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.h),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      "16/01/2022",
                      style: CustomTextStyles.bodySmall10,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          border: Border(
            bottom: BorderSide(
              color: appTheme.blueGray50,
              width: 1.h,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Khách sạn mới và sạch sẽ, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. ",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                height: 1.50,
              ),
            ),
            SizedBox(height: 10.h)
          ],
        ),
      )
    ]);
  }
}
