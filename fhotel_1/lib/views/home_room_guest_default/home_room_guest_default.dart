import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class HomeRoomGuestFilledBottomsheet extends StatefulWidget {
  const HomeRoomGuestFilledBottomsheet({super.key});

  @override
  HomeRoomGuestFilledBottomsheetState createState() =>
      HomeRoomGuestFilledBottomsheetState();
}

class HomeRoomGuestFilledBottomsheetState
    extends State<HomeRoomGuestFilledBottomsheet> {
  TextEditingController inputOneController = TextEditingController();
  List<String> dropdownItemList = ["Phòng đôi", "Phòng đơn", "Phòng siu cấp vip pro"];
  List<int> quantities = [1, 1, 1]; // Initialize all quantities to 1

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
              SizedBox(height: 10.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(
                  left: 16.h,
                  right: 92.h,
                ),
                child: Column(
                  children: [
                    Text(
                      "Tối đa 8 phòng",
                      style: theme.textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: appTheme.whiteA700,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildColumniconwrapp(context),
                    /// In case have to design for kid
                    // SizedBox(height: 16.h),
                    // Text(
                    //   "Vui lòng chọn tuổi của trẻ vào thời điểm nhận phòng",
                    //   style: CustomTextStyles.bodyLargeOnPrimary_1,
                    // ),
                    // SizedBox(height: 12.h),
                    // Text(
                    //   "Trẻ em 1",
                    //   style: theme.textTheme.titleSmall,
                    // ),
                    // SizedBox(height: 4.h),
                    // _buildStatusiconone(context),
                    // SizedBox(height: 4.h),
                    // Text(
                    //   "Vui lòng điền thông tin",
                    //   style: CustomTextStyles.bodySmallRedA200,
                    // )
                  ],
                ),
              ),
              _buildButtonbar(context)
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Chọn số phòng và loại phòng",
              style: theme.textTheme.titleMedium,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 44.h),
          )
        ],
      ),
    );
  }

  Widget _buildColumniconwrapp(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: dropdownItemList.length,
        // Replace yourList with the actual list you're using
        shrinkWrap: true,
        // This will allow the ListView to fit within its parent
        physics: NeverScrollableScrollPhysics(),
        // Prevents the ListView from being scrollable if inside another scrollable widget
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder4,
                ),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: appTheme.whiteA700,
                        ),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgIconWrapper5,
                              height: 24.h,
                              width: 24.h,
                            ),
                             Expanded(
                               child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 2.h, left: 5.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   "Số phòng và loại phòng",
                                      //   style: theme.textTheme.bodyMedium!.copyWith(
                                      //     color: theme.colorScheme.onPrimary,
                                      //   ),
                                      // ),
                                      // SizedBox(height: 6.h),
                                      ElevatedButton(
                                          onPressed: () {
                                            // _showRoomAndGuestModalBottomSheet(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            // Set background to transparent
                                            elevation: 0, // Remove shadow/elevation
                                          ),
                                          child: Text(
                                            "Phòng ${dropdownItemList[index]}",
                                            style: CustomTextStyles.titleSmallGray600.copyWith(
                                              color: appTheme.gray600,
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                                           ),
                             ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 148.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quantities[index] > 1) {
                                  quantities[index]--;
                                }
                              });
                              // Handle minus button logic here
                            },
                            child: Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusStyle.roundedBorder4,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1.h,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomImageView(
                                    color: Colors.blue,
                                    imagePath: ImageConstant.imgContentMinus,
                                    height: 24.h,
                                    width: 24.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 4.h),
                          Expanded(
                            child: CustomTextFormField(
                              borderDecoration: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          appTheme.black900.withOpacity(0.15),
                                      width: 2)),
                              readOnly: true,
                              controller: inputOneController,
                              hintText: quantities[index].toString(),
                              hintStyle: const TextStyle(color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.h,
                                vertical: 8.h,
                              ),
                            ),
                          ), // Custom input widget
                          SizedBox(width: 4.h),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantities[index]++;
                              });
                              // Handle plus button logic here
                            },
                            child: Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusStyle.roundedBorder4,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1.h,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomImageView(
                                    color: Colors.blue,
                                    imagePath: ImageConstant.imgIconWrapper6,
                                    height: 24.h,
                                    width: 24.h,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              SizedBox(
                width: double.maxFinite,
                child: Divider(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusiconone(BuildContext context) {
    return CustomDropDown(
      width: 160.h,
      icon: Container(
        margin: EdgeInsets.only(left: 16.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgStatusIcon,
          height: 24.h,
          width: 24.h,
          fit: BoxFit.contain,
        ),
      ),
      iconSize: 24.h,
      hintText: "Chọn tuổi",
      items: dropdownItemList,
      contentPadding: EdgeInsets.fromLTRB(16.h, 8.h, 10.h, 8.h),
    );
  }

  /// Section Widget
  Widget _buildHontt(BuildContext context) {
    return CustomElevatedButton(
      onPressed: (){
        List<Map<String, dynamic>> roomData = List.generate(3, (index) {
          return {
            "roomType": dropdownItemList[index], // Adjust this based on user selection
            "quantity": quantities[index],
          };
        });

        // Pass the data back to the previous screen
        Navigator.pop(context, roomData);
      },
      text: "Hoàn tất",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
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
        children: [_buildHontt(context)],
      ),
    );
  }

}
