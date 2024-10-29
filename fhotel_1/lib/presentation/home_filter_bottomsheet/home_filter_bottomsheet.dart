import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class HomeFilterBottomsheet extends StatefulWidget {
  const HomeFilterBottomsheet({Key? key}) : super(key: key);

  @override
  HomeFilterBottomsheetState createState() => HomeFilterBottomsheetState();
}

// ignore_for_file: must_be_immutable
class HomeFilterBottomsheetState extends State<HomeFilterBottomsheet> {
  TextEditingController inputoneController = TextEditingController();
  TextEditingController labeloneController = TextEditingController();
  bool plateone = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.gray10001,
            borderRadius: BorderRadiusStyle.customBorderTL8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSheetheader(context),
              _buildSection(context),
              SizedBox(height: 8.h),
              _buildSectionone(context),
              SizedBox(height: 8.h),
              _buildSectiontwo(context),
              SizedBox(height: 8.h),
              _buildRowxablc(context)
            ],
          ),
        ),
      ),
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
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 150.h),
              child: Text(
                "Lọc",
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

  Widget _buildInputone(BuildContext context) {
    return CustomTextFormField(
      borderDecoration: OutlineInputBorder(
          borderSide: BorderSide(color: appTheme.black900.withOpacity(0.15))),
      controller: inputoneController,
      hintText: "Nhập giá",
      hintStyle: CustomTextStyles.bodyLargeBlack900_1,
      suffix: Padding(
        padding: EdgeInsets.only(right: 16.h),
        child: Text(
          "₫",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 14.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 40.h,
      ),
      contentPadding: EdgeInsets.fromLTRB(16.h, 8.h, 10.h, 8.h),
    );
  }

  Widget _buildLabelone(BuildContext context) {
    return CustomTextFormField(
      borderDecoration: OutlineInputBorder(
          borderSide: BorderSide(color: appTheme.black900.withOpacity(0.15))),
      controller: labeloneController,
      hintText: "Nhập giá",
      hintStyle: CustomTextStyles.bodyLargeBlack900_1,
      textInputAction: TextInputAction.done,
      suffix: Padding(
        padding: EdgeInsets.only(right: 16.h),
        child: Text(
          "₫",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontSize: 14.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 40.h,
      ),
      contentPadding: EdgeInsets.fromLTRB(16.h, 8.h, 10.h, 8.h),
    );
  }

  Widget _buildSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Giá phòng mỗi đêm",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Từ",
                        style: theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 4.h),
                      _buildInputone(context)
                    ],
                  ),
                ),
                SizedBox(width: 6.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Đến",
                        style: theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 4.h),
                      _buildLabelone(context)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hạng sao",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 32.h,
            width: 294.h,
            child: ListView.separated(
              padding: EdgeInsets.only(right: 34.h),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: 5,
              itemBuilder: (context, index) {
                return ChipTheme(
                  data: ChipTheme.of(context).copyWith(
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue,
                    disabledColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey, // Border color
                        width: 1, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(50), // Rounded corners
                    ),
                  ),
                  child: const Chip(
                    label: Text("1 sao"),
                    // selected: false,
                    // onSelected: (bool selected) {},
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectiontwo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
        left: 16.h,
        top: 16.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thanh toán",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 1.v),
                child: Checkbox(
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (!states.contains(MaterialState.selected)) {
                        return Colors.white;
                      }
                      return null;
                    },
                  ),
                  checkColor: Colors.white,
                  activeColor: Colors.blue,
                  value: plateone,
                  onChanged: (newValue) {
                    setState(() {
                      plateone = newValue!;
                    });
                  },
                ),
              ),
              Text(
                'Đặt trước, trả sau tại ngay nơi nghỉ',
                textAlign: TextAlign.start,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 10.h)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildXablc(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        height: 40.h,
        text: "Xóa bộ lọc",
        buttonStyle: CustomButtonStyles.outlineBlue,
        buttonTextStyle: CustomTextStyles.bodyLargeBlue,
      ),
    );
  }

  Widget _buildPang(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 40.h,
        text: "Áp dụng",
        buttonStyle: CustomButtonStyles.fillBlue,
        buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      ),
    );
  }

  /// Section Widget
  Widget _buildRowxablc(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 8.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          _buildXablc(context),
          SizedBox(width: 8.h),
          _buildPang(context)
        ],
      ),
    );
  }
}
