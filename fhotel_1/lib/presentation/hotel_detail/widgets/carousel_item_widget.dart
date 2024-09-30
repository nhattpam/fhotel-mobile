import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:fhotel_1/presentation/choose_room/choose_room.dart';
import 'package:fhotel_1/presentation/home_hotel_region_empty/widgets/carouselunit_item_widget.dart';
import 'package:fhotel_1/presentation/hotel_detail_facilities_screen/hotel_detail_facilities_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/app_export.dart';
import '../../hotel_edit_search/hotel_edit_search.dart';
import '../../hotel_rating_and_reviews/hotel_rating_and_reviews.dart';
class CarouselItemWidget extends StatefulWidget {
  CarouselItemWidget({Key? key}) : super(key: key);

  @override
  CarouselItemWidgetState createState() => CarouselItemWidgetState();
}
class CarouselItemWidgetState extends State<CarouselItemWidget> with TickerProviderStateMixin {
  int sliderIndex = 1;
  late TabController tabviewController;
  // GlobalKeys for sections
  final GlobalKey overviewKey = GlobalKey();
  final GlobalKey reviewsKey = GlobalKey();
  final GlobalKey amenitiesKey = GlobalKey();
  final GlobalKey descriptionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
    tabviewController.addListener(() {
      switch (tabviewController.index) {
        case 0:
          _scrollToSection(overviewKey);
          break;
        case 1:
          _scrollToSection(reviewsKey);
          break;
        case 2:
          _scrollToSection(amenitiesKey);
          break;
        case 3:
          _scrollToSection(descriptionKey);
          break;
      }
    });
  }
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(seconds: 1), curve: Curves.easeOut);
    }
  }
  void _showEditSearchModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const EditSearchBottomsheet();
      },
    );
  }
  @override
  void dispose() {
    tabviewController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.gray10001,
              ),
              child: Column(
                children: [
                  _buildContent(context),
                  _buildFiltersort(context),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              SizedBox(height: 12.h),
                              const CarouselunitItemWidget(),
                              Container(
                                key: overviewKey,
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
                                                    width: 260.h,
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
                                key: reviewsKey,
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
                                                    const Spacer(),
                                                    Text(
                                                      "Xem tất cả",
                                                      style: CustomTextStyles.bodyMediumPrimary,
                                                    ),
                                                    CustomImageView(
                                                      onTap: (){
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(builder: (context) => const HotelDetailsRatingsReviewsScreen()),
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
                                key: amenitiesKey,
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
                                          const Spacer(),
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
                                                const Spacer(),
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
                                                const Spacer(),
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
                                key: descriptionKey,
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
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
          text: "Khách sạn gần bạn",
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
                // SizedBox(width: 8.h),
                Padding(
                  padding:
                  EdgeInsets.only(left: 17.h),
                  child: const Text(
                    "|",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
                ),
                AppbarIconbutton(
                  imagePath: ImageConstant.imgDivider,
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 4.h,
                  ),
                ),
              ],
            ),
          )
        ],
        styleType: Style.bgFill
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 8.h),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
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
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapperGray60024x24,
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
            color: Colors.white,
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
            color: Colors.white,
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
            color: Colors.white,
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
              onTap: (){
                _showEditSearchModalBottomSheet(context);
              },
              height: 24.h,
              width: 24.h,
              padding: EdgeInsets.all(4.h),
              child: CustomImageView(
                color: Colors.white,
                imagePath: ImageConstant.imgArrowDownWhiteA700,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSheetheader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 4.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 100.h),
              child: Text(
                "Chi tiết khách sạn",
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
          ),
        ],
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

  Widget _buildChipone(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Lễ tân 24h",
        buttonStyle: CustomButtonStyles.outlineWhiteTL16,
        buttonTextStyle: CustomTextStyles.titleSmallWhite,
      ),
    );
  }

  Widget _buildChiptwo(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Hồ bơi",
        buttonStyle: CustomButtonStyles.outlineWhiteTL16,
        buttonTextStyle: CustomTextStyles.titleSmallWhite,
      ),
    );
  }

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

  Widget _buildFiltersort(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme .whiteA700,
      ),
      width: double.maxFinite,
      child: TabBar(
        controller: tabviewController,
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        labelColor: appTheme.blue600,
        labelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelColor: appTheme.gray600,
        unselectedLabelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        indicatorColor: appTheme.blue600,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: appTheme.black900.withOpacity(0.2),
        tabs: [
          const Tab(
            child: Text(
              "Tổng quan",
            ),
          ),
          const Tab(
            child: Text(
              "Đánh giá",
            ),
          ),
          const Tab(
            child: Text(
              "Tiện nghi",
            ),
          ),
          const Tab(
            child: Text(
              "Mô tả",
            ),
          )
        ],
      ),
    );
  }

}
