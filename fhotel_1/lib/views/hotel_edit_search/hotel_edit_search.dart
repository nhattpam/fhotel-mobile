import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/views/home_destination_default/home_destination_default.dart';
import 'package:flutter/material.dart';

import '../home_check_in_date_default/home_check_in_date_default.dart';
import '../home_duration_bottomsheet/home_duration_bottomsheet.dart';
import '../home_room_guest_default/home_room_guest_default.dart';

class EditSearchBottomsheet extends StatefulWidget {
  EditSearchBottomsheet({Key? key}) : super(key: key);

  @override
  EditSearchBottomsheetState createState() => EditSearchBottomsheetState();
}

class EditSearchBottomsheetState extends State<EditSearchBottomsheet> {
  String dateSelected = "Thứ Tư, 02/02/2022";

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return HomeDestinationDefaultBottomsheet();
      },
    );
  }

  void _showCalendarModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return HomeCheckInDateDefaultBottomsheet(
          onDateSelected: (selectedDate) {
            if (selectedDate != null) {
              // Update the state with the selected date
              setState(() {
                // Format the date as desired, here I’m using the default DateTime format
                dateSelected =
                    DateFormat('EEEE, dd/MM/yyyy').format(selectedDate);
              });
            }
          },
        );
      },
    );
  }

  void _showDurationModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const HomeDurationBottomsheet();
      },
    );
  }

  void _showRoomAndGuestModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return HomeRoomGuestFilledBottomsheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadiusStyle.customBorderTL8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildColumntitleedit(context), _buildButtonbar(context)],
      ),
    );
  }

  Widget _buildColumntitleedit(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Container(
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
                  "Thay đổi tìm kiếm",
                  style: theme.textTheme.titleMedium,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgCloseIcon,
                  height: 24.h,
                  width: 24.h,
                  margin: EdgeInsets.only(left: 70.h),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              color: appTheme.black900.withOpacity(0.5),
                              imagePath: ImageConstant.imgIconWrapperGray600,
                              height: 24.h,
                              width: 24.h,
                              alignment: Alignment.topCenter,
                            ),
                            SizedBox(width: 6.h),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Điểm đến, khách sạn",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: 6.h),
                                  ElevatedButton(
                                      onPressed: () =>
                                          _showModalBottomSheet(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        // Set background to transparent
                                        elevation: 0, // Remove shadow/elevation
                                      ),
                                      child: Text(
                                        "Khách sạn gần bạn",
                                        style: theme.textTheme.titleSmall,
                                      )),
                                ],
                              ),
                            ),
                            // SizedBox(width: 6.h),
                            // CustomIconButton(
                            //   height: 24.h,
                            //   width: 24.h,
                            //   padding: EdgeInsets.all(4.h),
                            //   decoration: IconButtonStyleHelper.fillBlackTL12,
                            //   child: CustomImageView(
                            //     imagePath:
                            //     ImageConstant.imgIconWrapperGray60024x24,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Divider(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: appTheme.whiteA700,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomImageView(
                                            color: appTheme.black900
                                                .withOpacity(0.5),
                                            imagePath: ImageConstant
                                                .imgIconWrapperGray60024x24,
                                            height: 24.h,
                                            width: 24.h,
                                            margin: EdgeInsets.only(top: 8.h),
                                          ),
                                          SizedBox(width: 8.h),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ngày nhận phòng",
                                                      style: theme
                                                          .textTheme.bodyMedium,
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        _showCalendarModalBottomSheet(
                                                            context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        // Set background to transparent
                                                        elevation:
                                                            0, // Remove shadow/elevation
                                                      ),
                                                      child: Text(
                                                        "Thứ Tư,02/02/2022",
                                                        style: theme.textTheme
                                                            .titleSmall,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: appTheme.whiteA700,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10.h),
                                        Text(
                                          "Sõ đêm nghỉ",
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        SizedBox(height: 4.h),
                                        ElevatedButton(
                                          onPressed: () {
                                            _showDurationModalBottomSheet(
                                                context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            // Set background to transparent
                                            elevation:
                                                0, // Remove shadow/elevation
                                          ),
                                          child: Text(
                                            "1 đêm",
                                            style: theme.textTheme.titleSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.symmetric(horizontal: 32.h),
                              child: Row(
                                children: [
                                  Text(
                                    "Ngày trả phòng:",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.h),
                                    child: Text(
                                      "Thứ Sáu, 04/02/2022",
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: Divider(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 6.h,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgIconWrapper24x24,
                        height: 24.h,
                        width: 24.h,
                        color: appTheme.black900.withOpacity(0.5),
                      ),
                      SizedBox(width: 8.h),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Số phòng và khách",
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                ElevatedButton(
                                    onPressed: () {
                                      _showRoomAndGuestModalBottomSheet(
                                          context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      // Set background to transparent
                                      elevation: 0, // Remove shadow/elevation
                                    ),
                                    child: Text(
                                      "2 phòng, 2 người lớn, 1 trẻ em",
                                      style: CustomTextStyles.titleSmallGray600
                                          .copyWith(
                                        color: appTheme.gray600,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonbar(BuildContext context) {
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
          CustomElevatedButton(
            buttonStyle: CustomButtonStyles.fillBlue,
            buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
            text: "Tìm kiếm",
          )
        ],
      ),
    );
  }
}
