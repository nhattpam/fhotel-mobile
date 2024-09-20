import 'package:fhotel_1/presentation/hotel_detail_scroll/widgets/keyword_listing_item.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/app_export.dart';

class BHotelDetailsScrollScreen extends StatelessWidget {
  const BHotelDetailsScrollScreen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 772.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _buildCarousel(context),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: appTheme.gray10001,
                      borderRadius: BorderRadiusStyle.customBorderTL16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSection(context),
                        SizedBox(height: 8.h),
                        _buildSectionone(context),
                        SizedBox(height: 8.h),
                        _buildSectiontwo(context)
                      ],
                    ),
                  ),
                  _buildTop(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 180.h,
        margin: EdgeInsets.only(top: 8.h),
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
                SizedBox(
                  height: 80.h,
                  width: double.maxFinite,
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.h),
          Text(
            "Khách sạn Pullman Vũng Tàu",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.gray100,
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Khach san",
                        style: CustomTextStyles.bodySmallOnPrimary10,
                      ),
                      SizedBox(width: 4.h),
                      CustomRatingBar(
                        initialRating: 0,
                        itemSize: 14,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  width: double.maxFinite,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgIconWrapperGray600,
                        height: 24.h,
                        width: 24.h,
                      ),
                      SizedBox(width: 8.h),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 286.h,
                          child: Text(
                            "15 Thi Sach, Phường Thắng Tam, Vũng Tàu, Bà Rịa - Vũng Tàu, Việt Nam",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              height: 1.50,
                            ),
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
    );
  }

  Widget _buildColumntitletop(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 216.h),
            child: Column(
              children: [
                Text(
                  "Đánh giá hàng đầu",
                  style: theme.textTheme.titleSmall,
                )
              ],
            ),
          ),
          SizedBox(height: 6.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: SizedBox(
                width: 488.h,
                child: Row(
                  children: [
                    Expanded(
                      child: _buildListmasterTwo(
                        context,
                        descriptiontop:
                            "Khách sạn mới và đẹp, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. Xung...",
                        descriptionTwo: "Nguyen V.A.",
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: _buildListmasterTwo(
                          context,
                          descriptiontop:
                              "Khách sạn mới và đẹp, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. Xung...",
                          descriptionTwo: "Tran V.B.",
                        ),
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

  Widget _buildSectionone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Xếp hạng và đánh giá",
                        style: theme.textTheme.titleMedium,
                      ),
                      Spacer(),
                      Text(
                        "Xem tất cả",
                        style: CustomTextStyles.bodyMediumPrimary,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgArrowRight,
                        height: 20.h,
                        width: 20.h,
                        margin: EdgeInsets.only(left: 8.h),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 18.h),
          SizedBox(
              height: 238.h,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 14.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(right: 170.h),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "8,6",
                                        style: theme.textTheme.headlineLarge,
                                      ),
                                      SizedBox(width: 8.h),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: double.maxFinite,
                                              child: Row(
                                                children: [
                                                  CustomImageView(
                                                    imagePath: ImageConstant
                                                        .imgImage24x24,
                                                    height: 24.h,
                                                    width: 24.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.h),
                                                    child: Text(
                                                      "An tuong",
                                                      style: CustomTextStyles
                                                          .titleSmallPrimary,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "tu 288 luot danh gia",
                                              style: theme.textTheme.bodySmall,
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
                          SizedBox(height: 14.h),
                          SizedBox(
                            height: 28.h,
                            width: 344.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 8.h,
                                );
                              },
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return KeywordlistinglItemWidget();
                              },
                            ),
                          ),
                          SizedBox(height: 14.h),
                          _buildColumntitletop(context)
                        ],
                      ),
                    ),
                  ),
                  Container(
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
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
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.h),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                width: double.maxFinite,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Text(
                                          "Giá phòng mỗi đêm từ",
                                          style: theme.textTheme.titleSmall,
                                        ),
                                      ),
                                      Text(
                                        "2.000.000 ₫",
                                        style:
                                            CustomTextStyles.titleSmallPrimary,
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 4.h),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(
                                  left: 244.h,
                                  right: 14.h,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Da bao gom thue",
                                      style: theme.textTheme.bodySmall,
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
                                        children: [
                                          CustomElevatedButton(
                                            text: "Chon phong",
                                          ),
                                        ],
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
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildSectiontwo(BuildContext context) {
    return Container(
      height: 140.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 16.h),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 140.h,
            width: 100.h,
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.h,
                top: 16.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tiện nghi",
                          style: theme.textTheme.titleMedium,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text(
                            "Xem tất cả",
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.bodyMediumPrimary,
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgArrowRight,
                          height: 20.h,
                          width: 20.h,
                          margin: EdgeInsets.only(left: 8.h),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomOutlinedButton(
                            text: "Nhà hàng",
                          ),
                        ),
                        SizedBox(width: 8.h),
                        Expanded(
                          child: CustomOutlinedButton(
                            text: "Lễ tân 24h",
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTop(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(
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
              text: "Khách sạn Pullman Vũng Tàu",
              margin: EdgeInsets.only(left: 8.h),
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
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 8.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              border: Border(
                top: BorderSide(
                  color: appTheme.whiteA700.withOpacity(0.15),
                  width: 1.h,
                ),
              ),
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIconWrapperWhiteA70024x24,
                  height: 24.h,
                  width: 24.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      "02/02/2022",
                      style: CustomTextStyles.bodyMediumwhiteA700,
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgIconWrapper9,
                  height: 24.h,
                  width: 24.h,
                  margin: EdgeInsets.only(left: 20.h),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "2",
                    style: CustomTextStyles.bodyMediumwhiteA700,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgIconWrapper10,
                  height: 24.h,
                  width: 24.h,
                  margin: EdgeInsets.only(left: 20.h),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "2",
                    style: CustomTextStyles.bodyMediumwhiteA700,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgIconWrapper11,
                  height: 24.h,
                  width: 24.h,
                  margin: EdgeInsets.only(left: 20.h),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    "3",
                    style: CustomTextStyles.bodyMediumwhiteA700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child: CustomIconButton(
                    height: 24.h,
                    width: 24.h,
                    padding: EdgeInsets.all(4.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgArrowDownWhiteA700,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: theme.colorScheme.primary,
                          width: 1.h,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tổng quan",
                          style: CustomTextStyles.titleSmallPrimary,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: appTheme.blueGray50,
                          width: 1.h,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 2.h),
                        Text(
                          "Đánh giá",
                          style: CustomTextStyles.bodyMediumGray600,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: appTheme.blueGray50,
                          width: 1.h,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 2.h),
                        Text(
                          "Tiện nghi",
                          style: CustomTextStyles.bodyMediumGray600,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                      top: 12.h,
                      bottom: 10.h,
                    ),
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
                          style: CustomTextStyles.bodyMediumGray600,
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

  Widget _buildListmasterTwo(
    BuildContext context, {
    required String descriptiontop,
    required String descriptionTwo,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.gray10001,
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            descriptiontop,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onPrimary,
              height: 1.50,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            descriptionTwo,
            style: theme.textTheme.bodySmall!.copyWith(
              color: appTheme.gray600,
            ),
          )
        ],
      ),
    );
  }
}
