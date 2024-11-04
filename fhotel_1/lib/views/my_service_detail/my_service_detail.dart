import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/order.dart';
import 'package:fhotel_1/data/models/order_detail.dart';
import 'package:fhotel_1/presenters/get_order_detail_presenter.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../my_service/get_order_detail_view.dart';

class MyServiceDetail extends StatefulWidget {
  final Order order;

  MyServiceDetail({super.key, required this.order});

  @override
  MyServiceDetailState createState() => MyServiceDetailState();
}

class MyServiceDetailState extends State<MyServiceDetail>
    implements GetOrderDetailView {
  int quantity = 1;

  late GetOrderDetailPresenter _presenter;
  OrderDetail? _orderDetail;

  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = GetOrderDetailPresenter(this); // Initialize the presenter
    _presenter.getOrderDetailByOrderId(
        widget.order.orderId.toString()); // Fetch customer data
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
              (_orderDetail?.services?.serviceName) != null
              ? Text(
                "Dịch vụ: ${_orderDetail?.services?.serviceName}",
                style: CustomTextStyles.titleSmallGray600,
              )
              : Skeleton(
                width: 150.h,
              ),
              SizedBox(height: 20.h),
              (_orderDetail?.services?.description) != null
              ? Text(
                "Miêu tả: ${_orderDetail?.services?.description}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium!.copyWith(
                  height: 1.71,
                ),
              )
              : Skeleton(
                width: 200.h,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingImage(BuildContext context) {
    return (_orderDetail?.services?.image) != null
        ? Container(
            width: double.maxFinite,
            height: 200.h,
            // Set the height explicitly so the Stack has enough space
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Stack(
              children: [
                // Background Image
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Image.network(
                    (_orderDetail?.services?.image).toString(),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: double.maxFinite,
            height: 200.h,
            // Set the height explicitly so the Stack has enough space
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Stack(
              children: [
                // Background Image
                Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: const Skeleton(
                    width: double.maxFinite,
                    height: double.maxFinite,
                  )
                ),
              ],
            ),
          );
  }

  Widget _buildAddcart(BuildContext context) {
    return Container(
      height: 100.h,
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
                (_orderDetail?.quantity) != null
                    ? Container(
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
                            const Spacer(),
                            SizedBox(
                              width:
                                  40, // Adjust width to keep layout consistent
                              child: Text(
                                (_orderDetail?.quantity).toString(),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
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
                            const Spacer(),
                            const SizedBox(
                                width:
                                    40, // Adjust width to keep layout consistent
                                child: Skeleton(width: 40)),
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
                          "Đơn giá",
                          style: theme.textTheme.titleSmall,
                        ),
                      ),
                      const Spacer(),
                      (_orderDetail?.services?.price) != null
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                // (_orderDetail?.services?.image).toString(),
                                "${NumberFormat('#,###', 'en_US')
                                        .format(_orderDetail?.services?.price)} ₫",
                                style: CustomTextStyles.titleSmallBlue,
                              ),
                            )
                          : const Align(
                              alignment: Alignment.bottomCenter,
                              child: Skeleton(
                                width: 100,
                              ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildChnphng(BuildContext context) {
  //   return CustomElevatedButton(
  //     onPressed: () async {
  //       if(selectedReservation == null){
  //         AwesomeDialog(
  //           context: context,
  //           animType: AnimType.scale,
  //           dialogType: DialogType.error,
  //           body: const Center(
  //             child: Text(
  //               'Vui lòng chọn phòng để đặt dịch vụ!!!',
  //               style: TextStyle(fontStyle: FontStyle.italic),
  //             ),
  //           ),
  //           btnCancelOnPress: () {
  //             // Navigator.pop(context);
  //           },
  //         ).show();
  //       }
  //       // print((selectedReservation?.reservationId).toString());
  //       Order newOrder = await _orderPresenter.createOrder((selectedReservation?.reservationId).toString());
  //       await _orderDetailPresenter.createOrderDetail((newOrder.orderId).toString(), (widget.service.serviceId).toString(), quantity);
  //       AwesomeDialog(
  //         context: context,
  //         animType: AnimType.scale,
  //         dialogType: DialogType.success,
  //         body: const Center(
  //           child: Text(
  //             'Đặt thành công!!!',
  //             style: TextStyle(fontStyle: FontStyle.italic),
  //           ),
  //         ),
  //         btnOkOnPress: () {
  //           Navigator.pop(context);
  //         },
  //       ).show();
  //     },
  //     text: "Gọi món",
  //     buttonStyle: CustomButtonStyles.fillBlue,
  //     buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
  //   );
  // }

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
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  void showOrderDetail(OrderDetail orderDetails) {
    // TODO: implement showOrderDetail
    setState(() {
      _orderDetail = orderDetails;
    });
  }
}
