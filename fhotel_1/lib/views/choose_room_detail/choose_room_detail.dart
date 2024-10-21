import 'package:fhotel_1/data/models/type.dart';
import 'package:fhotel_1/presenters/create_reservation.dart';
import 'package:fhotel_1/views/home_hotel_region_empty/widgets/carouselunit_item_widget.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/room_image.dart';
import '../../data/models/room_types.dart';
import '../../data/repository/list_room_type_repo.dart';
import '../../presenters/list_room_type_presenter.dart';
import '../choose_room/choose_room_view.dart';
import 'create_reservation_view.dart';

class ChooseRoomRoomDetailScreen extends StatefulWidget {
  final String roomTypeId;
  final String checkInDate;
  final String checkOutDate;
  final int numberOfRooms;
  const ChooseRoomRoomDetailScreen({super.key, required this.roomTypeId, required this.checkInDate, required this.checkOutDate, required this.numberOfRooms});

  @override
  ChooseRoomRoomDetailScreenState createState() =>
      ChooseRoomRoomDetailScreenState();
}

class ChooseRoomRoomDetailScreenState extends State<ChooseRoomRoomDetailScreen> implements ChooseRoomView, CreateReservationView{
  int activeIndex = 0;
  late ListRoomTypePresenter _presenter;
  late CreateReservation _createReservation;
  double? _totalAmount = 0;

  RoomType? _roomType;

  @override
  void initState() {
    super.initState();
    _presenter = ListRoomTypePresenter(this, ListRoomTypeRepo());
    _createReservation = CreateReservation(this);
    _presenter.getRoomTypeById(widget.roomTypeId);
    _calculateTotalAmount();
    }

