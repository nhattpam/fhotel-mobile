import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/feedback.dart';
import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/models/user.dart';
import 'package:fhotel_1/data/repository/list_reservation_repo.dart';
import 'package:fhotel_1/presenters/list_reservation_presenter.dart';
import 'package:fhotel_1/presenters/user_profile_presenter.dart';
import 'package:fhotel_1/views/my_booking_check_in/my_booking_checkin.dart';
import 'package:fhotel_1/views/write_review/write_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart' as html;

import '../../core/app_export.dart';
import '../../data/models/order_detail.dart';
import '../../data/models/wallet.dart';
import '../../presenters/create_feedback_presenter.dart';
import '../../presenters/create_reservation.dart';
import '../../presenters/get_order_detail_presenter.dart';
import '../choose_room_detail/create_reservation_view.dart';
import '../my_service/get_order_detail_view.dart';
import '../tabbar_booking_and_service/list_reservation_view.dart';
import '../user_profile/user_profile_view.dart';
import '../write_review/create_feedback_view.dart';

// ignore_for_file: must be_ immutable
class MyBookingDetailsScreen extends StatefulWidget {
  final Reservation reservation;

  MyBookingDetailsScreen({super.key, required this.reservation});

  @override
  MyBookingDetailsScreenState createState() => MyBookingDetailsScreenState();
}

