import 'package:fhotel_1/views/hotel_detail/widgets/carousel_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/app_export.dart';

class HotelDetailsScreen extends StatelessWidget {
  HotelDetailsScreen({Key? key})
      : super(
          key: key,
        );
  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 1092.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 1092.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _buildCarousel(context),
                        Align(
                          alignment: Alignment.topCenter,
                          child: _buildAppbar(context),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 80.h,
                      margin: EdgeInsets.only(top: 76.h),
                      child: AnimatedSmoothIndicator(
                        activeIndex: 0,
                        count: 5,
                        effect: ScrollingDotsEffect(
                          spacing: 4,
                          activeDotColor: theme.colorScheme.primary,
                          dotColor: appTheme.whiteA700,
                          dotHeight: 2.h,
                          dotWidth: 16.h,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildSumsectionat(context),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return CarouselItemWidget();
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      height: 32.h,
      leadingWidth: 48.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeftWhiteA700,
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {},
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(
            top: 4.h,
            right: 16.h,
            bottom: 4.h,
          ),
          decoration: BoxDecoration(
            color: appTheme.black900.withOpacity(0.2),
            borderRadius: BorderRadius.circular(
              12.h,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppbarImage(
                imagePath: ImageConstant.imgIconLeft,
                margin: EdgeInsets.only(
                  left: 8.h,
                  top: 4.h,
                  bottom: 4.h,
                ),
              ),
              SizedBox(width: 8.h),
              AppbarImage(
                imagePath: ImageConstant.imgDivider,
                margin: EdgeInsets.only(
                  left: 8.h,
                  top: 4.h,
                  bottom: 4.h,
                ),
              ),
              SizedBox(width: 8.h),
              AppbarImage(
                imagePath: ImageConstant.imgIconRight,
                margin: EdgeInsets.fromLTRB(7.h, 4.h, 8.h, 4.h),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildChnphng(BuildContext context) {
    return CustomElevatedButton(
      text: "Chọn phòng",
    );
  }

  Widget _buildSumsectionat(BuildContext context) {
    return Container(
      height: 110.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Giá phòng mỗi đêm từ",
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        "2.000.000 đ",
                        style: theme.textTheme.titleSmall,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(right: 14.h),
            child: Text(
              "Đã bao gồm thuế",
              style: theme.textTheme.bodySmall,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_buildChnphng(context)],
            ),
          )
        ],
      ),
    );
  }

  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
