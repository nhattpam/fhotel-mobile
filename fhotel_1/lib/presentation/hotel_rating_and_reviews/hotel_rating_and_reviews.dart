import 'package:fhotel_1/presentation/hotel_rating_and_reviews/widgets/list_label_item_value_widget.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class HotelDetailsRatingsReviewsScreen extends StatelessWidget {
  const HotelDetailsRatingsReviewsScreen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildRating(context),
              Container(
                height: 8.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: appTheme.gray10001,
                ),
              ),
              _buildBasic(context),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildListlabelvalue(context)],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgChevronLeft,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.h,
          bottom: 16.h,
        ),
      ),
      title: AppbarTitle(
        text: "Đánh giá của khách",
        margin: EdgeInsets.only(left: 7.h),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(
            top: 16.h,
            right: 16.h,
            bottom: 16.h,
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
              AppbarIconbutton(
                imagePath: ImageConstant.imgDivider,
                margin: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 4.h,
                ),
              )
            ],
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  Widget _buildRating(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "8, 6",
                    style: theme.textTheme.headlineLarge,
                  ),
                  Text(
                    "ẫn tượng",
                    style: CustomTextStyles.titleSmallPrimary,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "từ 288 lượt đánh giá",
                    style: theme.textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.h),
            child: VerticalDivider(
              width: 1.h,
              thickness: 1.h,
              indent: 8.h,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14.h),
                        child: Text(
                          "Sạch sẽ",
                          style: CustomTextStyles.bodySmallBlack900,
                        ),
                      ),
                      CustomRatingBar(
                        initialRating: 0,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14.h),
                        child: Text(
                          "Thoải mái",
                          style: CustomTextStyles.bodySmallBlack900,
                        ),
                      ),
                      CustomRatingBar(
                        initialRating: 0,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14.h),
                        child: Text(
                          "Thức ăn",
                          style: CustomTextStyles.bodySmallBlack900,
                        ),
                      ),
                      CustomRatingBar(
                        initialRating: 0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14.h),
                        child: Text(
                          "Vị trí",
                          style: CustomTextStyles.bodySmallBlack900,
                        ),
                      ),
                      CustomRatingBar(
                        initialRating: 0,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBasic(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: SizedBox(
                width: 474.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 74.h,
                              child: Column(
                                children: [
                                  Text(
                                    "Tất cả",
                                    style: CustomTextStyles.titleSmallPrimary,
                                  ),
                                  SizedBox(height: 12.h),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Divider(
                                      color: theme.colorScheme.primary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 132.h,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Phòng sạch",
                                          style: CustomTextStyles
                                              .bodyMediumGray600,
                                        ),
                                        Container(
                                          width: 20.h,
                                          height: 16.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: appTheme.redA200,
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder8,
                                            border: Border.all(
                                              color: appTheme.whiteA700,
                                              width: 1.h,
                                            ),
                                          ),
                                          child: Text(
                                            "16".toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.labelMedium,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Divider(),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Nhân viên thân thiện",
                                            style: CustomTextStyles
                                                .bodyMediumGray600,
                                          ),
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgRedDot,
                                          height: 8.h,
                                          width: 8.h,
                                          radius: BorderRadius.circular(
                                            4.0.h,
                                          ),
                                          margin: EdgeInsets.only(top: 4.h),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Divider(),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(26.h, 12.h, 26.h, 10.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: appTheme.blueGray50,
                            width: 1.h,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Mô tả",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.bodyMediumGray600,
                          )
                        ],
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

  Widget _buildListlabelvalue(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 12.h,
            );
          },
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListlabelvalueltemWidget();
          },
        ),
      ),
    );
  }
}
