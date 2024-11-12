import 'package:fhotel_1/data/models/order.dart';
import 'package:fhotel_1/presenters/get_order_detail_presenter.dart';
import 'package:fhotel_1/presenters/list_order_presenter.dart';
import 'package:fhotel_1/views/my_refund/my_refund_widget.dart';
import 'package:fhotel_1/views/my_service/list_order_view.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../core/app_export.dart';
import '../../data/models/order_detail.dart';
import '../my_service/get_order_detail_view.dart';

class MyRefund extends StatefulWidget {
  const MyRefund({Key? key})
      : super(
    key: key,
  );

  @override
  MyRefundState createState() => MyRefundState();
}

class MyRefundState extends State<MyRefund>
    with AutomaticKeepAliveClientMixin<MyRefund>
    implements ListOrderView, GetOrderDetailView {
  @override
  bool get wantKeepAlive => true;

  List<Order> _orders = [];
  List<OrderDetail> _ordersDetails = [];
  late ListOrderPresenter _presenter;
  late GetOrderDetailPresenter _orderDetailPresenter;

  @override
  void initState() {
    super.initState();
    _presenter = ListOrderPresenter(this);
    _presenter.getOrderByCustomerlId();
    _orderDetailPresenter = GetOrderDetailPresenter(this);
    _orderDetailPresenter.getListOrderDetailByCustomerId();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 30.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_buildColumnfoodone(context)],
          ),
        ),
      ),
    );
  }

  Widget _buildColumnfoodone(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: GroupedListView<OrderDetail, String>(
                shrinkWrap: true,
                elements: _ordersDetails..sort((a, b) => (a.order?.orderedDate.toString())!.compareTo((b.order?.orderedDate).toString())),
                groupBy: (orders) {
                  DateTime parsedDate =
                  DateTime.parse((orders.order?.orderedDate).toString());
                  return DateFormat('yyyy-MM-dd').format(parsedDate);
                },
                // Group by createDate
                groupSeparatorBuilder: (String groupByValue) {
                  // Parse the date string and format it as dd/MM/yyyy
                  DateTime parsedDate = DateTime.parse(groupByValue);
                  String formattedDate =
                  DateFormat('dd/MM/yyyy').format(parsedDate);

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      formattedDate, // Display the formatted date
                      style: theme.textTheme.titleMedium,
                    ),
                  );
                },
                itemBuilder: (context, OrderDetail orderDetails) {
                  return MyRefundWidget(order: orderDetails.order ?? Order());
                },
                separator: SizedBox(height: 12.h),
                // Add spacing between items
                order: GroupedListOrder.DESC, // Adjust based on your desired order
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void onGetOrdersError(String error) {
    // TODO: implement onGetOrdersError
  }

  @override
  void onGetOrdersSuccess(List<Order> orders) {
    setState(() {
      _orders = orders;
    });
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  void onGetOrderDetailsSuccess(List<OrderDetail> orders) {
    // TODO: implement onGetOrderDetailsSuccess
    setState(() {
      _ordersDetails = orders;
      _ordersDetails.removeWhere((orderDetail) => orderDetail.services?.serviceName != 'Hoàn tiền');

    });
  }

  @override
  void showOrderDetail(OrderDetail orderDetails) {
    // TODO: implement showOrderDetail
  }
}
