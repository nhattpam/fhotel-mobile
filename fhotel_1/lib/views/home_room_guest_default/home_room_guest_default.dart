import 'package:fhotel_1/data/models/room_image.dart';
import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/type.dart';
import 'package:fhotel_1/data/repository/list_room_type_repo.dart';
import 'package:fhotel_1/presenters/list_room_type_presenter.dart';
import 'package:fhotel_1/views/choose_room/choose_room_view.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class HomeRoomGuestFilledBottomsheet extends StatefulWidget {
  const HomeRoomGuestFilledBottomsheet({super.key});

  @override
  HomeRoomGuestFilledBottomsheetState createState() =>
      HomeRoomGuestFilledBottomsheetState();
}

class HomeRoomGuestFilledBottomsheetState
    extends State<HomeRoomGuestFilledBottomsheet> implements ChooseRoomView {
  TextEditingController inputOneController = TextEditingController();
  TextEditingController inputThreeController = TextEditingController();
  TextEditingController inputFiveController = TextEditingController();
  List<int> quantities = [0, 0, 0]; // Initialize all quantities to 1
  late ListRoomTypePresenter _presenter;
  bool _isLoading = false;
  List<RoomType> _roomTypes = [];
  List<Types> _types = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _presenter = ListRoomTypePresenter(this, ListRoomTypeRepo());
    _presenter.getRoomTypes(); // Fetch the list of hotels when the screen loads
    _presenter.getTypes();
  }
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // DropdownButton<String>(
                    //   value: _selectedRoomType,
                    //   items: _roomTypes.map((RoomType roomType) {
                    //     return DropdownMenuItem<String>(
                    //       value: roomType.typeName,
                    //       child: Text(roomType.typeName.toString(), style: theme.textTheme.bodyMedium),
                    //     );
                    //   }).toList(),
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       _selectedRoomType = newValue!;
                    //     });
                    //   },
                    // )
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
  ///List
  Widget _buildColumniconwrapp(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: _types.length,
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
                                            "Phòng ${_types[index].typeName}",
                                            // "${dropdownItemList[index]}",
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

  // Widget _buildColumniconwrapp(BuildContext context) {
  //   return SizedBox(
  //     width: double.maxFinite,
  //     child: Column(
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadiusStyle.roundedBorder4,
  //           ),
  //           width: double.maxFinite,
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: appTheme.whiteA700,
  //                   ),
  //                   child: Row(
  //                     children: [
  //                       CustomImageView(
  //                         imagePath: ImageConstant.imgIconWrapper5,
  //                         height: 24.h,
  //                         width: 24.h,
  //                       ),
  //                       Align(
  //                         alignment: Alignment.bottomCenter,
  //                         child: Padding(
  //                           padding: EdgeInsets.only(left: 8.h),
  //                           child: Text(
  //                             "Phòng",
  //                             style: theme.textTheme.titleSmall,
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 148.h,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           if (quantity > 1) {
  //                             quantity--;
  //                           }
  //                         });
  //                       },
  //                       child: Container(
  //                         height: 40.h,
  //                         width: 40.h,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadiusStyle.roundedBorder4,
  //                           border: Border.all(
  //                             color: Colors.blue,
  //                             width: 1.h,
  //                           ),
  //                         ),
  //                         child: Stack(
  //                           alignment: Alignment.center,
  //                           children: [
  //                             CustomImageView(
  //                               color: Colors.blue,
  //                               imagePath: ImageConstant.imgContentMinus,
  //                               height: 24.h,
  //                               width: 24.h,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(width: 4.h),
  //                     _buildInputone(context),
  //                     SizedBox(width: 4.h),
  //                     GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           quantity++;
  //                         });
  //                       },
  //                       child: Container(
  //                         height: 40.h,
  //                         width: 40.h,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadiusStyle.roundedBorder4,
  //                           border: Border.all(
  //                             color: Colors.blue,
  //                             width: 1.h,
  //                           ),
  //                         ),
  //                         child: Stack(
  //                           alignment: Alignment.center,
  //                           children: [
  //                             CustomImageView(
  //                               color: Colors.blue,
  //                               imagePath: ImageConstant.imgIconWrapper6,
  //                               height: 24.h,
  //                               width: 24.h,
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //         SizedBox(height: 6.h),
  //         SizedBox(
  //           width: double.maxFinite,
  //           child: Divider(),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  /// Section Widget
  Widget _buildHontt(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        List<Map<String, dynamic>> roomData = [];

        // Iterate through room types and only add those with quantity > 0
        for (int index = 0; index < _types.length; index++) {
          if (quantities[index] > 0) {
            roomData.add({
              "roomType": _types[index].typeName,
              "typeId": _types[index].typeId,
              "quantity": quantities[index],
            });
          }
        }

        // Check if there's data to return
        if (roomData.isNotEmpty) {
          // Pass the data back to the previous screen
          Navigator.pop(context, roomData);
        } else {
          // If no room is selected, you might want to show a warning or simply dismiss
          Navigator.pop(context, null);  // or show a warning if required
        }
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

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void onGetRoomImageSuccess(List<RoomImage> roomImage) {
    // TODO: implement onGetRoomImageSuccess
  }

  @override
  void onGetRoomTypeSuccess(RoomType hotel) {
    // TODO: implement onGetRoomTypeSuccess
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  void showRoomTypes(List<RoomType> roomTypes) {
    // TODO: implement showRoomTypes
    setState(() {
      _roomTypes = roomTypes;
      _error = null;
    });
  }

  @override
  void showTypes(List<Types> types) {
    // TODO: implement showTypes
    setState(() {
      _types = types;
      _error = null;
    });
  }

  @override
  void onGetPriceSuccess(List<double?> price) {
    // TODO: implement onGetPriceSuccess
  }

}
