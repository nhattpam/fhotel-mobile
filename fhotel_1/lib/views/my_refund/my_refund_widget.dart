import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/order.dart';
import 'package:fhotel_1/data/models/order_detail.dart';
import 'package:fhotel_1/presenters/get_order_detail_presenter.dart';
import 'package:fhotel_1/views/my_service/get_order_detail_view.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../presenters/order_presenter.dart';
import '../choose_room_detail/create_reservation_view.dart';
import '../my_refund_detail/my_refund_detail.dart';

class MyRefundWidget extends StatefulWidget {
  final Order order;

  MyRefundWidget({super.key, required this.order});

  @override
  MyRefundWidgetState createState() => MyRefundWidgetState();
}

class MyRefundWidgetState extends State<MyRefundWidget> with AutomaticKeepAliveClientMixin implements GetOrderDetailView, CreateReservationView {
  late GetOrderDetailPresenter _presenter;
  late OrderPresenter _orderPresenter;
  OrderDetail? _orderDetail;
  String? _error;
  bool _isLoading = false;
  SessionManager sessionManager = SessionManager();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _presenter = GetOrderDetailPresenter(this); // Initialize the presenter
    _presenter.getOrderDetailByOrderId(widget.order.orderId.toString()); // Fetch customer data
    _orderPresenter = OrderPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trạng thái ",
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: appTheme.black900,
                  ),
                ),
                (_orderDetail?.order?.orderStatus != null)
                    ?  CustomElevatedButton(
                  height: 28.h,
                  width: _orderDetail?.order?.orderStatus == 'Pending' ? 126.h : 126.h,
                  text: _orderDetail?.order?.orderStatus == 'Cancelled'
                      ? "Đã bị hủy"
                      : _orderDetail?.order?.orderStatus == 'Pending'
                      ? "Đang xử lý"
                      : "Đã hoàn tiền",
                  buttonStyle: _orderDetail?.order?.orderStatus == 'Cancelled'
                      ? CustomButtonStyles.fillRed // Add a red style for "Cancelled"
                      : _orderDetail?.order?.orderStatus == 'Pending'
                      ? CustomButtonStyles.fillYellow
                      : CustomButtonStyles.fillGreen,
                  buttonTextStyle: _orderDetail?.order?.orderStatus == 'Cancelled'
                      ? CustomTextStyles.bodyMediumwhiteA700 // Add an error style for "Cancelled"
                      : _orderDetail?.order?.orderStatus == 'Pending'
                      ? CustomTextStyles.bodyMediumSecondaryContainer
                      : CustomTextStyles.bodyMediumTeal800,
                )
                    :  Skeleton(width: 150.h)

              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                (_orderDetail?.services?.image) != null && (_orderDetail?.services?.image) != 'string'
                    ? Container(
                  height: 60.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                    color: appTheme.blueGray20001,
                    borderRadius: BorderRadius.circular(
                      8.h,
                    ),
                  ),
                  child: Image.network(
                    (_orderDetail?.services?.image).toString(),
                    fit: BoxFit.cover,
                    height: 24.h,
                    width: 24.h,
                  ),
                )
                    : Container(height: 60.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                    color: appTheme.blueGray20001,
                    borderRadius: BorderRadius.circular(
                      8.h,
                    ),
                  ),
                  child: Skeleton(
                    width: 24.h,
                    height: 24.h,
                  ),
                ),
                SizedBox(width: 14.h),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (_orderDetail?.services?.serviceName) != null
                                ? Text(
                              (_orderDetail?.services?.serviceName).toString(),
                              style: CustomTextStyles.titleSmallGray600,
                            )
                                : Skeleton(width: 150.h),
                            (_orderDetail?.quantity) != null
                                ? Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: Text(
                                "x ${_orderDetail?.quantity}",
                                style: CustomTextStyles.bodyMediumGray600,
                              ),
                            )
                                : Padding(
                                padding: EdgeInsets.only(left: 8.h),
                                child: Skeleton(
                                  width: 20.h,
                                )
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Giá: ${NumberFormat('#,###', 'en_US').format(widget.order.totalAmount)} ₫",
                              style: CustomTextStyles.titleSmallGray600,
                            ),
                            (widget.order.orderedDate != null)

                                ? Padding(
                              padding: EdgeInsets.only(left: 12.h),
                              child: Text(
                                DateFormat('HH:mm').format(DateTime.parse((widget.order.orderedDate).toString())),
                                // "${DateFormat('HH:mm').format(DateTime.parse((widget.order.orderedDate).toString()))}, Ngày ${DateFormat('dd-MM').format(DateTime.parse((widget.order.orderedDate).toString()))}",
                                // "29 Jan, 12:30".toUpperCase(),
                                style: CustomTextStyles.bodyLargeGray600,
                              ),
                            )
                                : Padding(
                                padding: EdgeInsets.only(left: 12.h),
                                child: Skeleton(
                                  width: 50.h,
                                )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _orderDetail?.order?.orderStatus != 'Pending'
                    ? Container()
                    : CustomOutlinedButton(
                  onPressed: () async {
                    await _orderPresenter.updateOrder(widget.order);
                    _presenter.getOrderDetailByOrderId((widget.order.orderId).toString());
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.success,
                      body: const Center(
                        child: Text(
                          'Hủy hoàn tiền thành công!!!',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      // title: 'Warning',
                      // desc:   'This is also Ignored',
                      btnOkText: 'Đóng',
                      btnOkOnPress: () {
                      },
                    ).show();
                  },
                  height: 38.h,
                  width: 138.h,
                  text: "Hủy hoàn tiền",
                  buttonStyle: CustomButtonStyles.outlineBlue,
                  buttonTextStyle: CustomTextStyles.bodyLargeBlue,
                ),
                CustomElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              MyRefundDetail(order: widget.order)),
                    );
                  },
                  height: 38.h,
                  width: (_orderDetail?.order?.orderStatus != 'Pending') ? 300.h : 138.h,
                  text: "Xem chi tiết",
                  buttonStyle: CustomButtonStyles.fillBlue,
                  buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(),
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
  void onCreateAvailableRoomSuccess(int availableRoom) {
    // TODO: implement onCreateAvailableRoomSuccess
  }

  @override
  void onGetOrderDetailsSuccess(List<OrderDetail> orders) {
    // TODO: implement onGetOrderDetailsSuccess
  }

  @override
  void onCreateRefundSuccess(String message) {
    // TODO: implement onCreateRefundSuccess
  }
}