class MyBookingDetailsScreenState extends State<MyBookingDetailsScreen>
    implements
        CreateFeedbackView,
        ListReservationView,
        CreateReservationView,
        UserProfileView,
        GetOrderDetailView {
  TextEditingController listmasteroneController = TextEditingController();
  int? numberOfDays;
  String? checkInDate;
  String? checkOutDate;
  late CreateFeedbackPresenter presenter;
  late ListReservationPresenter _presenter;
  late UserProfilePresenter _userProfilePresenter;
  late GetOrderDetailPresenter orderDetailPresenter;

  late CreateReservation _createReservation;
  Feedbacks? _feedbacks;
  User? _customer;
  Wallet? _wallet;
  OrderDetail? _orderDetail;

  @override
  void initState() {
    super.initState();
    presenter = CreateFeedbackPresenter(this);
    presenter.getFeedbacks((widget.reservation.reservationId).toString());
    _presenter = ListReservationPresenter(this, ListReservationRepo());
    _createReservation = CreateReservation(this);
    _userProfilePresenter =
        UserProfilePresenter(this); // Initialize the presenter
    _userProfilePresenter.getCustomerById(); // Fetch customer data
    orderDetailPresenter =
        GetOrderDetailPresenter(this); // Initialize the presenter
    orderDetailPresenter.getOrderDetailByReservationId(
        (widget.reservation.reservationId).toString());
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
                        _buildPaymentmethod(context),
                        SizedBox(height: 8.h),
                        _buildAdditionalone(context),
                        SizedBox(height: 8.h),
                        _buildColumntitlecont(context),
                        SizedBox(height: 8.h),
                        _buildColumntitlepric(context),
                        SizedBox(height: 8.h),
                        (widget.reservation.reservationStatus != 'CheckIn' &&
                                widget.reservation.reservationStatus !=
                                    'CheckOut')
                            ? SizedBox()
                            : _buildColumnsave(context),
                        (widget.reservation.paymentStatus != 'Paid' &&
                                widget.reservation.reservationStatus ==
                                    'Pending')
                            ? _buildCancel(context)
                            : SizedBox(),
                        (widget.reservation.paymentStatus == 'Paid' &&
                                widget.reservation.reservationStatus ==
                                    'Pending' &&
                                _orderDetail?.order?.orderStatus != 'Confirmed')
                            ? _buildRefund(context)
                            : SizedBox(),
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
        text: "Thông tin thanh toán",
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
    String description = (widget.reservation.roomType?.description).toString();
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
                      text: "Chưa thanh toán",
                      buttonStyle: CustomButtonStyles.fillRed,
                      buttonTextStyle:
                          CustomTextStyles.bodyMediumRobotoWhiteA700,
                    ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildPrePaid(context),
          SizedBox(height: 16.h),
          Text(
            "Chi tiết đặt phòng",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          Container(
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
                  offset: Offset(
                    0,
                    0,
                  ),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 4.h),
                  decoration: BoxDecoration(
                    color: appTheme.blue600,
                    border: Border(
                      bottom: BorderSide(
                        color: appTheme.blueGray50,
                        width: 1.h,
                      ),
                    ),
                  ),
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                        color: Colors.white,
                        imagePath: ImageConstant.imgIconWrapperPrimary,
                        height: 24.h,
                        width: 24.h,
                      ),
                      SizedBox(width: 8.h),
                      Expanded(
                        child: Text(
                          (widget.reservation.roomType?.hotel?.hotelName)
                              .toString(),
                          style: CustomTextStyles.bodyMediumwhiteA700,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 8.h,
                  ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              html.Html(
                                data: """
                               $description
                              """,
                                style: {
                                  "body": html.Style(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                },
                              ),
                              // Text(
                              //   (widget.reservation.roomType?.description).toString(),
                              //   maxLines: 2,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: theme.textTheme.titleSmall!.copyWith(
                              //     height: 1.50,
                              //   ),
                              // ),
                              SizedBox(height: 2.h),
                              (widget.reservation.roomType?.roomSize != null)
                                  ? Text(
                                      "Diện tích: ${NumberFormat('#,###', 'en_US').format(widget.reservation.roomType?.roomSize)}m²",
                                      style: theme.textTheme.bodySmall,
                                    )
                                  : Skeleton(
                                      width: 50.h,
                                    )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20.h),
                      Text(
                        "x ${widget.reservation.numberOfRooms}",
                        style: theme.textTheme.titleSmall,
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
                        imagePath: ImageConstant.imgIconWrapper9,
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
                                "Số đêm",
                                style: theme.textTheme.bodyMedium,
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "$numberOfDays đêm",
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
                        imagePath: ImageConstant.imgIconWrapper16,
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
                                "Loại phòng",
                                style: theme.textTheme.bodyMedium,
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                (widget.reservation.roomType?.type?.typeName)
                                    .toString(),
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
                SizedBox(
                  width: double.maxFinite,
                  child: Divider(),
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
                                "Nhận phòng",
                                style: theme.textTheme.bodyMedium,
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "14:00 chiều, ${checkInDate}",
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
                                "Trước 12:00 trưa, ${checkOutDate}",
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
                SizedBox(
                  width: double.maxFinite,
                  child: Divider(),
                ),
                SizedBox(height: 8.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.blue50,
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mã đặt chỗ",
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              (widget.reservation?.code).toString(),
                              style: theme.textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                      CustomImageView(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: (widget.reservation?.code).toString()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Đã lưu mã đặt phòng vào bộ nhớ tạm của bạn')),
                          );
                        },
                        color: Colors.blueAccent,
                        imagePath: ImageConstant.imgIconWrapper20,
                        height: 24.h,
                        width: 24.h,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentmethod(BuildContext context) {
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
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phương thức thanh toán",
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            width: double.maxFinite,
            child: Row(
              children: [
                Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.circleBorder12,
                    border: Border.all(
                      color: appTheme.black900.withOpacity(0.05),
                      width: 1.h,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      (widget.reservation?.paymentMethodId ==
                              '03c20593-9817-4cda-982f-7c8e7ee162e8')
                          ? CustomImageView(
                              imagePath: ImageConstant.imgImg,
                              height: 40.h,
                              width: double.maxFinite,
                              radius: BorderRadius.circular(
                                14.h,
                              ),
                            )
                          : Container(
                              height: 40.h,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                14.h,
                              )),
                              child: Icon(Icons.payment, size: 20.h),
                            )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Text(
                    (widget.reservation.paymentMethod?.paymentMethodName !=
                            null)
                        ? (widget.reservation.paymentMethod?.paymentMethodName)
                            .toString()
                        : 'Chưa chọn phương thức thanh toán',
                    style: theme.textTheme.titleSmall,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAdditionalone(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Thông tin khách",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            width: double.maxFinite,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgIconWrapper15,
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
                          "Tên khách",
                          style: theme.textTheme.bodyMedium,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          (widget.reservation.customer?.name).toString(),
                          style: theme.textTheme.titleSmall,
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

  Widget _buildColumntitlecont(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Thông tin liên hệ",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.maxFinite,
            child: _buildWrapperFive(context,
                labelguestTwo: "Họ tên",
                datavalueone: (widget.reservation.customer?.name).toString()),
          ),
          SizedBox(
            width: double.maxFinite,
            child: _buildWrapperFive(
              context,
              labelguestTwo: "Số điện thoại",
              datavalueone:
                  (widget.reservation.customer?.phoneNumber).toString(),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: _buildWrapperFive(
              context,
              labelguestTwo: "Email",
              datavalueone: (widget.reservation.customer?.email).toString(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildColumntitlepric(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.h),
          Text(
            "Chi tiết giá",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.maxFinite,
            child: _buildWrapperFive(context,
                labelguestTwo:
                    "${widget.reservation.numberOfRooms} Phòng ${widget.reservation.roomType?.hotel?.hotelName}",
                datavalueone:
                    "${NumberFormat('#,###', 'en_US').format(widget.reservation.totalAmount)} ₫"),
          ),
          SizedBox(height: 6.h),
          // SizedBox(
          //   width: double.maxFinite,
          //   child: Divider(),
          // ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.maxFinite,
            child: _buildWrapperFive(context,
                labelguestTwo: "Tổng cộng",
                datavalueone:
                    "${NumberFormat('#,###', 'en_US').format(widget.reservation.totalAmount)} ₫"),
          )
        ],
      ),
    );
  }

  Widget _buildColumnsave(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.reservation.reservationStatus == 'CheckOut'
              ? CustomElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WriteReviewScreen(
                          reservationId:
                              widget.reservation.reservationId.toString(),
                          feedback: _feedbacks ??
                              Feedbacks(), // Provide a default `Feedbacks` instance if `_feedbacks` is null
                        ),
                      ),
                    );
                  },
                  text: _feedbacks == null
                      ? "Viết đánh giá"
                      : "Thay đổi đánh giá",
                  margin: EdgeInsets.only(bottom: 12.h),
                  buttonStyle: CustomButtonStyles.fillBlue,
                  buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
                )
              : Container(),
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        MyBookingCheckin(reservation: widget.reservation)),
              );
            },
            text: "Xem phòng",
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.fillBlue,
            buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
          ),
        ],
      ),
    );
  }

  Widget _buildCancel(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            onPressed: () async {
              DateTime checkInDate =
                  DateTime.parse(widget.reservation.checkInDate.toString());
              DateTime checkInTime = DateTime(checkInDate.year,
                  checkInDate.month, checkInDate.day, 9); // 9 AM on checkInDate
              if (DateTime.now().isAfter(checkInTime)) {
                // Your code here
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.error,
                  body: const Center(
                    child: Text(
                      'Không thể hủy đặt phòng vì đã vượt quá thời hạn (9h sáng của ngày nhận phòng)!!!',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  // title: 'Warning',
                  // desc:   'This is also Ignored',
                  btnCancelOnPress: () {
                    // Close login dialog
                  },
                ).show();
              } else {
                await _presenter.updateReservation(
                  (widget.reservation.reservationId).toString(),
                  (widget.reservation.numberOfRooms ?? 0),
                  (widget.reservation.code).toString(),
                  (widget.reservation.roomTypeId).toString(),
                  (widget.reservation.checkInDate).toString(),
                  (widget.reservation.checkOutDate).toString(),
                  (widget.reservation.totalAmount ?? 0),
                  (widget.reservation.customerId).toString(),
                  (widget.reservation.paymentStatus).toString(),
                  'Cancelled',
                  (widget.reservation.paymentMethodId).toString(),
                  (widget.reservation.createdDate).toString(),
                  (widget.reservation.isPrePaid) ?? false,
                );
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.success,
                  body: const Center(
                    child: Text(
                      'Hủy đặt phòng thành công!!!',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  // title: 'Warning',
                  // desc:   'This is also Ignored',
                  btnOkOnPress: () {
                    Navigator.pop(context); // Close login dialog
                  },
                ).show();
              }
            },
            text: "Hủy đặt phòng",
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.fillRed,
            buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
          )
        ],
      ),
    );
  }

  Widget _buildRefund(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            onPressed: () async {
              if (_wallet?.bankAccountNumber != null) {
                DateTime checkInDate =
                    DateTime.parse(widget.reservation.checkInDate.toString());

              // Calculate one day before check-in at 9:00 AM
                DateTime oneDayBeforeCheckIn = DateTime(
                  checkInDate.year,
                  checkInDate.month,
                  checkInDate.day - 1, // Subtract 1 day
                  9, // Set time to 9 AM
                );

                DateTime now = DateTime.now(); // Get current time once for consistency

                // Debugging: Print values
                print("Check-in Date: $checkInDate");
                print("One Day Before Check-in (9:00 AM): $oneDayBeforeCheckIn");
                print("Current Time: $now");

                // Block refund requests after 9:00 AM, one day before check-in
                if (now.isAfter(oneDayBeforeCheckIn)) {
                  // Show error dialog if the current time is after the deadline
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.error,
                    body: const Center(
                      child: Text(
                        'Đã vượt quá thời hạn không thể yêu cầu hoàn tiền (Trước 9h sáng ngày nhận phòng 1 ngày)!!!!',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    btnOkColor: Colors.red,
                    btnOkOnPress: () {
                    },
                  ).show();
                } else {
                  // Allow refund creation
                  await _createReservation.createRefund(
                    (widget.reservation.reservationId).toString(),
                  );
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.success,
                    body: const Center(
                      child: Text(
                        'Yêu cầu hoàn tiền của bạn đã được gửi!!!',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    btnOkOnPress: () {
                      Navigator.pop(context); // Close dialog
                    },
                  ).show();
                }
              } else {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.error,
                  body: const Center(
                    child: Text(
                      'Vui lòng cập nhật số tài khoản ngân hàng để yêu cầu hoàn tiền!!!',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  // title: 'Warning',
                  // desc:   'This is also Ignored',
                  btnOkColor: Colors.red,
                  btnOkOnPress: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.userChangeBank,
                        arguments: {'customer': _customer, 'wallet': _wallet});
                  },
                ).show();
              }
            },
            text: "Yêu cầu hoàn tiền",
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.fillRed,
            buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
          )
        ],
      ),
    );
  }

  Widget _buildWrapperFive(
    BuildContext context, {
    required String labelguestTwo,
    required String datavalueone,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 8.h,
        bottom: 6.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              labelguestTwo,
              maxLines: 5,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          Text(
            datavalueone,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWrapperTwo(
    BuildContext context, {
    required String valuebooking,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Row(
        children: [
          CustomImageView(
            color: Colors.green,
            imagePath: ImageConstant.imgIconWrapperGreenA70024x24,
            height: 24.h,
            width: 24.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.h),
            child: Text(
              valuebooking,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          )
        ],
      ),
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
  @override
  void onGetFeedbackSuccess(Feedbacks feedback) {
    setState(() {
      _feedbacks = feedback;
    });
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void onGetReservationSuccess(Reservation reservation) {
    // TODO: implement onGetReservationSuccess
  }

  @override
  void onGetReservationsError(String error) {
    // TODO: implement onGetReservationsError
  }

  @override
  void onGetReservationsSuccess(List<Reservation> reservations) {
    // TODO: implement onGetReservationsSuccess
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  void onCreateAvailableRoomSuccess(int availableRoom) {
    // TODO: implement onCreateAvailableRoomSuccess
  }

  @override
  void onCreateError(String error) {
    // TODO: implement onCreateError
  }

  @override
  void onCreateSuccess() {
    // TODO: implement onCreateSuccess
  }

  @override
  void onCreateTotalAmountSuccess(double totalAmount) {
    // TODO: implement onCreateTotalAmountSuccess
  }

  @override
  void showValidationError(String field, String message) {
    // TODO: implement showValidationError
  }

  @override
  void onGetCustomerError(String error) {
    // TODO: implement onGetCustomerError
  }

  @override
  void onGetCustomerSuccess(User user) {
    // TODO: implement onGetCustomerSuccess
    setState(() {
      _customer = user;
    });
  }

  @override
  void onGetWalletSuccess(Wallet wallet) {
    // TODO: implement onGetWalletSuccess
    setState(() {
      _wallet = wallet;
    });
  }

  @override
  void onGetOrderDetailsSuccess(List<OrderDetail> orders) {
    // TODO: implement onGetOrderDetailsSuccess
  }

  @override
  void showOrderDetail(OrderDetail orderDetails) {
    // TODO: implement showOrderDetail
    setState(() {
      _orderDetail = orderDetails;
    });
  }
}
