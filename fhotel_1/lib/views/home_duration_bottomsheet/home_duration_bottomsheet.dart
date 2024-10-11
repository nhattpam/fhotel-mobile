import 'package:fhotel_1/views/home_duration_bottomsheet/widgets/home_duration_item_widget.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class HomeDurationBottomsheet extends StatefulWidget {
  const HomeDurationBottomsheet({Key? key}) : super(key: key);

  @override
  _HomeDurationBottomsheetState createState() => _HomeDurationBottomsheetState();
}

class _HomeDurationBottomsheetState extends State<HomeDurationBottomsheet> {
  bool choose = false; // Move the choose state here
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            borderRadius: BorderRadiusStyle.customBorderTL8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSheetheader(context),
              SizedBox(height: 8.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(
                  left: 16.h,
                  right: 248.h,
                ),
                child: Column(
                  children: [
                    Text(
                      "Tối đa 30 đêm",
                      style: theme.textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              SizedBox(height: 18.h,),
              SizedBox(
                height: 456.h,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, children: [
                          _buildHomeduration(context),
                          SizedBox(height: 8.h),
                          Divider(),
                        ],
                        ),
                      ),
                    ),
                    _buildButtonbar(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetheader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 6.h,
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
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Chọn số đêm nghi",
            style: theme.textTheme.titleMedium,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 68.h),
            onTap: () {
              // Close the bottom sheet when the image is tapped
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget _buildHomeduration(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          child: Divider(
            height: 1.h,
            thickness: 1.h,
            color: appTheme.blueGray50,
          ),
        );
      },
      itemCount: 10,
      itemBuilder: (context, index) {
        return HomeDurationItemWidget(
          onSelectionChanged: (selected) {
            setState(() {
              choose = selected; // Update the static variable
            });
          },
        );
      },
    );
  }


  // Widget _buildwrapper(BuildContext context) {
  //   return SizedBox(
  //     width: double.maxFinite,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         CustomImageView(
  //           imagePath: ImageConstant.imgCircle,
  //           height: 20.h,
  //           width: 20.h,
  //           radius: BorderRadius.circular(
  //             10.0.h,
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(left: 10.h),
  //           child: Text(
  //             "1 đêm",
  //             style: theme.textTheme.titleSmall,
  //           ),
  //         ),
  //         Spacer(),
  //         Text(
  //           "Trả phòng: 13/02/2022",
  //           style: theme.textTheme.bodyMedium,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildButtonbar (BuildContext context) {
    return Container(
      width: double.maxFinite,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(choose == true)
            CustomElevatedButton(
              text: "Hoàn tất",
              buttonStyle: CustomButtonStyles.fillBlue,
              buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
            ),
          if(choose == false)
            CustomElevatedButton(
              text: "Hoàn tất",
              buttonStyle: CustomButtonStyles.fillBlack,
              buttonTextStyle: CustomTextStyles.bodyLargeBlack900_1,
            )
        ],
      ),
    );
  }

}