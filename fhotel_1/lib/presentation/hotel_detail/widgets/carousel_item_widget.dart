import 'package:fhotel_1/presentation/choose_room/choose_room.dart';
import 'package:fhotel_1/presentation/hotel_detail_facilities_screen/hotel_detail_facilities_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../hotel_rating_and_reviews/hotel_rating_and_reviews.dart';

// ignore_for_file: must_be_immutable
class CarouselItemWidget extends StatelessWidget {
  CarouselItemWidget({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // CustomImageView(
            //   imagePath: ImageConstant.imgImage156x360,
            //   height: 156.h,
            //   width: double.maxFinite,
            //   alignment: Alignment.topCenter,
            // ),
            // CustomImageView(
            //   imagePath: ImageConstant.imgTopGradient,
            //   height: 56.h,
            //   width: double.maxFinite,
            //   alignment: Alignment.topCenter,
            // ),
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
                                    CustomRatingBar(
                                      color: Colors.yellow,
                                      ignoreGestures: true,
                                      initialRating: 5,
                                    ),
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
                                      color: appTheme.black900.withOpacity(0.5),
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
                                          "15 Thi Sách, Phường Thẳng Tam, Vũng Tàu, Bà Rịa - Vũng Tàu, Việt Nam",
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
                                          style: CustomTextStyles.bodyMediumPrimary,
                                        ),
                                        CustomImageView(
                                          onTap: (){
                                            Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => HotelDetailsRatingsReviewsScreen()),
                                            );
                                          },
                                          color: Colors.blueAccent,
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
                                        const Text(
                                          "8,6",
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold
                                          ),
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
                                                      color: Colors.blueAccent,
                                                      imagePath: ImageConstant.imgImage24x24,
                                                      height: 24.h,
                                                      width: 24.h,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.h),
                                                      child: Text(
                                                        "Ấn tượng",
                                                        style: CustomTextStyles
                                                            .titleSmallBlue,
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
                              return ChipTheme(
                                data: ChipTheme.of(context).copyWith(
                                  backgroundColor: Colors.white,
                                  selectedColor: Colors.blue,
                                  disabledColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.grey, // Border color
                                      width: 1, // Border width
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(50), // Rounded corners
                                  ),
                                ),
                                child: const Chip(
                                  label: Text(
                                    "1 sao",
                                    textAlign: TextAlign.center,
                                  ),
                                  // selected: false,
                                  // onSelected: (bool selected) {},
                                ),
                              );
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
                                onTap: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => HotelDetailsFacilitiesScreen()),
                                  );
                                },
                                color: Colors.blueAccent,
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
                                      color: appTheme.black900.withOpacity(0.5),
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
                                      color: appTheme.black900.withOpacity(0.5),
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
                              ),
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
                                  "Nảm dọc theo bãi biển Mỹ Khê cát trắng trải dài thơ mộng, khu nghỉ dưỡng dành cho gia đình sang trọng bật nhất thế giới Premier Village Danang được ưu ái tọa lạc ở vị trí đặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệt",
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    height: 1.50,
                                  ),
                                ),
                              ),
                              // SizedBox(height: 16.h),
                              // CustomDropDown(
                              //   width: 94.h,
                              //   icon: Container(
                              //     margin: EdgeInsets.only(left: 8.h),
                              //     child: CustomImageView(
                              //       imagePath: ImageConstant.imgArrowdownPrimary,
                              //       height: 20.h,
                              //       width: 20.h,
                              //       fit: BoxFit.contain,
                              //     ),
                              //   ),
                              //   iconSize: 20.h,
                              //   hintText: "Xem thêm",
                              //   hintStyle: CustomTextStyles.bodyMediumPrimary,
                              //   items: dropdownItemList,
                              //   contentPadding: EdgeInsets.all(12.h),
                              //   onChanged: (value) {},
                              // ),
                              SizedBox(height: 16.h)
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildSumsectionat(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumndescripti(BuildContext context) {
    return Container(
      width: 488.h,
      margin: EdgeInsets.only(left: 14.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Column(
            children: [
              Text(
                "Đánh giá hàng đầu",
                maxLines: 1,
                textAlign: TextAlign.start,
                style: theme.textTheme.titleSmall,
              ),
            ],
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
        buttonStyle: CustomButtonStyles.outlineWhiteTL16,
        buttonTextStyle: CustomTextStyles.titleSmallWhite,
      ),
    );
  }

  /// Section Widget
  Widget _buildChipone(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Lễ tân 24h",
        buttonStyle: CustomButtonStyles.outlineWhiteTL16,
        buttonTextStyle: CustomTextStyles.titleSmallWhite,
      ),
    );
  }

  /// Section Widget
  Widget _buildChiptwo(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Hồ bơi",
        buttonStyle: CustomButtonStyles.outlineWhiteTL16,
        buttonTextStyle: CustomTextStyles.titleSmallWhite,
      ),
    );
  }

  /// Section Widget
  Widget _buildChipthree(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Wifi",
        buttonStyle: CustomButtonStyles.outlineWhiteTL16,
        buttonTextStyle: CustomTextStyles.titleSmallWhite,
      ),
    );
  }
  Widget _buildSumsectionat(BuildContext context) {
    return Container(
      height: 115.h,
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
  Widget _buildChnphng(BuildContext context) {
    return CustomElevatedButton(
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ChooseRoomFullScreen()),
        );
      },
      text: "Chọn phòng",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
    );
  }
}
