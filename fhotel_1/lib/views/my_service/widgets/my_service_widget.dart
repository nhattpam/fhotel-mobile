import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/order.dart';
import 'package:fhotel_1/data/models/order_detail.dart';
import 'package:fhotel_1/presenters/get_order_detail_presenter.dart';
import 'package:fhotel_1/views/my_service/get_order_detail_view.dart';
import 'package:fhotel_1/views/my_service_detail/my_service_detail.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class MyServiceWidget extends StatefulWidget {
  final Order order;

  MyServiceWidget({super.key, required this.order});

  @override
  MyServiceWidgetState createState() => MyServiceWidgetState();
}

class MyServiceWidgetState extends State<MyServiceWidget> implements GetOrderDetailView {
  late GetOrderDetailPresenter _presenter;
  OrderDetail? _orderDetail;
  String? _error;
  bool _isLoading = false;
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    _presenter = GetOrderDetailPresenter(this); // Initialize the presenter
    _presenter.getOrderDetailByOrderId(widget.order.orderId.toString()); // Fetch customer data
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
                  children: [
                    Text(
                      "Trạng thái ",
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: appTheme.black900,
                      ),
                    ),
                    (widget.order.orderStatus != null)
                        ?  Text(
                          "${widget.order.orderStatus}",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: appTheme.black900,
                          ).merge(
                            TextStyle(
                              color: widget.order.orderStatus == 'Pending'
                                  ? Colors.yellow
                                  : widget.order.orderStatus == 'Cancel'
                                  ? Colors.red
                                  : widget.order.orderStatus == 'Done'
                                  ? Colors.green
                                  : Colors.black, // Default color if none match
                            ),
                          ),
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
                    (_orderDetail?.services?.image) != null
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
                              children: [
                                Text(
                                  "Giá: \$35.25",
                                  style: CustomTextStyles.titleSmallGray600,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 14.h),
                                  child: VerticalDivider(
                                    width: 1.h,
                                    thickness: 1.h,
                                    color: appTheme.blueGray100,
                                  ),
                                ),
                                (widget.order.orderedDate != null)

                               ? Padding(
                                  padding: EdgeInsets.only(left: 12.h),
                                  child: Text(
                                    "${DateFormat('HH:mm').format(DateTime.parse((widget.order.orderedDate).toString()))}, Ngày ${DateFormat('dd-MM').format(DateTime.parse((widget.order.orderedDate).toString()))}",
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
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 4.h,
                                    width: 4.h,
                                    margin: EdgeInsets.only(
                                      left: 8.h,
                                      top: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: appTheme.gray10002,
                                      borderRadius: BorderRadius.circular(
                                        2.h,
                                      ),
                                    ),
                                  ),
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
                    CustomOutlinedButton(
                      height: 38.h,
                      width: 138.h,
                      text: "Hủy đặt",
                      buttonStyle: CustomButtonStyles.outlineBlue,
                      buttonTextStyle: CustomTextStyles.bodyLargeBlue,
                    ),
                    CustomElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyServiceDetail(order: widget.order)),
                        );
                      },
                      height: 38.h,
                      width: 138.h,
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
}
