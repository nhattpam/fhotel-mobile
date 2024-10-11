import 'package:badges/badges.dart' as badges; // Alias the badges package
import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/views/search_service_result/widgets/search_service_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class SearchServiceResult extends StatelessWidget {
  SearchServiceResult({Key? key})
      : super(
    key: key,
  );
  int cartItemCount = 5;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        backgroundColor: appTheme.gray10001,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Column(
                children: [
                  SizedBox(height: 18.h),
                  _buildColumnpopularbu(context),
                  SizedBox(height: 32.h),
                  // buildopenresturants(context)
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjusts alignment
          children: [
            AppbarTitle(
              text: "Danh sách Pizza",
              margin: EdgeInsets.only(left: 8.h),
            ),
            _buildCartIconWithBadge(cartItemCount)
          ],
        ),
        styleType: Style.bgFill
    );
  }
  Widget _buildCartIconWithBadge(int cartItemCount) {
    return Container(
      margin: EdgeInsets.only(
        top: 16.h,
        right: 16.h,
        bottom: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // AppbarImage or an icon for shopping cart
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
            child: badges.Badge(
              badgeColor: Colors.redAccent,// Use the alias for the badge
              badgeContent: Text( // Use 'badge' instead of 'badgeContent'
                cartItemCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: Icon(Icons.shopping_bag_outlined, size: 28.h, color: Colors.white,),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnpopularbu(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular Pizza",
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 18.h),
          ResponsiveGridListBuilder(
            minItemWidth: 1,
            minItemsPerRow: 2,
            maxItemsPerRow: 2,
            horizontalGridSpacing: 20.h,
            verticalGridSpacing: 20.h,
            builder: (context, items) => ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: items,
            ),
            gridItems: List.generate(
              4,
                  (index) {
                return FoodBurgersItemWidget();
              },
            ),
          )
        ],
      ),
    );
  }

}