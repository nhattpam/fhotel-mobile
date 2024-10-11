import 'package:fhotel_1/views/my_booking_details/my_booking_details.dart';
import 'package:fhotel_1/views/my_booking_full_screen/widgets/maincontent7_item_widget.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class MyBookingFullScreen extends StatelessWidget {
  const MyBookingFullScreen({Key? key})
      : super(
    key: key,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              color: appTheme.gray10001,
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 16.h,
                top: 28.h,
                right: 16.h,
              ),
              child: Column(
                children: [
                  _buildSection(context),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "01/2022",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 10.h),
                        _buildMaincontent(context)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgChevronLeft,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.h,
          bottom: 16.h,
        ),
      ),
      title: AppbarTitle(
        text: "Danh sách đặt phòng",
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
              SizedBox(width: 8.h),
              AppbarIconbutton(
                imagePath: ImageConstant.imgDivider,
                margin: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 4.h,
                ),
              )
            ],
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  Widget _buildAngx1(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: 94.h,
      text: "Đang xử lý",
      buttonStyle: CustomButtonStyles.fillYellow,
      buttonTextStyle: CustomTextStyles.bodyMediumSecondaryContainer,
    );
  }

  Widget _buildSection(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "01/2022",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>  MyBookingDetailsScreen()),
              );
            },
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 4.h),
                  _buildAngx1(context),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        CustomImageView(
                          color: appTheme.black900.withOpacity(0.5),
                          imagePath: ImageConstant.imgIconWrapperPrimary,
                          height: 24.h,
                          width: 24.h,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.h),
                            child: Text(
                              "Khách sạn Pullman Vũng Tàu",
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Divider(
                      color: appTheme.blueGray50,
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Mã đặt chỗ: 453653657",
                          style: theme.textTheme.labelLarge,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            "8.000.000 ₫",
                            style: CustomTextStyles.titleSmallBlue,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildMaincontent(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 12.h,
        );
      },
      itemCount: 3,
      itemBuilder: (context, index) {
        return Maincontent7ItemWidget();
      },
    );
  }
}
