import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/models/transaction.dart';
import 'package:fhotel_1/views/my_booking_details/my_booking_details.dart';
import 'package:fhotel_1/views/my_transaction_detail/my_transaction_detail.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class MyTransactionnWidget extends StatefulWidget {
  final Transaction transaction;

  const MyTransactionnWidget({Key? key, required this.transaction})
      : super(
    key: key,
  );

  @override
  MyTransactionnWidgetState createState() => MyTransactionnWidgetState();
}

class MyTransactionnWidgetState extends State<MyTransactionnWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.transaction.bill);
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  MyTransactionDetail(transaction: widget.transaction)),
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
            // Row(
            //   children:[
            //     _buildTthnhcng(context),
            //     SizedBox(width: 4.h),
            //     widget.reservation.reservationStatus == 'CheckOut'
            //         ? _buildPayment(context)
            //         : _buildPrePaid(context),
            //   ],
            // ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.maxFinite,
              child: Text(
                (widget.transaction.description)
                    .toString(),
                style: theme.textTheme.titleSmall,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.maxFinite,
              child: Divider(
                color: appTheme.blueGray50,
              ),
            ),
            // SizedBox(
            //   width: double.maxFinite,
            //   child: Text(
            //     "Mã đặt phòng: ${widget.reservation.code}",
            //     style: theme.textTheme.labelLarge,
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  "Số tiền: ${NumberFormat('#,###', 'en_US').format(widget.transaction.amount)} ₫",
                  style: CustomTextStyles.titleSmallBlue,
                ),
              ),
            ),
            SizedBox(height: 6.h),
          ],
        ),
      ),
    );
  }

  // Widget _buildTthnhcng(BuildContext context) {
  //   return CustomElevatedButton(
  //     height: 28.h,
  //     width: widget.reservation.reservationStatus == 'Pending' ? 126.h : 126.h,
  //     text: widget.reservation.reservationStatus == 'Cancelled'
  //         ? "Đã bị hủy"
  //         : widget.reservation.reservationStatus == 'Refunded'
  //         ? "Đã hoàn tiền"
  //         : widget.reservation.reservationStatus == 'Pending'
  //         ? "Đặt thành công"
  //         : widget.reservation.reservationStatus == 'CheckOut'
  //         ? "Đã trả phòng"
  //         : "Đã nhận phòng",
  //     buttonStyle: widget.reservation.reservationStatus == 'Cancelled'
  //         ? CustomButtonStyles.fillRed // Add a red style for "Cancelled"
  //         : widget.reservation.reservationStatus == 'Refunded'
  //         ? CustomButtonStyles.fillGreen
  //         : widget.reservation.reservationStatus == 'Pending'
  //         ? CustomButtonStyles.fillGreen
  //         : CustomButtonStyles.fillGreen,
  //     buttonTextStyle: widget.reservation.reservationStatus == 'Cancelled'
  //         ? CustomTextStyles.bodyMediumwhiteA700 // Add an error style for "Cancelled"
  //         : widget.reservation.reservationStatus == 'Refunded'
  //         ? CustomTextStyles.bodyMediumTeal800 // Add an error style for "Cancelled"
  //         : widget.reservation.reservationStatus == 'Pending'
  //         ? CustomTextStyles.bodyMediumTeal800
  //         : CustomTextStyles.bodyMediumTeal800,
  //   );
  // }
  //
  // Widget _buildPayment(BuildContext context) {
  //   return widget.reservation.paymentStatus == 'Paid'
  //       ? CustomElevatedButton(
  //     height: 28.h,
  //     width: 126.h,
  //     text: "Đã thanh toán",
  //     buttonStyle: CustomButtonStyles.fillGreen,
  //     buttonTextStyle: CustomTextStyles.bodyMediumTeal800,
  //   )
  //       : CustomElevatedButton(
  //     height: 28.h,
  //     width: 126.h,
  //     text: "Chưa thanh toán",
  //     buttonStyle: CustomButtonStyles.fillRed,
  //     buttonTextStyle: CustomTextStyles.bodyMediumRobotoWhiteA700,
  //   );
  // }
  // Widget _buildPrePaid(BuildContext context) {
  //   return widget.reservation.isPrePaid == true
  //       ? CustomElevatedButton(
  //     height: 28.h,
  //     width: 150.h,
  //     text: "Đã thanh toán trước",
  //     buttonStyle: CustomButtonStyles.fillGreen,
  //     buttonTextStyle: CustomTextStyles.bodyMediumTeal800,
  //   )
  //       : CustomElevatedButton(
  //     height: 28.h,
  //     width: 150.h,
  //     text: "Chưa thanh toán trước",
  //     buttonStyle: CustomButtonStyles.fillRed,
  //     buttonTextStyle: CustomTextStyles.bodyMediumRobotoWhiteA700,
  //   );
  // }
}
