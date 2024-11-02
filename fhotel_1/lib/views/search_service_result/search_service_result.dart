import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/data/models/service.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../service_detail_screen/service_detail_screen.dart';

class SearchServiceResult extends StatefulWidget {
  final List<Services> service;

  SearchServiceResult({super.key, required this.service});

  @override
  SearchServiceResultState createState() => SearchServiceResultState();
}

class SearchServiceResultState extends State<SearchServiceResult>{

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
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
          onTap: () {
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
          text: "${widget.service[0].serviceType?.serviceTypeName}",
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
                  padding: EdgeInsets.only(left: 17.h),
                  child: const Text(
                    "|",
                    style: TextStyle(color: Colors.black),
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
        styleType: Style.bgFill);
  }



  Widget _buildColumnpopularbu(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tất cả ${widget.service[0].serviceType?.serviceTypeName}:",
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
              widget.service.length,
              (index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ServiceDetailScreen(service: widget.service[index])),
                    );
                  },
                  child: Container(
                    color: Colors.white,
                    height: 200.h,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.h,
                            vertical: 10.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 38.h),
                              Text(
                                (widget.service[index].serviceName).toString() ,
                                maxLines: 2,
                                style: CustomTextStyles.titleSmallBlue,
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 2.h),
                                        child: Text(
                                         "Giá: ${NumberFormat('#,###', 'en_US').format(widget.service[index].price)} ₫",
                                          style: CustomTextStyles.titleSmallGray600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 120.h,
                            width: 122.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                14.h,
                              ),
                            ),
                            child: Image.network(
                              (widget.service[index].image).toString(),
                              fit: BoxFit.cover,
                              height: 120.h,
                              width: 122.h,
                            ),
                          ),
                        ),
                      ],
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
}
