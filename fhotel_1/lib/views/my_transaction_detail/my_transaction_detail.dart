import 'package:fhotel_1/data/models/transaction.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class MyTransactionDetail extends StatefulWidget {
  final Transaction transaction;

  MyTransactionDetail({super.key, required this.transaction});

  @override
  MyTransactionDetailState createState() => MyTransactionDetailState();
}

class MyTransactionDetailState extends State<MyTransactionDetail> {
  int quantity = 1;

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
              _buildColumntitlecont(context),
              SizedBox(height: 16.h),
            ],
          ),
        ),
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
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Mã đặt phòng",
                  datavalueone: (widget.transaction.bill?.reservation?.code).toString(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Số lượng phòng",
                  datavalueone: (widget.transaction.bill?.reservation?.numberOfRooms).toString(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Nhận phòng",
                  datavalueone: "14:00 chiều, ${DateFormat('dd/MM/yyyy').format(DateTime.parse((widget.transaction.bill?.reservation?.checkInDate).toString()))}",
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Trả phòng",
                  datavalueone: "Trước 12:00 trưa, ${DateFormat('dd/MM/yyyy').format(DateTime.parse((widget.transaction.bill?.reservation?.checkOutDate).toString()))}",
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(context,
                    labelguestTwo: "Họ tên",
                    datavalueone: (widget.transaction.bill?.reservation?.customer?.name).toString()),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Số điện thoại",
                  datavalueone: (widget.transaction.bill?.reservation?.customer?.phoneNumber).toString(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Email",
                  datavalueone: (widget.transaction.bill?.reservation?.customer?.email).toString(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Số tài khoản ngân hàng",
                  datavalueone: (widget.transaction?.wallet?.bankAccountNumber).toString(),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Thời gian nhận tiền",
                  datavalueone: DateFormat('dd/MM/yyyy').format(DateTime.parse((widget.transaction.transactionDate).toString())),
                ),
              ),
              SizedBox(
                height: 100,
                width: double.maxFinite,
                child: Container(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                            "Nội dung:",
                            maxLines: 5,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                      ),
                      Expanded(
                        child: Text(
                          (widget.transaction.description).toString(),
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: _buildWrapperFive(
                  context,
                  labelguestTwo: "Tổng tiền",
                  datavalueone: "${NumberFormat('#,###', 'en_US').format(widget.transaction.amount)} ₫",
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
}
