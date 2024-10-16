import 'package:fhotel_1/data/models/hotel_amenity.dart';
import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/presenters/list_room_type_presenter.dart';
import 'package:fhotel_1/views/choose_room/choose_room_view.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../data/repository/list_room_type_repo.dart';
import '../../choose_room_detail/choose_room_detail.dart';

class ListItemWidget extends StatefulWidget {
  final String hotelId;
  final String name;
  final int roomSize;
  final double basePrice;
  const ListItemWidget({super.key, required this.hotelId,required this.name,required this.roomSize,required this.basePrice});

  @override
  ListItemWidgetState createState() => ListItemWidgetState();
}

class ListItemWidgetState extends State<ListItemWidget> {
  void _showDetailModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ChooseRoomRoomDetailScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder8,
        border: Border.all(
          color: appTheme.black900.withOpacity(0.2),
          width: 1.h,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.fromLTRB(16.h, 8.h, 16.h, 6.h),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image filling the width of the container
                CustomImageView(
                  imagePath: ImageConstant.imgImage40x40,
                  height: 150.h, // Adjust height as per your requirement
                  width: double.infinity, // Make image take the full width
                  radius: BorderRadius.circular(8.h),
                ),
                SizedBox(height: 8.h),
                // Text section moved below the image
                Text(
                  widget.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall!.copyWith(
                    height: 1.50,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Room size: ${widget.roomSize}",
                  style: theme.textTheme.bodySmall,
                ),
                SizedBox(height: 8.h),
                // Icon Button at the bottom
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: CustomIconButton(
                //     onTap: () {
                //       _showDetailModalBottomSheet(context);
                //     },
                //     height: 24.h,
                //     width: 24.h,
                //     padding: EdgeInsets.all(4.h),
                //     decoration: IconButtonStyleHelper.outlineBlack,
                //     child: CustomImageView(
                //       imagePath: ImageConstant.imgArrowDownBlueGray700,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            width: double.maxFinite,
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIconWrapper15,
                  height: 24.h,
                  width: 24.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "2 người lớn, 1 trẻ em",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            width: double.maxFinite,
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIconWrapper16,
                  height: 24.h,
                  width: 24.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "2 giường đơn, 1 giường cỡ queen",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(),
          ),
          SizedBox(height: 6.h),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 16.h),
          //   decoration: BoxDecoration(
          //     color: appTheme.whiteA700,
          //   ),
          //   width: double.maxFinite,
          //   child: Row(
          //     children: [
          //       CustomImageView(
          //         color: Colors.green,
          //         imagePath: ImageConstant.imgIconWrapperGreenA70024x24,
          //         height: 24.h,
          //         width: 24.h,
          //       ),
          //       Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Padding(
          //           padding: EdgeInsets.only(left: 8.h),
          //           child: Text(
          //             "Bữa sáng miễn phí",
          //             style: theme.textTheme.bodyMedium,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(height: 8.h),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 16.h),
          //   decoration: BoxDecoration(
          //     color: appTheme.whiteA700,
          //   ),
          //   width: double.maxFinite,
          //   child: Row(
          //     children: [
          //       CustomImageView(
          //         color: appTheme.black900.withOpacity(0.5),
          //         imagePath: ImageConstant.imgIconWrapperBlack90024x24,
          //         height: 24.h,
          //         width: 24.h,
          //       ),
          //       Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Padding(
          //           padding: EdgeInsets.only(left: 8.h),
          //           child: Text(
          //             "Không hoàn tiền",
          //             style: CustomTextStyles.bodyMediumGray600,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(height: 8.h),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 16.h),
          //   decoration: BoxDecoration(
          //     color: appTheme.whiteA700,
          //   ),
          //   width: double.maxFinite,
          //   child: Row(
          //     children: [
          //       CustomImageView(
          //         color: Colors.green,
          //         imagePath: ImageConstant.imgIconWrapperGreenA70024x24,
          //         height: 24.h,
          //         width: 24.h,
          //       ),
          //       Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Padding(
          //           padding: EdgeInsets.only(left: 8.h),
          //           child: Text(
          //             "Wifi miễn phí",
          //             style: theme.textTheme.bodyMedium,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(height: 8.h),
          // SizedBox(
          //   width: double.maxFinite,
          //   child: Divider(),
          // ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.basePrice.toString(),
                          style: CustomTextStyles.titleSmallBlue,
                        ),
                        TextSpan(
                          text: "/ phòng / đêm",
                          style: CustomTextStyles.bodySmallOnPrimary,
                        )
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showDetailModalBottomSheet(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.h,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadiusStyle.roundedBorder4,
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Xem chi tiết phòng",
                          style: TextStyle(color: Colors.white),
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
}
