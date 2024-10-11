import 'package:fhotel_1/views/hotel_rating_and_reviews/widgets/list_label_item_value_widget.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class HotelDetailsRatingsReviewsScreen extends StatefulWidget {
  const HotelDetailsRatingsReviewsScreen({Key? key}) : super(key: key);

  @override
  HotelDetailsRatingsReviewsScreenState createState() =>
      HotelDetailsRatingsReviewsScreenState();
}

class HotelDetailsRatingsReviewsScreenState
    extends State<HotelDetailsRatingsReviewsScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

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
              TabBar(
                controller: tabviewController,
                labelPadding: EdgeInsets.zero,
                labelColor: appTheme.blue600,
                labelStyle: TextStyle(
                  fontSize: 15.fSize,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w800,
                ),
                unselectedLabelColor: appTheme.black900.withOpacity(0.5),
                unselectedLabelStyle: TextStyle(
                  fontSize: 15.fSize,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w800,
                ),
                dividerColor: appTheme.black900.withOpacity(0.5),
                indicatorColor: Colors.blueAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(
                    child: Text(
                      "Tất cả",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Phòng sạch",
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Nhân viên thân thiện",
                      maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabviewController,
                  children: [
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
                  const Text(
                    "8, 6",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Ấn tượng",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold),
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
                        color: Colors.yellow,
                        ignoreGestures: true,
                        initialRating: 5,
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
                          "Thoải mái",
                          style: CustomTextStyles.bodySmallBlack900,
                        ),
                      ),
                      CustomRatingBar(
                        color: Colors.yellow,
                        ignoreGestures: true,
                        initialRating: 4,
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
                          "Thức ăn",
                          style: CustomTextStyles.bodySmallBlack900,
                        ),
                      ),
                      CustomRatingBar(
                        color: Colors.yellow,
                        ignoreGestures: true,
                        initialRating: 3,
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
                        color: Colors.yellow,
                        ignoreGestures: true,
                        initialRating: 2,
                      ),
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

  // Widget _buildBasic(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: SizedBox(
  //         width: SizeUtils.width,
  //         child: SingleChildScrollView(
  //           child: SizedBox(
  //             height: SizeUtils.height,
  //             width: double.maxFinite,
  //             child: Stack(
  //               alignment: Alignment.bottomCenter,
  //               children: [
  //                 Align(
  //                   alignment: Alignment.center,
  //                   child: Container(
  //                     padding: EdgeInsets.only(
  //                       left: 34.h,
  //                       top: 67.v,
  //                       right: 34.h,
  //                     ),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         _buildNovbar(context),
  //                         SizedBox(height: 16.v),
  //                         _buildTabview(context),
  //                         SizedBox(height: 16.v),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(
  //                     top: 163.v,
  //                     bottom: 5.v,
  //                   ),
  //                   height: 763.v,
  //                   child: TabBarView(
  //                     controller: tabviewController,
  //                     children: [
  //                       HomeHotelRegionEmptyScreen(),
  //                       HomeHotelRegionEmptyScreen(),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       // bottomNavigationBar: _buildBottomBar(context),
  //     ),
  //   );
  // }

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
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListlabelvalueltemWidget();
          },
        ),
      ),
    );
  }
}