import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/order.dart';
import 'package:fhotel_1/data/models/order_detail.dart';
import 'package:fhotel_1/presenters/get_order_detail_presenter.dart';
import 'package:fhotel_1/presenters/user_profile_presenter.dart';
import 'package:fhotel_1/views/user_profile/user_profile_view.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/user.dart';
import '../../data/models/wallet.dart';
import '../my_service/get_order_detail_view.dart';

class MyRefundDetail extends StatefulWidget {
  final Order order;

  MyRefundDetail({super.key, required this.order});

  @override
  MyRefundDetailState createState() => MyRefundDetailState();
}

class MyRefundDetailState extends State<MyRefundDetail>
    implements GetOrderDetailView, UserProfileView {
  int quantity = 1;

  late GetOrderDetailPresenter _presenter;
  OrderDetail? _orderDetail;
  User? _customer;
  Wallet? _wallet;
  String? _error;
  bool _isLoading = false;
  late UserProfilePresenter _userProfilePresenter;

  @override
  void initState() {
    super.initState();
    _presenter = GetOrderDetailPresenter(this); // Initialize the presenter
    _presenter.getOrderDetailByOrderId(
        widget.order.orderId.toString()); // Fetch customer data
    _userProfilePresenter = UserProfilePresenter(this); // Initialize the presenter
    _userProfilePresenter.getCustomerById(); // Fetch customer data
    print("This is"+ (widget.order.reservation).toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
              children: [_buildscrollview(context)]),
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
              _buildColumntitlecont(context),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingImage(BuildContext context) {
    return (_orderDetail?.services?.image) != null && (_orderDetail?.services?.image) != 'string'
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
        children: [
          Text(
            "Thông tin chi tiết",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: double.maxFinite,
              //   child: _buildWrapperFive(
              //     context,
              //     labelguestTwo: "Khách sạn",
              //     datavalueone: (widget.order.reservation?.roomType?.hotel?.hotelName).toString(),
              //   ),
              // ),
              // SizedBox(
              //   width: double.maxFinite,
              //   child: _buildWrapperFive(
              //     context,
              //     labelguestTwo: "Loại phòng",
              //     datavalueone: (widget.order.reservation?.roomType?.type?.typeName).toString(),
              //   ),
              // ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Số lượng phòng",
                  datavalueone: (widget.order.reservation?.numberOfRooms).toString(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Nhận phòng",
                  datavalueone: "14:00 chiều, ${DateFormat('dd/MM/yyyy').format(DateTime.parse((widget.order.reservation?.checkInDate).toString()))}",
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Trả phòng",
                  datavalueone: "Trước 12:00 trưa, ${DateFormat('dd/MM/yyyy').format(DateTime.parse((widget.order.reservation?.checkOutDate).toString()))}",
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(context,
                    labelguestTwo: "Họ tên",
                    datavalueone: (_customer?.name).toString()),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Số điện thoại",
                  datavalueone: (_customer?.phoneNumber).toString(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Email",
                  datavalueone: (_customer?.email).toString(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Số tài khoản ngân hàng",
                  datavalueone: (_wallet?.bankAccountNumber).toString(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Tổng tiền",
                  datavalueone: "${NumberFormat('#,###', 'en_US').format(widget.order.totalAmount)} ₫",
                ),
              )
            ],
          ),
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

  @override
  void onGetOrderDetailsSuccess(List<OrderDetail> orders) {
    // TODO: implement onGetOrderDetailsSuccess
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
  void showValidationError(String field, String message) {
    // TODO: implement showValidationError
  }
}
