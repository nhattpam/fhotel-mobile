import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/views/my_booking_check_in/my_booking_checkin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;

import '../../core/app_export.dart';

// ignore_for_file: must be_ immutable
class MyBookingDetailsScreen extends StatefulWidget {
  final Reservation reservation;

  MyBookingDetailsScreen({super.key, required this.reservation});

  @override
  MyBookingDetailsScreenState createState() => MyBookingDetailsScreenState();
}

class MyBookingDetailsScreenState extends State<MyBookingDetailsScreen> {
  TextEditingController listmasteroneController = TextEditingController();
  int? numberOfDays;
  String? checkInDate;
  String? checkOutDate;

  @override
  void initState() {
    super.initState();
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
                        _buildAdditional(context),
                        SizedBox(height: 8.h),
                        _buildPaymentmethod(context),
                        SizedBox(height: 8.h),
                        _buildAdditionalone(context),
                        SizedBox(height: 8.h),
                        _buildColumntitlecont(context),
                        SizedBox(height: 8.h),
                        _buildColumntitlepric(context),
                        SizedBox(height: 8.h),
                        (widget.reservation.reservationStatus == 'Pending')
                        ? SizedBox()
                        : _buildColumnsave(context)
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
          widget.reservation.reservationStatus != 'Pending'
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
                  buttonTextStyle:
                      CustomTextStyles.bodyMediumSecondaryContainer,
                ),
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
                              Text(
                               "Kích thước phòng: ${widget.reservation.roomType?.roomSize} m2",
                                style: theme.textTheme.bodySmall,
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
                        imagePath: ImageConstant.imgIconWrapper11,
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
                                "Khách",
                                style: theme.textTheme.bodyMedium,
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "2 người lớn, 1 trẻ em",
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
                                "Loại giường",
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
                SizedBox(height: 6.h),
                // SizedBox(
                //   width: double.maxFinite,
                //   child: Divider(),
                // ),
                // SizedBox(
                //   width: double.maxFinite,
                //   child: _buildWrapperTwo(
                //     context,
                //     valuebooking: "Miễn phí hủy phòng",
                //   ),
                // ),
                // SizedBox(
                //   width: double.maxFinite,
                //   child: _buildWrapperTwo(
                //     context,
                //     valuebooking: "Áp dụng chính sách đổi lịch",
                //   ),
                // ),
                // SizedBox(height: 8.h),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 16.h),
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 16.h,
                //     vertical: 8.h,
                //   ),
                //   decoration: BoxDecoration(
                //     color: appTheme.blue50,
                //     borderRadius: BorderRadiusStyle.roundedBorder8,
                //   ),
                //   width: double.maxFinite,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "Mã đặt chỗ",
                //               style: theme.textTheme.bodyMedium,
                //             ),
                //             SizedBox(height: 4.h),
                //             Text(
                //               "FD8UH6",
                //               style: theme.textTheme.titleSmall,
                //             )
                //           ],
                //         ),
                //       ),
                //       CustomImageView(
                //         color: Colors.blueAccent,
                //         imagePath: ImageConstant.imgIconWrapper20,
                //         height: 24.h,
                //         width: 24.h,
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(height: 16.h),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAdditional(BuildContext context) {
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
            "Chính sách khách sạn và phòng",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          Text(
            "Áp dụng chính sách hủy phòng \nMiễn phí hủy trước 26-thg 5-2022 14:00. Nếu hủy hoặc sửa đổi sau 26-thg 5-2022 14:01, phí hủy đặt phòng sẽ được tính.",
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              height: 1.50,
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
                // CustomImageView(
                //   imagePath: ImageConstant.imgArrowRightGray600,
                //   height: 24.h,
                //   width: 24.h,
                // )
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
                      CustomImageView(
                        imagePath: ImageConstant.imgImg,
                        height: 40.h,
                        width: double.maxFinite,
                        radius: BorderRadius.circular(
                          14.h,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Text(
                    "VIB 006969",
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
            child: _buildWrapperFive(
              context,
              labelguestTwo: "Họ tên",
              datavalueone:
                  (widget.reservation.customer?.name).toString()
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: _buildWrapperFive(
              context,
              labelguestTwo: "Sô điện thoại",
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
                labelguestTwo: "${widget.reservation.numberOfRooms} Phòng ${widget.reservation.roomType?.hotel?.hotelName}",
                datavalueone: "${NumberFormat('#,###', 'en_US')
                        .format(widget.reservation.totalAmount)} ₫"),
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
                datavalueone: "${NumberFormat('#,###', 'en_US')
                        .format(widget.reservation.totalAmount)} ₫"),
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
          CustomElevatedButton(
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        MyBookingCheckin(reservation: widget.reservation)),
              );
            },
            text: "Check-in",
            margin: EdgeInsets.only(bottom: 12.h),
            buttonStyle: CustomButtonStyles.fillBlue,
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
}
