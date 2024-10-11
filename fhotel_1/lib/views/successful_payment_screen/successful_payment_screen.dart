import 'package:fhotel_1/views/my_booking_full_screen/my_booking_full_screen.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class SuccessfulPaymentScreen extends StatelessWidget {
  const SuccessfulPaymentScreen({Key? key})
      : super(
    key: key,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(
            top: 16.h,
            bottom: 4.h,
          ),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 8.h),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    _buildColumntitlepaym(context),
                    SizedBox(height: 14.h),
                    SizedBox(
                      width: double.maxFinite,
                      child: _buildListmasterOne(
                        context,
                        labelpayment: "Mã đặt chỗ",
                        datavalueone: "ABC123",
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: _buildListmasterOne(
                        context,
                        labelpayment: "Phương thức thanh toán",
                        datavalueone: "VNPay",
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: _buildListmasterOne(
                        context,
                        labelpayment: "Tổng tiền",
                        datavalueone: "8.000.000 ₫",
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildColumntrang(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      height: 24.h,
      title: AppbarTitleImage(
        imagePath: ImageConstant.imgIconLeftOnprimary,
        margin: EdgeInsets.only(left: 8.h),
      ),
      actions: [
        // AppbarTrailingIconbuttonOne(
        //   imagePath: ImageConstant.imgDivider,
        //   margin: EdgeInsets.only(
        //     top: 4.h,
        //     right: 8.h,
        //     bottom: 4.h,
        //   ),
        // )
      ],
      styleType: Style.bgFill_1,
    );
  }

  /// Section Widget
  Widget _buildColumntitlepaym(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage180x180,
            height: 180.h,
            width: 180.h,
            radius: BorderRadius.circular(
              8.h,
            ),
            margin: EdgeInsets.symmetric(horizontal: 2.h),
          ),
          SizedBox(height: 18.h),
          Text(
            "Thanh toán thành công!",
            style: CustomTextStyles.titleMediumGreenA700,
          )
        ],
      ),
    );
  }

  Widget _buildColumntrang(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, AppRoutes.homePage);
                    },
                    height: 40.h,
                    text: "Về trang chủ",
                    buttonStyle: CustomButtonStyles.outlineBlue,
                    buttonTextStyle: CustomTextStyles.bodyLargeBlue,
                  ),
                ),
                SizedBox(width: 8.h),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>  const MyBookingFullScreen()),
                      );
                    },
                    text: "Chi tiết đặt chỗ",
                    buttonStyle: CustomButtonStyles.fillBlue,
                    buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListmasterOne(
      BuildContext context, {
        required String labelpayment,
        required String datavalueone,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelpayment,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
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
          ),
          SizedBox(height: 6.h),
          const SizedBox(
            width: double.maxFinite,
            child: Divider(),
          )
        ],
      ),
    );
  }
}
