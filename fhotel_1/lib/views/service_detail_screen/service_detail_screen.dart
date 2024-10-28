import 'package:fhotel_1/data/models/service.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Services service;

  ServiceDetailScreen({super.key, required this.service});

  @override
  ServiceDetailScreenState createState() => ServiceDetailScreenState();
}

class ServiceDetailScreenState extends State<ServiceDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(children: [
            // _buildStackclockone(context),
            _buildscrollview(context),
            _buildAddcart(context)
          ]),
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
          text: "Chi tiết",
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

  Widget _buildscrollview(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 22.h),
              _buildHeadingImage(context),
              SizedBox(height: 22.h),
              Text(
                widget.service.serviceName.toString(),
                style: CustomTextStyles.titleSmallGray600,
              ),
              SizedBox(height: 20.h),
              Text(
                widget.service.description.toString(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium!.copyWith(
                  height: 1.71,
                ),
              ),
              SizedBox(height: 16.h),
              // SizedBox(
              //   width: double.maxFinite,
              //   child: Row(
              //     children: [
              //       Text(
              //         "Size:".toUpperCase(),
              //         style: theme.textTheme.bodyMedium,
              //       ),
              //       Expanded(
              //         child: Container(
              //           margin: EdgeInsets.only(
              //             left: 14.h,
              //             right: 112.h,
              //           ),
              //           child: SingleChildScrollView(
              //             scrollDirection: Axis.horizontal,
              //             child: Wrap(
              //               direction: Axis.horizontal,
              //               spacing: 10.h,
              //               children: List.generate(
              //                 3,
              //                 (index) {
              //                   return ServiceDetailItemWidget();
              //                 },
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 20.h),
              // SizedBox(
              //   width: double.maxFinite,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "ingridents".toUpperCase(),
              //         style: CustomTextStyles.titleSmallGray600,
              //       ),
              //       SizedBox(height: 29.h),
              //       SizedBox(
              //         width: double.maxFinite,
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Expanded(
              //               child: _buildcolumnchicken(
              //                 context,
              //                 iconbutton: ImageConstant.imgImage170x128,
              //                 chickenone: "Salt",
              //               ),
              //             ),
              //             SizedBox(width: 18.h),
              //             Expanded(
              //               child: _buildcolumnchicken(
              //                 context,
              //                 iconbutton: ImageConstant.imgImage170x128,
              //                 chickenone: "Salt",
              //               ),
              //             ),
              //             SizedBox(width: 18.h),
              //             Expanded(
              //               child: _buildcolumnchicken(
              //                 context,
              //                 iconbutton: ImageConstant.imgImage170x128,
              //                 chickenone: "Chicken",
              //               ),
              //             ),
              //             SizedBox(width: 18.h),
              //             Expanded(
              //               child: Align(
              //                 alignment: Alignment.center,
              //                 child: _buildcolumnchicken(
              //                   context,
              //                   iconbutton: ImageConstant.imgImage170x128,
              //                   chickenone: "onion\n(Alergy)",
              //                 ),
              //               ),
              //             ),
              //             SizedBox(width: 18.h),
              //             Expanded(
              //               child: _buildcolumnchicken(
              //                 context,
              //                 iconbutton: ImageConstant.imgImage170x128,
              //                 chickenone: "Garlic",
              //               ),
              //             ),
              //             SizedBox(width: 18.h),
              //             Expanded(
              //               child: Align(
              //                 alignment: Alignment.center,
              //                 child: _buildcolumnchicken(
              //                   context,
              //                   iconbutton: ImageConstant.imgImage170x128,
              //                   chickenone: "Pappers@ (Alergy)",
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //       SizedBox(height: 10.h),
              //       SizedBox(
              //         width: double.maxFinite,
              //         child: Row(
              //           children: [
              //             _buildcolumnchicken(
              //               context,
              //               iconbutton: ImageConstant.imgImage170x128,
              //               chickenone: "Ginger",
              //             ),
              //             SizedBox(width: 8.h),
              //             _buildcolumnorangel(
              //               context,
              //               iconbuttonFive: ImageConstant.imgImage170x128,
              //               orangeone: "Broccoli",
              //             ),
              //             SizedBox(width: 8.h),
              //             _buildcolumnorangel(
              //               context,
              //               iconbuttonFive: ImageConstant.imgImage170x128,
              //               orangeone: "Orange",
              //             ),
              //             SizedBox(width: 8.h),
              //             Expanded(
              //               child: Container(
              //                 width: double.maxFinite,
              //                 padding: EdgeInsets.only(left: 8.h),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     CustomIconButton(
              //                       height: 50.h,
              //                       width: 50.h,
              //                       padding: EdgeInsets.all(12.h),
              //                       child: CustomImageView(
              //                         imagePath: ImageConstant.imgImage170x128,
              //                       ),
              //                     ),
              //                     SizedBox(height: 4.h),
              //                     Padding(
              //                       padding: EdgeInsets.only(left: 2.h),
              //                       child: Text(
              //                         "Walnut",
              //                         style: theme.textTheme.labelLarge,
              //                       ),
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             )
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingImage(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 200.h, // Set the height explicitly so the Stack has enough space
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Stack(
        children: [
          // Background Image
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Image.network(
                widget.service.image.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddcart(BuildContext context) {
    double price = (quantity * ((widget.service.price) as num)).toDouble();
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
                          "Số lượng",
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 40, // Adjust width to keep layout consistent
                        child: TextFormField(
                          initialValue: quantity.toString(),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: theme.textTheme.titleSmall,
                          onFieldSubmitted: (value) {
                            final newQuantity = int.tryParse(value) ?? quantity;
                            setState(() {
                              quantity = newQuantity;
                            });
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                          NumberFormat('#,###', 'en_US').format(price) + " ₫",
                          style: CustomTextStyles.titleSmallBlue,
                        ),
                      ),
                    ],
                  ),
                )
              ],
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

  /// common widget
  Widget _buildcolumnchicken(
    BuildContext context, {
    required String iconbutton,
    required String chickenone,
  }) {
    return Column(
      children: [
        CustomIconButton(
          height: 50.h,
          width: 50.h,
          padding: EdgeInsets.all(12.h),
          child: CustomImageView(
            imagePath: iconbutton,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          chickenone,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.gray70001,
          ),
        )
      ],
    );
  }
}
