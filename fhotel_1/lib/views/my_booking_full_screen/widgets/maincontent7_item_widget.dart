import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/views/my_booking_details/my_booking_details.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class Maincontent7ItemWidget extends StatefulWidget {
  final Reservation reservation;

  const Maincontent7ItemWidget({Key? key, required this.reservation})
      : super(
          key: key,
        );

  @override
  Maincontent7ItemWidgetState createState() => Maincontent7ItemWidgetState();
}

class Maincontent7ItemWidgetState extends State<Maincontent7ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  MyBookingDetailsScreen(reservation: widget.reservation)),
        );
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 4.h),
            _buildTthnhcng(context),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                children: [
                  CustomImageView(
                    color: appTheme.black900.withOpacity(0.5),
                    imagePath: ImageConstant.imgIconWrapperPrimary,
                    height: 24.h,
                    width: 24.h,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Text(
                        (widget.reservation.roomType?.hotel?.hotelName)
                            .toString(),
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.maxFinite,
              child: Divider(
                color: appTheme.blueGray50,
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Mã đặt chỗ: 453653657",
                    style: theme.textTheme.labelLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      NumberFormat('#,###', 'en_US')
                              .format(widget.reservation.totalAmount) +
                          " ₫",
                      style: CustomTextStyles.titleSmallBlue,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTthnhcng(BuildContext context) {
    return widget.reservation.reservationStatus != 'Pending'
        ? CustomElevatedButton(
            height: 28.h,
            width: 126.h,
            text: "Đặt thành công",
            buttonStyle: CustomButtonStyles.fillGreen,
            buttonTextStyle: CustomTextStyles.bodyMediumTeal800,
          )
        : CustomElevatedButton(
            height: 28.h,
            width: 94.h,
            text: "Đang xử lý",
            buttonStyle: CustomButtonStyles.fillYellow,
            buttonTextStyle: CustomTextStyles.bodyMediumSecondaryContainer,
          );
  }
}
