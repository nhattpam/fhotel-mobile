import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/order.dart';
import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/models/service.dart';
import 'package:fhotel_1/data/repository/list_reservation_repo.dart';
import 'package:fhotel_1/presenters/list_reservation_presenter.dart';
import 'package:fhotel_1/presenters/order_detail_presenter.dart';
import 'package:fhotel_1/presenters/order_presenter.dart';
import 'package:fhotel_1/views/choose_room_detail/create_reservation_view.dart';
import 'package:fhotel_1/views/tabbar_booking_and_service/list_reservation_view.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Services service;

  ServiceDetailScreen({super.key, required this.service});

  @override
  ServiceDetailScreenState createState() => ServiceDetailScreenState();
}

class ServiceDetailScreenState extends State<ServiceDetailScreen>
    implements ListReservationView, CreateReservationView {
  int quantity = 1;
  TextEditingController _quantityController = TextEditingController();
  late ListReservationPresenter _presenter;
  late OrderPresenter _orderPresenter;
  late OrderDetailPresenter _orderDetailPresenter;
  List<Reservation> _reservation = [];
  Reservation? selectedReservation;
  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = ListReservationPresenter(
        this, ListReservationRepo()); // Initialize the presenter
    _presenter.getListReservationByCustomerId(); // Fetch customer data
    _orderPresenter = OrderPresenter(this); // Initialize the presenter
    _orderDetailPresenter = OrderDetailPresenter(this);
    _quantityController.text = quantity.toString();
  }

  void _incrementRooms() {
    setState(() {
      quantity++;
      _quantityController.text = quantity.toString();
    });
  }

  void _decrementRooms() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        _quantityController.text = quantity.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
              children: [_buildscrollview(context), _buildAddcart(context)]),
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
          text: "Chi tiết",
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
                // SizedBox(width: 8.h),
                Padding(
                  padding: EdgeInsets.only(left: 17.h),
                  child: const Text(
                    "|",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                AppbarIconbutton(
                  imagePath: ImageConstant.imgDivider,
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 4.h,
                  ),
                ),
              ],
            ),
          )
        ],
        styleType: Style.bgFill);
  }

  Widget _buildscrollview(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 22.h),
              _buildHeadingImage(context),
              SizedBox(height: 22.h),
              Text(
                "Dịch vụ: ${widget.service.serviceName}",
                style: CustomTextStyles.titleSmallGray600,
              ),
              SizedBox(height: 20.h),
              Text(
                "Miêu tả: ${widget.service.description}",
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium!.copyWith(
                  height: 1.71,
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingImage(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 200.h, // Set the height explicitly so the Stack has enough space
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Stack(
        children: [
          // Background Image
          widget.service.image != null && widget.service.image != 'string'
              ? Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Image.network(
                    widget.service.image.toString(),
                    fit: BoxFit.contain,
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Skeleton(
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildAddcart(BuildContext context) {
    double price = (quantity * ((widget.service.price) as num)).toDouble();
    return Container(
      height: 175.h,
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
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Chọn Phòng muốn đặt dịch vụ",
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 103, // Adjust width as needed
                        child: DropdownButton<Reservation>(
                          value: selectedReservation,
                          // Define this variable to store the selected reservation
                          onChanged: (Reservation? newValue) {
                            setState(() {
                              selectedReservation = newValue;
                            });
                          },
                          items: _reservation
                              .where((reservation) =>
                                  reservation.reservationStatus == 'CheckIn')
                              .map<DropdownMenuItem<Reservation>>(
                                  (Reservation reservation) {
                            return DropdownMenuItem<Reservation>(
                              value: reservation,
                              child: Text(
                                "Đặt chỗ ",
                                // reservation.reservationId.toString(), // Replace with the appropriate display property
                                style: theme.textTheme.titleSmall,
                              ),
                            );
                          }).toList(),
                          isDense: true,
                          underline: SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Số lượng",
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decrementRooms,
                      ),
                      SizedBox(
                        width: quantity > 9 ? 20 : 10,
                        child: TextFormField(
                          controller: _quantityController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.titleSmall,
                          onFieldSubmitted: (value) {
                            int newQuantity = int.tryParse(value) ?? quantity;
                            if (newQuantity < 1) newQuantity = 1;

                            setState(() {
                              quantity = newQuantity;
                              _quantityController.text = quantity.toString();
                            });
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _incrementRooms,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Tổng giá tiền",
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "${NumberFormat('#,###', 'en_US').format(price)} ₫",
                          style: CustomTextStyles.titleSmallBlue,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 4.h,
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
        if (selectedReservation == null) {
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.error,
            body: const Center(
              child: Text(
                'Vui lòng chọn phòng để đặt dịch vụ!!!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            btnCancelOnPress: () {
              // Navigator.pop(context);
            },
          ).show();
        }
        // print((selectedReservation?.reservationId).toString());
        Order newOrder = await _orderPresenter
            .createOrder((selectedReservation?.reservationId).toString());
        await _orderDetailPresenter.createOrderDetail(
            (newOrder.orderId).toString(),
            (widget.service.serviceId).toString(),
            quantity);
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: const Center(
            child: Text(
              'Đặt thành công!!!',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          btnOkOnPress: () {
            Navigator.pop(context);
          },
        ).show();
      },
      text: "Gọi món",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
    );
  }

  /// common widget
  Widget _buildcolumnchicken(
    BuildContext context, {
    required String iconbutton,
    required String chickenone,
  }) {
    return Column(
      children: [
        CustomIconButton(
          height: 50.h,
          width: 50.h,
          padding: EdgeInsets.all(12.h),
          child: CustomImageView(
            imagePath: iconbutton,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          chickenone,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.gray70001,
          ),
        )
      ],
    );
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void onGetReservationsError(String error) {
    // TODO: implement onGetReservationsError
  }

  @override
  void onGetReservationsSuccess(List<Reservation> reservations) {
    setState(() {
      _reservation = reservations;
    });
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  void onGetReservationSuccess(Reservation reservation) {
    // TODO: implement onGetReservationSuccess
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
}
