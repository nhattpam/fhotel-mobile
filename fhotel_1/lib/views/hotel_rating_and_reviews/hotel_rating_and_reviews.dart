import 'package:fhotel_1/views/hotel_rating_and_reviews/widgets/list_label_item_value_widget.dart';
import 'package:fhotel_1/views/write_review/write_review_screen.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class HotelDetailsRatingsReviewsScreen extends StatefulWidget {
  const HotelDetailsRatingsReviewsScreen({Key? key}) : super(key: key);

  @override
  HotelDetailsRatingsReviewsScreenState createState() =>
      HotelDetailsRatingsReviewsScreenState();
}

class HotelDetailsRatingsReviewsScreenState extends State<HotelDetailsRatingsReviewsScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final List<String> ratings = ["5 sao", "4 sao", "3 sao", "2 sao", "1 sao"];

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
              _buildListlabelvalue(context),
              // TabBar(
              //   controller: tabviewController,
              //   labelPadding: EdgeInsets.zero,
              //   labelColor: appTheme.blue600,
              //   labelStyle: TextStyle(
              //     fontSize: 15.fSize,
              //     fontFamily: 'Mulish',
              //     fontWeight: FontWeight.w800,
              //   ),
              //   unselectedLabelColor: appTheme.black900.withOpacity(0.5),
              //   unselectedLabelStyle: TextStyle(
              //     fontSize: 15.fSize,
              //     fontFamily: 'Mulish',
              //     fontWeight: FontWeight.w800,
              //   ),
              //   dividerColor: appTheme.black900.withOpacity(0.5),
              //   indicatorColor: Colors.blueAccent,
              //   indicatorSize: TabBarIndicatorSize.tab,
              //   tabs: const [
              //     Tab(
              //       child: Text(
              //         "Tất cả",
              //       ),
              //     ),
              //     Tab(
              //       child: Text(
              //         "Phòng sạch",
              //       ),
              //     ),
              //     Tab(
              //       child: Text(
              //         "Nhân viên thân thiện",
              //         maxLines: 1,
              //         // overflow: TextOverflow.ellipsis,
              //       ),
              //     ),
              //   ],
              // ),
              // Expanded(
              //   child: TabBarView(
              //     controller: tabviewController,
              //     children: [
              //       Expanded(
              //         child: Container(
              //           width: double.maxFinite,
              //           padding: EdgeInsets.symmetric(vertical: 12.h),
              //           decoration: BoxDecoration(
              //             color: appTheme.whiteA700,
              //           ),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.max,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [_buildListlabelvalue(context)],
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0, right: 10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WriteReviewScreen(), // Replace with your review screen
                ),
              );
            },
            backgroundColor: appTheme.blue600,
            child: const Icon(Icons.edit), // You can customize the icon
            tooltip: "Write a review",
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        onTap: (){
          Navigator.pop(context);
        },
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
        mainAxisAlignment: MainAxisAlignment.start,
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
                    "4,6/5",
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
          SizedBox(
            height: 50.h,
            width: 200.h,
            child: GridView.builder(
              padding: EdgeInsets.only(left: 16.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 2 items per row
                mainAxisSpacing: 8, // Vertical spacing between items
                crossAxisSpacing: 8, // Horizontal spacing between items
                childAspectRatio: 3, // Adjust as needed for the chip size
              ),
              itemCount: ratings.length,
              itemBuilder: (context, index) {
                return ChipTheme(
                  data: ChipTheme.of(context).copyWith(
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue,
                    disabledColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Chip(
                    padding: const EdgeInsets.only(bottom :10),
                    label: Text(
                      ratings[index],
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1, // Adjusts text's vertical position
                      ),
                    ),
                  ),
                );
              },
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
