import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class HomeCheckInDateDefaultBottomsheet extends StatefulWidget {
  HomeCheckInDateDefaultBottomsheet({Key? key})
      : super(
    key: key,
  );
  @override
  _HomeCheckInDateDefaultBottomsheet createState() => _HomeCheckInDateDefaultBottomsheet();
}
class _HomeCheckInDateDefaultBottomsheet extends State<HomeCheckInDateDefaultBottomsheet> {
  List<DateTime?> selectedDatesFromCalendar = [];
  static bool choose = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          borderRadius: BorderRadiusStyle.customBorderTL8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSheetheader(context),
            SizedBox(height: 14.h),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 12.h),
              child: Column(
                children: [_buildCalendarone(context)],
              ),
            ),
            SizedBox(height: 14.h),
            _buildButtonbar(context)
          ],
        ),
      ),
    );
  }

  Widget
  _buildSheetheader(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Chọn ngày nhận phòng",
              style: theme.textTheme.titleMedium,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 48.h),
            onTap: () {
              // Close the bottom sheet when the image is tapped
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget _buildCalendarone(BuildContext context) {
    return SizedBox(
      height: 338.h,
      width: 336.h,
      child: CalendarDatePicker2(
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.single,
            firstDate: DateTime(DateTime
                .now()
                .year - 5),
            lastDate: DateTime(DateTime
                .now()
                .year + 5),
            selectedDayHighlightColor: Color(0XFF1A94FF),
            firstDayOfWeek: 0,
            todayTextStyle: TextStyle(
              color: appTheme.black900.withOpacity(0.15),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            selectedDayTextStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
            dayTextStyle: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            dayBorderRadius: BorderRadius.circular(
              8.h,
            ),
          ),
          value: selectedDatesFromCalendar,
          onValueChanged: (dates) {
            setState(() {
              selectedDatesFromCalendar = dates;
              choose = true;
            });
              print(dates);
          }
      ),
    );
  }
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