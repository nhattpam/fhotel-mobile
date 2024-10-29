import 'package:fhotel_1/presentation/hotel_detail/widgets/carousel_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
class ListOneItemWidget extends StatelessWidget {
  const ListOneItemWidget({Key? key})
      : super (
    key: key,
  );
  void _showDetailModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CarouselItemWidget();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // _showDetailModalBottomSheet(context);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  CarouselItemWidget()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          borderRadius: BorderRadiusStyle.circleBorder16,
        ),
        child: Row(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Container(
                height: 120.h,
                width: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage120x120,
                      height: 120.h,
                      width: double.maxFinite,
                      radius: BorderRadius.circular(
                        8.h,
                      ),
                    ),
                    IntrinsicHeight(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100.h,
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          // decoration: BoxDecoration(
                          //   gradient: LinearGradient(
                          //     begin: Alignment(0.5, 0),
                          //     end: Alignment(0.5, 1),
                          //     colors: [
                          //       appTheme.black900.withOpacity(0.6),
                          //       appTheme.black900.withOpacity(0.6)
                          //     ],
                          //   ),
                          // ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomImageView(
                                color: appTheme.whiteA700,
                                imagePath: ImageConstant.imgIconWrapper13,
                                height: 24.h,
                                width: 24.h,
                                margin: EdgeInsets.only(top: 28.h),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 2.h),
                                child: Text("380m",
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tên khách sạn được hiến thị tối đa 2 dòng",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      height: 1.50,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  CustomRatingBar(
                    color: Colors.yellow,
                    ignoreGestures: true,
                    initialRating: 5,
                  ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgIconWrapper12,
                          color: Colors.blueAccent,
                          height: 15.h,
                          width: 15.h,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.h),
                            child: Text(
                              "8,6",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Text(
                          "2.000.000 ₫",
                          style: CustomTextStyles.titleSmallBlue,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              "/ phòng / đêm",
                              style: CustomTextStyles.bodySmallOnPrimary10,
                            ),
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
    );
  }
}