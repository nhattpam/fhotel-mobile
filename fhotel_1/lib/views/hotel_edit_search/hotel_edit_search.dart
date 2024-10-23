import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/views/home_destination_default/home_destination_default.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/search_view.dart';
import 'package:flutter/material.dart';

import '../../data/models/hotel.dart';
import '../../data/models/search.dart';
import '../../data/repository/search_service.dart';
import '../../presenters/search_presenter.dart';
import '../home_check_in_date_default/home_check_in_date_default.dart';
import '../home_duration_bottomsheet/home_duration_bottomsheet.dart';
import '../home_room_guest_default/home_room_guest_default.dart';

class EditSearchBottomsheet extends StatefulWidget {
  final String city;
  final String checkInDate;
  final String checkOutDate;
  final int numberOfRooms;
  const EditSearchBottomsheet({super.key, required this.checkInDate, required this.checkOutDate, required this.numberOfRooms, required this.city});


  @override
  EditSearchBottomsheetState createState() => EditSearchBottomsheetState();
}

class EditSearchBottomsheetState extends State<EditSearchBottomsheet> implements SearchView {
  String dateStarSelected = '';
  String dateEndSelected = '';
  List<String> searchHistory = [];
  String _searchQuery = ''; // Add a variable to store the search query
  List<Map<String, dynamic>> selectedRoomData = [];
  late SearchPresenter _searchPresenter;
  bool _isLoading = false;
  List<Hotel> listHotels = [];
  String? _error;
  String roomType = ''; // Add a variable to store the search query
  int quantity = 0; // Add a variable to store the search query

  @override
  void initState() {
    super.initState();
    _searchPresenter = SearchPresenter(this, SearchService());
  }


  void _showModalBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return HomeDestinationDefaultBottomsheet();
      },
    );

    if (result != null && result.isNotEmpty) {
      print('User searched for: $result');
      setState(() {
        _searchQuery = result;
        searchHistory.add(result);
      });
    }
  }

  void _showCalendarModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return HomeCheckInDateDefaultBottomsheet(
          onDateStarSelected: (selectedDate) {
            if (selectedDate != null) {
              // Update the state with the selected date
              setState(() {
                // Format the date as desired, here I’m using the default DateTime format
                dateStarSelected = DateFormat('dd/MM/yyyy').format(selectedDate);
              });
            }
          },
          onDateEndSelected: (selectedDate) {
            if (selectedDate != null) {
              // Update the state with the selected date
              setState(() {
                // Format the date as desired, here I’m using the default DateTime format
                dateEndSelected =
                    DateFormat('dd/MM/yyyy').format(selectedDate);
              });
            }
          },
        );
      },
    );
  }


  void _showRoomAndGuestModalBottomSheet(BuildContext context) async {
    // Await the result from the modal bottom sheet
    List<Map<String, dynamic>>? result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return HomeRoomGuestFilledBottomsheet();
      },
    );

    // Check if the result is not null (user didn't dismiss without selecting)
    if (result != null) {
      setState(() {
        selectedRoomData = result;
      });

      // You can also print or log the data to verify it:
      print("Selected Room Data: $selectedRoomData");
    }
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
                                        _searchQuery.isNotEmpty ? _searchQuery : widget.city,
                                        style: theme.textTheme.titleSmall,
                                      )
                                  ),
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
                                                        (dateStarSelected.toString()).isNotEmpty ? (dateStarSelected.toString()) : widget.checkInDate,
                                                        style: theme.textTheme
                                                            .titleSmall,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 18.0, top: 8),
                                            child: Container(
                                              height: 70.0,
                                              width: 1.0,
                                              color: Colors.black,
                                              // margin: const EdgeInsets.only(
                                              //     right: 10.0),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 10.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Ngày trả phòng:",
                                                      style: theme.textTheme.bodyMedium,
                                                    ),
                                                    SizedBox(height: 4.h),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        _showCalendarModalBottomSheet(
                                                            context);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                        Colors.transparent,
                                                        // Set background to transparent
                                                        elevation:
                                                        0, // Remove shadow/elevation
                                                      ),
                                                      child: Text(
                                                        (dateEndSelected.toString()).isNotEmpty ? (dateEndSelected.toString()) : widget.checkOutDate,
                                                        style:
                                                        theme.textTheme.titleSmall,
                                                      ),
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
                                ],
                              ),
                            ),
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
                                      "Số lượng phòng "+ widget.numberOfRooms.toString(),
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
    String selectedRoomInfo = selectedRoomData.isNotEmpty
        ? selectedRoomData.map((room) {
      setState(() {
        roomType = room['typeId'];
        quantity = room['quantity'];
      });
      return "${room['roomType']}: ${room['quantity']}";
    }).join(", ") // Concatenate room info
        : "Select room and guests"; // Default placeholder text

    List<RoomSearchRequest> searchRequests = selectedRoomData.map((room) {
      return RoomSearchRequest(
        typeId: room['typeId'],
        quantity: room['quantity'],
      );
    }).toList();
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
            onPressed: () async{
              await _searchPresenter.searchListRoomTypes(
                  searchRequests, _searchQuery);

              Navigator.pop(context, {
                "listHotels": listHotels,
                'checkInDate': dateStarSelected.isNotEmpty ? dateStarSelected : widget.checkInDate,
                'checkOutDate': dateEndSelected.isNotEmpty ? dateEndSelected : widget.checkOutDate,
                "numberOfRooms": quantity,
                'city': _searchQuery.isNotEmpty ? _searchQuery : widget.city,
              });

            },
            buttonStyle: CustomButtonStyles.fillBlue,
            buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
            text: "Tìm kiếm",
          )
        ],
      ),
    );
  }

  @override
  void onSearchComplete(List<Hotel> roomTypes) {
    // TODO: implement onSearchComplete
    setState(() {
      listHotels = roomTypes;
      _isLoading = false;
    });
  }

  @override
  void onSearchError(String error) {
    // TODO: implement onSearchError
  }
}
