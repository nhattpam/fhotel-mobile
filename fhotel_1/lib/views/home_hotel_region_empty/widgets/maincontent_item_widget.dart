import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';


class MaincontentItemWidget extends StatefulWidget {
  final String hotelId;
  final String name;
  final String checkInDate;
  final String checkOutDate;
  final String address;
  const MaincontentItemWidget({super.key, required this.name,required this.address, required this.checkInDate, required this.checkOutDate, required this.hotelId});

  @override
  _MaincontentItemWidgetState createState() => _MaincontentItemWidgetState();
  }

  class _MaincontentItemWidgetState extends State<MaincontentItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.hotelDetail,
          arguments: {
            'hotelId': widget.hotelId,
            "checkInDate": widget.checkInDate,
            "checkOutDate": widget.checkOutDate,
            "numberOfRooms": 1,
          },
        );      },
      child: Container(
        width: 260.h,
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgIconWrapperPrimary,
              height: 24.h,
              width: 24.h,
              color: Colors.lightBlue,
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: CustomTextStyles.titleSmallPrimary
                            .copyWith(color: Colors.blue),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Địa chỉ: ${widget.address}",
                        style: theme.textTheme.bodySmall,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const VerticalDivider(
            //   color: Colors.grey,  // Set the color of the divider
            //   thickness: 1,       // Add space at the bottom of the divider
            // ),
          ],
        ),
      ),
    );
  }
}
