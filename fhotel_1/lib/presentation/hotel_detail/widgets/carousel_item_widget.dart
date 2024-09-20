import 'package:fhotel_1/presentation/hotel_detail/widgets/keyword_listing_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class CarouselItemWidget extends StatelessWidget {
  CarouselItemWidget({Key? key})
      : super(
          key: key,
        );
  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1092.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage156x360,
            height: 156.h,
            width: double.maxFinite,
            alignment: Alignment.topCenter,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgTopGradient,
            height: 56.h,
            width: double.maxFinite,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 80.h,
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 76.h),
            ),
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: appTheme.gray10001,
              borderRadius: BorderRadiusStyle.customBorderTL16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
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
                              width: 150.h,
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
                                children: [
                                  Text(
                                    "Khách sạn",
                                    style:
                                        CustomTextStyles.bodySmallOnPrimary10,
                                  ),
                                  SizedBox(width: 4.h),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgStar,
                                          height: 14.h,
                                          width: 16.h,
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgStar,
                                          height: 14.h,
                                          width: 16.h,
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgStar,
                                          height: 14.h,
                                          width: 16.h,
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgStar,
                                          height: 14.h,
                                          width: 16.h,
                                        ),
                                        CustomImageView(
                                          imagePath: ImageConstant.imgStar,
                                          height: 14.h,
                                          width: 16.h,
                                        )
                                      ],
                                    ),
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
                                    imagePath:
                                        ImageConstant.imgIconWrapperGray600,
                                    height: 24.h,
                                    width: 24.h,
                                  ),
                                  SizedBox(width: 8.h),
                                  Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: 286.h,
                                      child: Text(
                                        "15 Thi Sach, Phường Thẳng Tam, Vũng Tàu, Bà Rịa - Vũng Tàu, Việt Nam",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
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
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
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
                                        style:
                                            CustomTextStyles.bodyMediumPrimary,
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
                                SizedBox(height: 18.h),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      "Ấn tượng",
                                                      style: CustomTextStyles
                                                          .titleSmallPrimary,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "từ 288 lượt đánh giá",
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
                        ),
                      ),
                      SizedBox(height: 14.h),
                      SizedBox(
                        height: 28.h,
                        width: 472.h,
                        child: ListView.separated(
                          padding: EdgeInsets.only(left: 16.h),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 8.h,
                            );
                          },
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return KeywordlistingItemWidget();
                          },
                        ),
                      ),
                      SizedBox(height: 14.h),
                      _buildColumndescripti(context)
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tiện nghi",
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
                      ),
                      SizedBox(height: 14.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  _buildChip(context),
                                  SizedBox(width: 8.h),
                                  _buildChipone(context)
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  _buildChiptwo(context),
                                  SizedBox(width: 8.h),
                                  _buildChipthree(context),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Giờ nhận phòng / trả phòng",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: appTheme.whiteA700,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgIconWrapper14,
                                    height: 24.h,
                                    width: 24.h,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.h),
                                      child: Text(
                                        "Nhận phòng",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "15:00 - 03:00",
                                    style: theme.textTheme.titleSmall,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgIconWrapper14,
                                    height: 24.h,
                                    width: 24.h,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.h),
                                      child: Text(
                                        "Trả phòng",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "trước 11:00",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mô tả khách sạn",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: appTheme.whiteA700,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 324.h,
                              child: Text(
                                "Nảm dọc theo bãi biển Mỹ Khê cát trắng trải dài thơ mộng, khu nghỉ dưỡng dành cho gia đình sang trọng bật nhất thế giới Premier Village Danang được ưu ái tọa lạc ở vị trí dac biet",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  height: 1.50,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            CustomDropDown(
                              width: 94.h,
                              icon: Container(
                                margin: EdgeInsets.only(left: 8.h),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgArrowdownPrimary,
                                  height: 20.h,
                                  width: 20.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              iconSize: 20.h,
                              hintText: "Xem thêm",
                              hintStyle: CustomTextStyles.bodyMediumPrimary,
                              items: dropdownItemList,
                              contentPadding: EdgeInsets.all(12.h),
                              onChanged: (value) {},
                            ),
                            SizedBox(height: 6.h)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8.h)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColumndescripti(BuildContext context) {
    return Container(
      width: 488.h,
      margin: EdgeInsets.only(left: 14.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(right: double.maxFinite),
          child: Column(
            children: [
              Text(
                "Đánh giá hàng đầu",
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.gray10001,
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Khách sạn mới và đẹp, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. Xung...",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          height: 1.50,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Nguyen V.A.",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.h),
              Expanded(
                child: Container(
                  width: double.maxFinite,
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
                        "Khách sạn mới và đẹp, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. Xung ",
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          height: 1.50,
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Tran V.B.",
                        style: theme.textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildChip(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Nhà hàng",
      ),
    );
  }

  /// Section Widget
  Widget _buildChipone(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Lễ tân 24h",
      ),
    );
  }

  /// Section Widget
  Widget _buildChiptwo(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Hồ bơi",
      ),
    );
  }

  /// Section Widget
  Widget _buildChipthree(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Wifi",
      ),
    );
  }
}
