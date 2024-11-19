import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/models/room_stay_history.dart';
import 'package:fhotel_1/data/repository/list_room_stay_history.dart';
import 'package:fhotel_1/presenters/list_room_stay_history_presenter.dart';
import 'package:fhotel_1/views/my_booking_check_in/my_booking_checkin_view.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../core/app_export.dart';

// ignore_for_file: must be_ immutable
class MyBookingCheckin extends StatefulWidget {
  final Reservation reservation;

  MyBookingCheckin({super.key, required this.reservation});

  @override
  MyBookingCheckinState createState() => MyBookingCheckinState();
}

class MyBookingCheckinState extends State<MyBookingCheckin> implements ListRoomStayHistoryView{
  TextEditingController listmasteroneController = TextEditingController();
  int? numberOfDays;
  String? checkInDate;
  String? checkOutDate;
  late ListRoomStayHistoryPresenter _presenter;
  String? _error;
  bool _isLoading = false;
  List<RoomStayHistory> _hitories = [];

  @override
  void initState() {
    super.initState();
    _presenter = ListRoomStayHistoryPresenter(this, ListRoomStayHistory());
    _presenter.getRoomStayHistoryByReservationId((widget.reservation.reservationId).toString());
    _calculateDates();
  }

  void _calculateDates() {
    if (widget.reservation.checkInDate != null &&
        widget.reservation.checkOutDate != null) {
      try {
        // Parse using DateTime.parse if the string is in ISO format
        DateTime checkIn = DateTime.parse(widget.reservation.checkInDate!);
        DateTime checkOut = DateTime.parse(widget.reservation.checkOutDate!);

        setState(() {
          numberOfDays = checkOut.difference(checkIn).inDays;
          checkInDate = DateFormat('dd/MM/yyyy')
              .format(checkIn); // Format to desired output
          checkOutDate = DateFormat('dd/MM/yyyy').format(checkOut);
        });
      } catch (e) {
        print('Error parsing dates: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: appTheme.gray10001,
              ),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 8.h),
                    child: Column(
                      children: [
                        _buildordersummary(context),
                        SizedBox(height: 8.h),
                        ],
                    ),
                  ),
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
        text: "Lịch sử nhận và trả phòng",
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
              SizedBox(width: 8.h),
              AppbarIconbutton(
                imagePath: ImageConstant.imgDivider,
                margin: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 4.h,
                ),
              )
            ],
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  Widget _buildordersummary(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomElevatedButton(
                height: 28.h,
                width: widget.reservation.reservationStatus == 'Pending'
                    ? 126.h
                    : 126.h,
                text: widget.reservation.reservationStatus == 'Cancelled'
                    ? "Đã bị hủy"
                    : widget.reservation.reservationStatus == 'Pending'
                    ? "Đang xử lý"
                    : "Đặt thành công",
                buttonStyle: widget.reservation.reservationStatus == 'Cancelled'
                    ? CustomButtonStyles
                    .fillRed // Add a red style for "Cancelled"
                    : widget.reservation.reservationStatus == 'Pending'
                    ? CustomButtonStyles.fillYellow
                    : CustomButtonStyles.fillGreen,
                buttonTextStyle: widget.reservation.reservationStatus ==
                    'Cancelled'
                    ? CustomTextStyles
                    .bodyMediumwhiteA700 // Add an error style for "Cancelled"
                    : widget.reservation.reservationStatus == 'Pending'
                    ? CustomTextStyles.bodyMediumSecondaryContainer
                    : CustomTextStyles.bodyMediumTeal800,
              ),
              SizedBox(width: 4.h),
              widget.reservation.paymentStatus == 'Paid'
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
                text: "Chưa Thanh Toán",
                buttonStyle: CustomButtonStyles.fillRed,
                buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildPrePaid(context),
          SizedBox(height: 16.h),
          Text(
            "Lịch sử check-in, check-out",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          _buildMaincontent(context),
        ],
      ),
    );
  }
  Widget _buildMaincontent(BuildContext context) {
    return GroupedListView<RoomStayHistory, String>(
      shrinkWrap: true,
      elements: _hitories,
      groupBy: (reservation) {
        // Group by room number
        return (reservation.room?.roomNumber).toString();
      },
      groupSeparatorBuilder: (String roomNumber) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            "Phòng số " + roomNumber, // Display the room number as the group separator
            style: theme.textTheme.titleMedium,
          ),
        );
      },
      itemBuilder: (context, RoomStayHistory histories) {
        // String formattedCheckInDate = DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(histories.checkInDate.toString()));
        String formattedCheckInDate = "${DateFormat('HH:mm').format(DateTime.parse(histories.checkInDate.toString()))}, Ngày ${DateFormat('dd-MM-yyyy').format(DateTime.parse(histories.checkInDate.toString()))}";

        String? formattedCheckOutDate;
        if (histories.checkOutDate != null) {
          // formattedCheckOutDate = DateFormat('HH:mm dd-MM-yyyy').format(DateTime.parse(histories.checkOutDate.toString()));
          formattedCheckOutDate = "${DateFormat('HH:mm').format(DateTime.parse(histories.checkOutDate.toString()))}, Ngày ${DateFormat('dd-MM-yyyy').format(DateTime.parse(histories.checkOutDate.toString()))}";
        } else {
          formattedCheckOutDate = "Chưa xác định"; // Default value for null check-out date
        }
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            borderRadius: BorderRadiusStyle.roundedBorder8,
            border: Border.all(
              color: appTheme.blueGray50,
              width: 1.h,
            ),
            boxShadow: [
              BoxShadow(
                color: appTheme.black900.withOpacity(0.03),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 18.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      color: appTheme.black900.withOpacity(0.5),
                      imagePath: ImageConstant.imgIconWrapper14,
                      height: 24.h,
                      width: 24.h,
                    ),
                    SizedBox(width: 8.h),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nhận phòng",
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              formattedCheckInDate, // Use the check-in date from the history
                              style: theme.textTheme.titleSmall,
                            )
                          ],
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      color: appTheme.black900.withOpacity(0.5),
                      imagePath: ImageConstant.imgIconWrapper14,
                      height: 24.h,
                      width: 24.h,
                    ),
                    SizedBox(width: 8.h),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trả phòng",
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              formattedCheckOutDate, // Use the check-out date from the history
                              style: theme.textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 6.h),
            ],
          ),
        );
      },
      separator: SizedBox(height: 12.h), // Add spacing between items
      order: GroupedListOrder.ASC, // Adjust based on your desired order
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
      width: 126.h,
      text: "Chưa thanh toán trước",
      buttonStyle: CustomButtonStyles.fillRed,
      buttonTextStyle: CustomTextStyles.bodyMediumRobotoWhiteA700,
    );
  }
// Show loading indicator
  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  // Hide loading indicator
  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onGetRoomStayHistoryError(String error) {
    setState(() {
      _error = error;
    });
  }

  @override
  void onGetRoomStayHistorySuccess(List<RoomStayHistory> history) {
    setState(() async {
      _hitories = history;
      _error = null;
    });
  }


}
