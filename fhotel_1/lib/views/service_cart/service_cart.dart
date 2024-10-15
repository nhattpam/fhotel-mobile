import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';

class MyCartScreen extends StatefulWidget {
  MyCartScreen({Key? key}) : super(key: key);

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  TextEditingController addressController = TextEditingController();

  // List to keep track of items and their corresponding quantities
  List<String> items = [
    "Pizza Calzone European",
    "Spaghetti Bolognese",
    "Lasagna"
  ];
  List<int> quantities = [1, 1, 1]; // Initialize all quantities to 1

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray10001,
        appBar: _buildAppbar(context),
        body: Column(
          children: [
            SizedBox(height: 18.h),
            Expanded(child: _buildListView(context)),
            SizedBox(height: 36.h),
          ],
        ),
        bottomNavigationBar: _buildAddcart(context),
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
        title: Row(
          children: [
            AppbarTitle(
              text: "Cart",
              margin: EdgeInsets.only(left: 8.h),
            ),
          ],
        ),
        styleType: Style.bgFill);
  }

  Widget _buildListView(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgImage170x129,
                            height: 116.h,
                            width: 136.h,
                            radius: BorderRadius.circular(24.h),
                          ),
                          SizedBox(width: 20.h),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 120.h,
                                          child: Text(
                                            items[index],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .titleSmallGray600,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      // X Button to delete item
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            items.removeAt(index);
                                            quantities.removeAt(index);
                                          });
                                        },
                                        child: Icon(Icons.close,
                                            color: Colors.red, size: 26.h),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  '\$32',
                                  style: CustomTextStyles.bodyLargeBlue,
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Decrease quantity button
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (quantities[index] > 1) {
                                                    quantities[index]--;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: 22.h,
                                                width: 22.h,
                                                decoration: BoxDecoration(
                                                  color: appTheme.whiteA700
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder8,
                                                ),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CustomImageView(
                                                      color: Colors.grey,
                                                      imagePath: ImageConstant
                                                          .imgContentMinus,
                                                      height: 16.h,
                                                      width: 16.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Display quantity
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 18.h),
                                              child: Text(
                                                quantities[index].toString(),
                                                style:
                                                    theme.textTheme.titleMedium,
                                              ),
                                            ),
                                            // Increase quantity button
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  quantities[index]++;
                                                });
                                              },
                                              child: Container(
                                                height: 22.h,
                                                width: 22.h,
                                                margin:
                                                    EdgeInsets.only(left: 18.h),
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    CustomImageView(
                                                      color: Colors.grey,
                                                      imagePath: ImageConstant
                                                          .imgIconWrapper6,
                                                      height: 16.h,
                                                      width: 16.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddcart(BuildContext context) {
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
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Tổng giá tiền",
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "8.000.000 ₫",
                          style: CustomTextStyles.titleSmallBlue,
                        ),
                      ),
                      CustomImageView(
                        color: appTheme.black900.withOpacity(0.3),
                        imagePath: ImageConstant.imgIconWrapper17,
                        height: 24.h,
                        width: 24.h,
                        margin: EdgeInsets.only(left: 4.h),
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
              style: TextStyle(color: appTheme.black900.withOpacity(0.5)),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 4.h,
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
      text: "Gọi món",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
    );
  }
}
