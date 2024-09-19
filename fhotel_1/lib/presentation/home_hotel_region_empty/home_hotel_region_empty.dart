import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:fhotel_1/core/utils/size_utils.dart';
import 'package:fhotel_1/presentation/home_hotel_region_empty/widgets/carouselunit_item_widget.dart';
import 'package:fhotel_1/presentation/home_hotel_region_empty/widgets/maincontent_item_widget.dart';
import 'package:fhotel_1/presentation/home_hotel_region_empty/widgets/maincontent_one_item_widget.dart';
import 'package:fhotel_1/theme/app_decoration.dart';
import 'package:fhotel_1/theme/custom_text_style.dart';
import 'package:fhotel_1/widgets/app_bar/appbar_tittle.dart';
import 'package:fhotel_1/widgets/app_bar/appbar_trailing_iconbutton.dart';
import 'package:fhotel_1/widgets/app_bar/custom_app_bar.dart';
import 'package:fhotel_1/widgets/custom_elevated_button.dart';
import 'package:fhotel_1/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';

class HomeHotelRegionEmptyScreen extends StatefulWidget {
  HomeHotelRegionEmptyScreen({Key? key}) : super(key: key);

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

TextEditingController searchController = TextEditingController();

class CategoryScreenState extends State<HomeHotelRegionEmptyScreen> {
  int sliderIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 1032.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _buildStackherobanner(context),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildColumniconwrapp(context),
                      SizedBox(height: 16.h),
                      _buildSection(context),
                      SizedBox(height: 12.h),
                      _buildSectionone(context),
                      Container(
                        height: 8.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: appTheme.gray10001,
                        ),
                      ),
                      _buildColumntitleone(context)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStackherobanner(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 96.h,
        child: Flexible(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgHerobanner,
                height: 96.h,
                width: double.maxFinite,
              ),
              // CustomAppBar(
              //   height: 32.h,
              //   title: AppbarTitle(
              //     text: "Logo",
              //     margin: EdgeInsets.only(left: 16.h),
              //   ),
              //   actions: [
              //     AppbarTrailingIconbutton(
              //         imagePath: ImageConstant.imgIconWrapper,
              //       ),
              //     Flexible(
              //       child: Container(
              //         margin: EdgeInsets.fromLTRB(8.h, 4.h, 16.h, 4.h),
              //         decoration: BoxDecoration(
              //           color: appTheme.black900.withOpacity(0.2),
              //           borderRadius: BorderRadius.circular(
              //             12.h,
              //           ),
              //         ),
              //         width: double.maxFinite,
              //         child: Row(
              //           children: [
              //             AppbarImage(
              //               imagePath: ImageConstant.imgIconLeft,
              //               margin:
              //                   EdgeInsets.only(left: 8.h, top: 4.h, bottom: 4.h),
              //             ),
              //             SizedBox(width: 8.h),
              //             AppbarImage(
              //               imagePath: ImageConstant.imgDivider,
              //               margin: EdgeInsets.only(
              //                 left: 8.h,
              //                 top: 4.h,
              //                 bottom: 4.h,
              //               ),
              //             ),
              //             SizedBox(width: 8.h),
              //             AppbarImage(
              //               imagePath: ImageConstant.imgIconRight,
              //               margin: EdgeInsets.fromLTRB(7.h, 4.h, 8.h, 4.h),
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumniconwrapp(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(children: [
        Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(16.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: appTheme.blueGray50,
                              width: 1.h,
                            ),
                          ),
                        ),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgIconWrapperGray600,
                              height: 24.h,
                              width: 24.h,
                            ),
                            SizedBox(width: 6.h),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Điểm đến, khách sạn",
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    SizedBox(height: 6.h),
                                    CustomSearchView(
                                      controller: searchController,
                                      hintText: "Nhập điểm đến, khách sạn",
                                      hintStyle: CustomTextStyles.titleSmallGray600, context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 6.h),
                            // Padding(
                            //   padding: EdgeInsets.only(top: 10.h),
                            //   child: CustomIconButton(
                            //     height: 24.h,
                            //     width: 24.h,
                            //     padding: EdgeInsets.all(4.h),
                            //     decoration: IconButtonStyleHelper.fillBlackTL12,
                            //     child: CustomImageView(
                            //       imagePath:
                            //           ImageConstant.imgIconWrapperBlueGray700,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant
                                        .imgIconWrapperGray60024x24,
                                    height: 24.h,
                                    width: 24.h,
                                    margin: EdgeInsets.only(top: 8.h),
                                  ),
                                  SizedBox(width: 8.h),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ngày nhận phòng",
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              "Thứ Tư,02/02/2022",
                                              style: theme.textTheme.titleSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h),
                                Text(
                                  "Sõ đêm nghi",
                                  style: theme.textTheme.bodyMedium,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "1 đêm",
                                  style: theme.textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                          left: 32.h,
                          right: 38.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ngày trả phòng:",
                              style: theme.textTheme.bodySmall,
                            ),
                            SizedBox(width: 4.h),
                            Expanded(
                              child: Text(
                                "Thứ Năm, 03/02/2022",
                                style: theme.textTheme.labelLarge,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(width: double.maxFinite, child: Divider()),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: _buildListmasterOne(
                          context,
                          iconwrapper: ImageConstant.imgIconWrapper24x24,
                          labelfilterone: "Số phòng và khách",
                          placeholderOne: "1 phòng, 1 người lớn",
                        ),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(width: double.maxFinite, child: Divider()),
                      SizedBox(
                        width: double.maxFinite,
                        child: _buildListmasterOne(
                          context,
                          iconwrapper: ImageConstant.imgIconWrapper1,
                          labelfilterone: "Bộ lọc",
                          placeholderOne: "Chọn bộ lọc",
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomElevatedButton(
                        onPressed: (){
                          print('a');
                        },
                        text: "Tìm kiếm",
                      )
                    ],
                  ),
                )
              ],
            )),
      ]),
    );
  }

  Widget _buildSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 16.h),
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tra cứu gần đây",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        "Xóa",
                        style: CustomTextStyles.bodyMediumPrimary.copyWith(
                          color: Colors.blue
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            height: 80.h,
            width: 344.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: 2,
              itemBuilder: (context, index) {
                return MaincontentItemWidget();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  right: 292.h,
                ),
                child: Column(
                  children: [
                    Text(
                      "Ưu đãi",
                      style: theme.textTheme.titleMedium,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: double.maxFinite,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 108.h,
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  sliderIndex = index;
                },
              ),
              itemCount: 1,
              itemBuilder: (context, index, realIndex) {
                return CarouselunitItemWidget();
              },
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                  child: AnimatedSmoothIndicator(
                    activeIndex: 0,
                    count: 5,
                    effect: ScrollingDotsEffect(
                      spacing: 4,
                      activeDotColor: theme.colorScheme.primary,
                      dotColor: appTheme.black900.withOpacity(0.1),
                      dotHeight: 2.h,
                      dotWidth: 16.h,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumntitleone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 14.h,
              right: 198.h,
            ),
            child: Column(
              children: [
                Text(
                  "Điểm đến phố biến",
                  style: theme.textTheme.titleMedium,
                )
              ],
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 170.h,
            width: 344.h,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 14.h),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return MaincontentOneltemWidget();
              },
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildListmasterOne(
    BuildContext context, {
    required String iconwrapper,
    required String labelfilterone,
    required String placeholderOne,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: iconwrapper,
            height: 24.h,
            width: 24.h,
          ),
          SizedBox(width: 8.h),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      labelfilterone,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      placeholderOne,
                      style: CustomTextStyles.titleSmallGray600.copyWith(
                        color: appTheme.gray600,
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
