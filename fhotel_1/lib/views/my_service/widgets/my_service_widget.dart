import 'package:fhotel_1/data/models/order.dart';
import 'package:fhotel_1/data/models/order_detail.dart';
import 'package:fhotel_1/presenters/get_order_detail_presenter.dart';
import 'package:fhotel_1/views/my_service/get_order_detail_view.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class MyServiceWidget extends StatefulWidget {
  final Order order;

  MyServiceWidget({super.key, required this.order});

  @override
  MyServiceWidgetState createState() => MyServiceWidgetState();
}

class MyServiceWidgetState extends State<MyServiceWidget>
    implements GetOrderDetailView {
  late GetOrderDetailPresenter _presenter;
  OrderDetail? _orderDetail;
  String? _error;
  bool _isLoading = false;
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    _presenter = GetOrderDetailPresenter(this); // Initialize the presenter
    _presenter.getOrderDetailByOrderId(
        widget.order.orderId.toString()); // Fetch customer data
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Text(
                  (_orderDetail?.services?.serviceType?.serviceTypeName)
                      .toString(),
                  style: CustomTextStyles.titleSmallBlue,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.h),
                  child: Text(
                    widget.order.orderStatus.toString(),
                    style: CustomTextStyles.titleMediumGreenA700,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Container(
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
                            Text(
                              (_orderDetail?.services?.serviceName).toString(),
                              style: CustomTextStyles.titleSmallGray600,
                            ),
                            // Text(
                            //   "#162432",
                            //   style: CustomTextStyles.bodyLargeGray600.copyWith(
                            //     decoration: TextDecoration.underline,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Text(
                              "\$35.25",
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
                            Padding(
                              padding: EdgeInsets.only(left: 12.h),
                              child: Text(
                                // "${DateFormat('HH:mm').format(DateTime.parse((_orderDetail?.order?.orderedDate).toString()))}, Ngày ${DateFormat('dd-MM-yyyy').format(DateTime.parse((_orderDetail?.order?.orderedDate).toString()))}",
                                "29 Jan, 12:30".toUpperCase(),
                                style: CustomTextStyles.bodyLargeGray600,
                              ),
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
                            Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: Text(
                                (_orderDetail?.quantity).toString(),
                                style: CustomTextStyles.bodyMediumGray600,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // SizedBox(height: 24.h),
          // SizedBox(
          //   width: double.maxFinite,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       CustomOutlinedButton(
          //         height: 38.h,
          //         width: 138.h,
          //         text: "Rate",
          //         buttonStyle: CustomButtonStyles.outlineBlue,
          //         buttonTextStyle: CustomTextStyles.bodyLargeBlue,
          //       ),
          //       CustomElevatedButton(
          //         height: 38.h,
          //         width: 138.h,
          //         text: "Re-Order",
          //         buttonStyle: CustomButtonStyles.fillBlue,
          //         buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
          //       )
          //     ],
          //   ),
          // )
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
