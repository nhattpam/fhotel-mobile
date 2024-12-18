import 'package:fhotel_1/data/models/order_detail.dart';
import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/presenters/get_order_detail_presenter.dart';
import 'package:fhotel_1/views/my_booking_details/my_booking_details.dart';
import 'package:fhotel_1/views/my_service/get_order_detail_view.dart';
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

class Maincontent7ItemWidgetState extends State<Maincontent7ItemWidget> implements GetOrderDetailView  {
  List<OrderDetail> _orderDetails = [];
  late GetOrderDetailPresenter orderDetailPresenter;

  @override
  void initState() {
    super.initState();
    orderDetailPresenter = GetOrderDetailPresenter(this); // Initialize the presenter
    orderDetailPresenter.getListOrderDetailByReservationId(
        (widget.reservation.reservationId).toString());
  }

  double calculateTotalAmount() {
    // Sum up all the prices from _orderDetails
    double orderDetailsTotal = _orderDetails.fold(0.0, (sum, orderDetail) {
      return sum + (orderDetail.price ?? 0); // Ensure null safety
    });

    // Add the reservation's total amount
    return (widget.reservation.totalAmount ?? 0) + orderDetailsTotal;
  }
  @override
  Widget build(BuildContext context) {
    double totalAmount = calculateTotalAmount();
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
                  widget.reservation.reservationStatus == 'CheckOut'
                      ? _buildPayment(context)
                      : _buildPrePaid(context),
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
              child: Text(
                "Mã đặt phòng: ${widget.reservation.code}",
                style: theme.textTheme.labelLarge,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  "Giá: ${NumberFormat('#,###', 'en_US').format(totalAmount)} ₫",
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

  Widget _buildTthnhcng(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: widget.reservation.reservationStatus == 'Pending' ? 126.h : 126.h,
      text: widget.reservation.reservationStatus == 'Cancelled'
          ? "Đã bị hủy"
          : widget.reservation.reservationStatus == 'Refunded'
          ? "Đã hoàn tiền"
          : widget.reservation.reservationStatus == 'Pending'
          ? "Đặt thành công"
          : widget.reservation.reservationStatus == 'CheckOut'
          ? "Đã trả phòng"
          : "Đã nhận phòng",
      buttonStyle: widget.reservation.reservationStatus == 'Cancelled'
          ? CustomButtonStyles.fillRed // Add a red style for "Cancelled"
          : widget.reservation.reservationStatus == 'Refunded'
          ? CustomButtonStyles.fillGreen
          : widget.reservation.reservationStatus == 'Pending'
          ? CustomButtonStyles.fillGreen
          : CustomButtonStyles.fillGreen,
      buttonTextStyle: widget.reservation.reservationStatus == 'Cancelled'
          ? CustomTextStyles.bodyMediumwhiteA700 // Add an error style for "Cancelled"
          : widget.reservation.reservationStatus == 'Refunded'
          ? CustomTextStyles.bodyMediumTeal800 // Add an error style for "Cancelled"
          : widget.reservation.reservationStatus == 'Pending'
          ? CustomTextStyles.bodyMediumTeal800
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
            buttonStyle: CustomButtonStyles.fillRed,
            buttonTextStyle: CustomTextStyles.bodyMediumRobotoWhiteA700,
          );
  }
  Widget _buildPrePaid(BuildContext context) {
    return widget.reservation.isPrePaid == true
        ? CustomElevatedButton(
            height: 28.h,
            width: 150.h,
            text: "Đã thanh toán trước",
            buttonStyle: CustomButtonStyles.fillGreen,
            buttonTextStyle: CustomTextStyles.bodyMediumTeal800,
          )
        : CustomElevatedButton(
            height: 28.h,
            width: 150.h,
            text: "Chưa thanh toán trước",
            buttonStyle: CustomButtonStyles.fillRed,
            buttonTextStyle: CustomTextStyles.bodyMediumRobotoWhiteA700,
          );
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void onGetOrderDetailsSuccess(List<OrderDetail> orderDetails) {
    // TODO: implement onGetOrderDetailsSuccess
    setState(() {
      _orderDetails = orderDetails;
    });
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  void showOrderDetail(OrderDetail orderDetail) {
    // TODO: implement showOrderDetail
  }
}
