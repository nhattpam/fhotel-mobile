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
            Row(
                children:[
                 _buildTthnhcng(context),
                  SizedBox(width: 4.h),
                  _buildPayment(context),
                ],
            ),
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
            ),
            SizedBox(height: 6.h),

          ],
        ),
      ),
    );
  }

  Widget _buildTthnhcng(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: widget.reservation.reservationStatus == 'Pending' ? 126.h : 126.h,
      text: widget.reservation.reservationStatus == 'Cancelled'
          ? "Đã bị hủy"
          : widget.reservation.reservationStatus == 'Pending'
          ? "Đang xử lý"
          : "Đặt thành công",
      buttonStyle: widget.reservation.reservationStatus == 'Cancelled'
          ? CustomButtonStyles.fillRed // Add a red style for "Cancelled"
          : widget.reservation.reservationStatus == 'Pending'
          ? CustomButtonStyles.fillYellow
          : CustomButtonStyles.fillGreen,
      buttonTextStyle: widget.reservation.reservationStatus == 'Cancelled'
          ? CustomTextStyles.bodyMediumwhiteA700 // Add an error style for "Cancelled"
          : widget.reservation.reservationStatus == 'Pending'
          ? CustomTextStyles.bodyMediumSecondaryContainer
          : CustomTextStyles.bodyMediumTeal800,
    );

  }
  Widget _buildPayment(BuildContext context) {
    return widget.reservation.paymentStatus == 'Paid'
        ? CustomElevatedButton(
            height: 28.h,
            width: 126.h,
            text: "Đã thanh toán",
            buttonStyle: CustomButtonStyles.fillGreen,
            buttonTextStyle: CustomTextStyles.bodyMediumTeal800,
          )
        : CustomElevatedButton(
            height: 28.h,
            width: 126.h,
            text: "Chưa thanh toán",
            buttonStyle: CustomButtonStyles.fillYellow,
            buttonTextStyle: CustomTextStyles.bodyMediumSecondaryContainer,
          );
  }
}