  Future<void> _calculateTotalAmount() async {
    try {
      // Use await to get the total amount from the async method
      DateFormat inputFormat = DateFormat('dd/MM/yyyy');

      // Parse the date string
      DateTime parsedInDate = inputFormat.parse(widget.checkInDate);
      DateTime parsedOutDate = inputFormat.parse(widget.checkOutDate);

      // Define the desired output format (ISO 8601 format)
      DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

      // Format the parsed date to the desired format
      String isoFormattedInDate = outputFormat.format(parsedInDate);
      String isoFormattedOutDate = outputFormat.format(parsedOutDate);

      double? amount = await _createReservation.createReservationToCalculate(
        isoFormattedInDate,
        isoFormattedOutDate,
        widget.roomTypeId,
        widget.numberOfRooms,
      );
      setState(() {
        _totalAmount = amount; // Update the total amount in the state
      });
    } catch (e) {
      // Handle any errors during the calculation
      print("Error calculating total amount: $e");
      // Optionally notify the user of the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to calculate total amount")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 80.h,
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 76.h),
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: appTheme.gray10001,
                borderRadius: BorderRadiusStyle.customBorderTL16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSheetheader(context),
                  CarouselunitItemWidget(roomTypeId: widget.roomTypeId),
                  Container(
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
                          _roomType?.description.toString() ?? '',
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: appTheme.whiteA700,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   width: 150.h,
                              //   padding: EdgeInsets.symmetric(
                              //     horizontal: 8.h,
                              //     vertical: 4.h,
                              //   ),
                              //   decoration: BoxDecoration(
                              //     color: appTheme.gray100,
                              //     borderRadius: BorderRadiusStyle.roundedBorder8,
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         "Khách sạn",
                              //         style:
                              //         CustomTextStyles.bodySmallOnPrimary10,
                              //       ),
                              //       SizedBox(width: 4.h),
                              //       CustomRatingBar(
                              //         color: Colors.yellow,
                              //         ignoreGestures: true,
                              //         initialRating: 5,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(height: 12.h),
                              Container(
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                width: double.maxFinite,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // CustomImageView(
                                    //   color: appTheme.black900.withOpacity(0.5),
                                    //   imagePath: ImageConstant.imgIconWrapperGray600,
                                    //   height: 24.h,
                                    //   width: 24.h,
                                    // ),
                                    // SizedBox(width: 8.h),
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 286.h,
                                        child: Text(
                                          "Room size:${_roomType?.roomSize.toString() ?? ''}m2",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: appTheme.black900
                                                .withOpacity(0.5),
                                            fontSize: 12,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 16.h),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      color: appTheme.black900.withOpacity(0.5),
                                      imagePath: ImageConstant.imgIconWrapper15,
                                      height: 18.h,
                                      width: 18.h,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Text(
                                          "Tối đa ${_roomType?.type?.maxOccupancy.toString() ?? ''} người",
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 18.h),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      color: appTheme.black900.withOpacity(0.5),
                                      imagePath: ImageConstant.imgIconWrapper16,
                                      height: 18.h,
                                      width: 18.h,
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
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Column(
                  //   children: [
                  //     SizedBox(
                  //       width: double.maxFinite,
                  //       child: _buildSectionOne(
                  //         context,
                  //         titleone: "Tiện nghi chung",
                  //         descriptionOne:
                  //             "Bãi gửi xe\nKhu vực hút thuốc \nTiệc chiêu đãi \nSân thượng/ sân hiên",
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: double.maxFinite,
                  //       child: _buildSectionOne(
                  //         context,
                  //         titleone: "Tiện nghi văn phòng",
                  //         descriptionOne:
                  //             "Phòng hội nghị \nPhòng họp \nDịch vụ văn phòng \nPhòng hội nghị \nMáy tính",
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: double.maxFinite,
                  //       child: _buildSectionOne(
                  //         context,
                  //         titleone: "Tiện nghi công cộng",
                  //         descriptionOne:
                  //             "Tiệm cà phê\nThang máy \nNhà hàng \nKét an toàn",
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: double.maxFinite,
                  //       child: _buildSectionOne(
                  //         context,
                  //         titleone: "Ấm thực",
                  //         descriptionOne:
                  //             "Quầy bar\nQuãy bar bên hồ bơi \nBữa sáng",
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 8.h),
                  Container(
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
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: appTheme.whiteA700,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Text(
                                          "Ngày",
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.checkInDate + "-" + widget.checkOutDate,
                                      style: theme.textTheme.titleSmall,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Text(
                                          "Số phòng",
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      widget.numberOfRooms.toString(),
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildSumsectionat(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumndescripti(BuildContext context) {
    return Container(
      width: 488.h,
      margin: EdgeInsets.only(left: 14.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          children: [
            Text(
              "Đánh giá hàng đầu",
              maxLines: 1,
              textAlign: TextAlign.start,
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.gray10001,
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Khách sạn mới và đẹp, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. Xung...",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          height: 1.50,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Nguyen V.A.",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.h),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.gray10001,
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Khách sạn mới và đẹp, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. Xung ",
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          height: 1.50,
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Tran V.B.",
                        style: theme.textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildSheetheader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 4.h),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 110.h),
              child: Text(
                textAlign: TextAlign.center,
                "Chi tiết phòng",
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
          ),
        ],
      ),
    );
  }

  Widget _buildSumsectionat(BuildContext context) {
    return Container(
      height: 115.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng giá tiền",
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        _totalAmount.toString() + "đ",
                        // _roomType?.basePrice.toString() ?? '',
                        style: theme.textTheme.titleSmall,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(right: 14.h),
            child: Text(
              "Đã bao gồm thuế",
              style: theme.textTheme.bodySmall,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_buildChnphng(context)],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChnphng(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        // Define the input date format
        DateFormat inputFormat = DateFormat('dd/MM/yyyy');

        // Parse the date string
        DateTime parsedInDate = inputFormat.parse(widget.checkInDate);
        DateTime parsedOutDate = inputFormat.parse(widget.checkOutDate);

        // Define the desired output format (ISO 8601 format)
        DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

        // Format the parsed date to the desired format
        String isoFormattedInDate = outputFormat.format(parsedInDate);
        String isoFormattedOutDate = outputFormat.format(parsedOutDate);

       await  _createReservation.createReservation((isoFormattedInDate).toString(), (isoFormattedOutDate).toString(), widget.roomTypeId, widget.numberOfRooms);
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: const Center(
            child: Text(
              'Book success!!!',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          // title: 'Warning',
          // desc:   'This is also Ignored',
          btnOkOnPress: () {
            // Navigator.pushNamed(context, AppRoutes.guestCheckout);
          },
        ).show();
        Navigator.pushNamed(context, AppRoutes.guestCheckout);
      },
      text: "Đặt phòng",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
    );
  }

  Widget _buildSectionOne(
    BuildContext context, {
    required String titleone,
    required String descriptionOne,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14.h),
          Text(
            titleone,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 6.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              border: Border(
                bottom: BorderSide(
                  color: appTheme.blueGray50,
                  width: 1.h,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  descriptionOne,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                    height: 1.50,
                  ),
                ),
                SizedBox(height: 4.h)
              ],
            ),
          )
        ],
      ),
    );
  }
  // Show loading indicator
  @override
  void showLoading() {
    // Show loading indicator (e.g., CircularProgressIndicator)
  }

  @override
  void hideLoading() {
    // Hide loading indicator
  }

  @override
  void showRoomTypes(List<RoomType> roomTypes) {
    // Logic to handle room types if necessary
  }

  @override
  void onGetRoomImageSuccess(List<RoomImage> roomImage) {

  }

  @override
  void onGetRoomTypeSuccess(RoomType roomType) {
    // TODO: implement onGetRoomTypeSuccess
    setState(() {
      _roomType = roomType;
    });
  }

  @override
  void showTypes(List<Types> types) {
    // TODO: implement showTypes
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
  void showValidationError(String field, String message) {
    // TODO: implement showValidationError
  }
  @override
  void onCreateTotalAmountSuccess(double totalAmount) {
    // Ensure async work is completed before calling setState
    // setState(() {
    //   _totalAmount = totalAmount;
    // });
  }

  @override
  void onGetPriceSuccess(List<double?> price) {
    // TODO: implement onGetPriceSuccess
  }

}
