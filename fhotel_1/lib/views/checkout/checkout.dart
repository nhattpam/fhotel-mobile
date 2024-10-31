import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/repository/list_reservation_repo.dart';
import 'package:fhotel_1/presenters/vn_pay_presenter.dart';
import 'package:fhotel_1/views/checkout/vn_pay_view.dart';
import 'package:fhotel_1/views/tabbar_booking_and_service/list_reservation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_export.dart';
import '../../presenters/list_reservation_presenter.dart';

// ignore_for_file: must be_ immutable
class CheckoutScreen extends StatefulWidget {
  final Reservation reservation;

  CheckoutScreen({super.key, required this.reservation});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen>
    with WidgetsBindingObserver
    implements ListReservationView, VnPayView {
  late AppLifecycleState _notification;

  TextEditingController listmasteroneController = TextEditingController();
  int? numberOfDays;
  String? checkInDate;
  String? checkOutDate;
  String selectedPaymentMethod =
      "Vui lòng chọn phương thức thanh toán"; // Default text
  String selectedPaymentMethodId = ""; // Default text
  late ListReservationPresenter _presenter;
  late VnPayPresenter _vnPresenter;
  String? _error;
  bool _isLoading = false;
  Reservation? _reservation;
  String? vnpaylink;

  @override
  void initState() {
    super.initState();
    _presenter = ListReservationPresenter(this, ListReservationRepo());
    _presenter.getReservationById(widget.reservation.reservationId.toString());
    _vnPresenter = VnPayPresenter(this);
    _calculateDates();
    WidgetsBinding.instance.addObserver(this);
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

  void _showPaymentMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Phương thức thanh toán",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 20.h),
              ListTile(
                leading: CustomImageView(
                  imagePath: ImageConstant.imgImg,
                  // Replace with your payment method image
                  height: 40.h,
                  width: 40.h,
                  radius: BorderRadius.circular(14.h),
                ),
                title: Text("VNPay"),
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = "VNPay"; // Update the state
                    selectedPaymentMethodId =
                        '03c20593-9817-4cda-982f-7c8e7ee162e8';
                    _presenter.updateReservation(
                        (widget.reservation.reservationId).toString(),
                        (widget.reservation.numberOfRooms ?? 0),
                        (widget.reservation.roomTypeId).toString(),
                        (widget.reservation.checkInDate).toString(),
                        (widget.reservation.checkOutDate).toString(),
                        (widget.reservation.totalAmount ?? 0),
                        (widget.reservation.customerId).toString(),
                        (widget.reservation.paymentStatus).toString(),
                        'Pending',
                        '03c20593-9817-4cda-982f-7c8e7ee162e8',
                        (widget.reservation.createdDate).toString());
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text("Thanh toán tại khách sạn"),
                onTap: () {
                  setState(() {
                    selectedPaymentMethod = "Thanh toán tại khách sạn"; // Update the state
                    selectedPaymentMethodId =
                        '1dfab560-eef5-4297-9c26-03c3364f10e6';
                    _presenter.updateReservation(
                        (widget.reservation.reservationId).toString(),
                        (widget.reservation.numberOfRooms ?? 0),
                        (widget.reservation.roomTypeId).toString(),
                        (widget.reservation.checkInDate).toString(),
                        (widget.reservation.checkOutDate).toString(),
                        (widget.reservation.totalAmount ?? 0),
                        (widget.reservation.customerId).toString(),
                        (widget.reservation.paymentStatus).toString(),
                        'Pending',
                        '1dfab560-eef5-4297-9c26-03c3364f10e6',
                        (widget.reservation.createdDate).toString());
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _showPaymentSuccessDialog(context);
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
      case AppLifecycleState.hidden:
        print("app in hidden");
      // TODO: Handle this case.
    }
  }

  void _showPaymentSuccessDialog(BuildContext context) async {
    await _presenter
        .getReservationById(widget.reservation.reservationId.toString());
    if (_reservation?.paymentStatus == 'Paid') {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        body: const Center(
          child: Text(
            'Thanh toán thành công !!',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        btnOkOnPress: () {
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        },
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.error,
        body: const Center(
          child: Text(
            'Thanh toán thất bại,\nVui lòng thử lại !!',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        btnOkColor: Colors.red,
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                        // _buildAdditional(context),
                        // SizedBox(height: 8.h),
                        _buildPaymentMethod(context),
                        SizedBox(height: 8.h),
                        _buildAdditionalone(context),
                        SizedBox(height: 8.h),
                        _buildColumntitlecont(context),
                        SizedBox(height: 8.h),
                        _buildColumntitlepric(context),
                        SizedBox(height: 8.h),
                        _buildRowxablc(context)
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
          // widget.reservation.reservationStatus != 'Pending'
          //     ? CustomElevatedButton(
          //         height: 28.h,
          //         width: 126.h,
          //         text: "Đặt thành công",
          //         buttonStyle: CustomButtonStyles.fillGreen,
          //         buttonTextStyle: CustomTextStyles.bodyMediumTeal800,
          //       )
          //     : CustomElevatedButton(
          //         height: 28.h,
          //         width: 94.h,
          //         text: "Đang xử lý",
          //         buttonStyle: CustomButtonStyles.fillYellow,
          //         buttonTextStyle:
          //             CustomTextStyles.bodyMediumSecondaryContainer,
          //       ),
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
                      (_reservation?.roomType?.hotel?.hotelName != null)
                          ? Expanded(
                              child: Text(
                                (_reservation?.roomType?.hotel?.hotelName)
                                    .toString(),
                                style: CustomTextStyles.bodyMediumwhiteA700,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : Expanded(
                              child: Skeleton(
                                width: 100.h,
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
                                  : Skeleton(width: 50.h)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20.h),
                      Text(
                        "x " + (widget.reservation.numberOfRooms).toString(),
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
                              (_reservation?.roomType?.type?.typeName != null)
                                  ? Text(
                                      (_reservation?.roomType?.type?.typeName)
                                          .toString(),
                                      style: theme.textTheme.titleSmall,
                                    )
                                  : Skeleton(width: 100.h)
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
                                checkInDate.toString(),
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
                                checkOutDate.toString(),
                                style: theme.textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 22.h),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPaymentMethodBottomSheet(context);
      },
      child: Container(
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
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowRightGray600,
                    height: 24.h,
                    width: 24.h,
                  )
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
                      borderRadius: BorderRadius.circular(12.h),
                      border: Border.all(
                        color: appTheme.black900.withOpacity(0.05),
                        width: 1.h,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgImg,
                          height: 40.h,
                          width: double.maxFinite,
                          radius: BorderRadius.circular(14.h),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Text(
                      selectedPaymentMethod, // Use the selected payment method
                      style: theme.textTheme.titleSmall,
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
                          (_reservation?.customer?.name).toString(),
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
                datavalueone: (_reservation?.customer?.name).toString()),
          ),
          SizedBox(
            width: double.maxFinite,
            child: _buildWrapperFive(
              context,
              labelguestTwo: "Sô điện thoại",
              datavalueone: (_reservation?.customer?.phoneNumber).toString(),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: _buildWrapperFive(
              context,
              labelguestTwo: "Email",
              datavalueone: (_reservation?.customer?.email).toString(),
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
                labelguestTwo: (widget.reservation.numberOfRooms).toString() +
                    " Phòng " +
                    (_reservation?.roomType?.hotel?.hotelName).toString(),
                datavalueone: NumberFormat('#,###', 'en_US')
                        .format(widget.reservation.totalAmount) +
                    " ₫"),
          ),
          // SizedBox(
          //   width: double.maxFinite,
          //   child: Divider(),
          // ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.maxFinite,
            child: _buildWrapperFive(context,
                labelguestTwo: "Tổng cộng",
                datavalueone: NumberFormat('#,###', 'en_US')
                        .format(widget.reservation.totalAmount) +
                    " ₫"),
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

  Widget _buildXabIc(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        onPressed: () async {
          await _presenter.updateReservation(
              (widget.reservation.reservationId).toString(),
              (widget.reservation.numberOfRooms ?? 0),
              (widget.reservation.roomTypeId).toString(),
              (widget.reservation.checkInDate).toString(),
              (widget.reservation.checkOutDate).toString(),
              (widget.reservation.totalAmount ?? 0),
              (widget.reservation.customerId).toString(),
              'Not Paid',
              'Cancelled',
              selectedPaymentMethodId,
              (widget.reservation.createdDate).toString());
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
        },
        height: 40.h,
        text: "Hủy đặt phòng",
        buttonStyle: CustomButtonStyles.outlineBlue,
        buttonTextStyle: CustomTextStyles.bodyLargeBlue,
      ),
    );
  }

  Widget _buildPdng(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        onPressed: () async {
          await _presenter.getReservationById(
              (widget.reservation.reservationId).toString());
          if (_reservation?.paymentMethodId ==
              '1dfab560-eef5-4297-9c26-03c3364f10e6') {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.success,
              body: const Center(
                child: Text(
                  'Bạn đã hoàn tất đặt phòng !!',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              btnOkOnPress: () {
                Navigator.pushReplacementNamed(context, AppRoutes.homePage);
              },
            ).show();
          }
          if (_reservation?.paymentMethodId ==
              '03c20593-9817-4cda-982f-7c8e7ee162e8') {
            await _vnPresenter.PaymentMethodVNPAY(
                widget.reservation.reservationId.toString());
            launch(vnpaylink.toString());
          } else{
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              body: const Center(
                child: Text(
                  'Vui lòng chọn phương thức thanh toán !!',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              btnOkColor: Colors.red,
              btnOkOnPress: () {
              },
            ).show();
          }
        },
        text: "Thanh toán",
        buttonStyle: CustomButtonStyles.fillBlue,
        buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      ),
    );
  }

  Widget _buildRowxablc(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 8.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          _buildXabIc(context),
          SizedBox(width: 8.h),
          _buildPdng(context)
        ],
      ),
    );
  }

  @override
  void onGetReservationSuccess(Reservation reservation) {
    // TODO: implement onGetReservationSuccess
    setState(() {
      _reservation = reservation;
    });
  }

  @override
  void onGetReservationsError(String error) {
    setState(() {
      _error = error;
    });
  }

  @override
  void onGetReservationsSuccess(List<Reservation> reservations) {
    // TODO: implement onGetReservationsSuccess
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
  void onPaymentError(String error) {
    // TODO: implement onPaymentError
  }

  @override
  void onPaymentSuccess(String link) {
    // TODO: implement onPaymentSuccess
    setState(() {
      vnpaylink = link;
    });
  }
}
