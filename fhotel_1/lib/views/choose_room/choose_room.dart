import 'package:fhotel_1/data/models/room_facility.dart';
import 'package:fhotel_1/data/models/room_image.dart';
import 'package:fhotel_1/data/models/type.dart';
import 'package:fhotel_1/data/repository/list_room_type_repo.dart';
import 'package:fhotel_1/views/choose_room/widgets/choose_room_widget.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../core/utils/skeleton.dart';
import '../../data/models/room_types.dart';
import '../../presenters/list_room_type_presenter.dart';
import '../choose_room_detail/choose_room_detail.dart';
import 'choose_room_view.dart';

class ChooseRoomFullScreen extends StatefulWidget {
  @override
  ChooseRoomFullScreenState createState() => ChooseRoomFullScreenState();
}

class ChooseRoomFullScreenState extends State<ChooseRoomFullScreen>
    implements ChooseRoomView {
  late String hotelId;
  late String hotelName;
  late ListRoomTypePresenter _presenter;
  bool _isLoading = false;
  String? _error;
  String? checkInDate;
  String? checkOutDate;
  int numberOfRooms = 0;
  int? numberOfDays;
  List<double?> _roomPrices = [];
  List<RoomType> _roomTypes = [];
  List<RoomImage> _roomImage = [];

  @override
  void initState() {
    super.initState();
    _presenter = ListRoomTypePresenter(this, ListRoomTypeRepo());
    Future.delayed(Duration.zero, () {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      hotelId = args['hotelId'];
      hotelName = args['hotelName'];
      checkInDate = args['checkInDate'] as String;
      checkOutDate = args['checkOutDate'] as String;
      numberOfRooms = args['numberOfRooms'] as int;
      // Now fetch room types using the presenter
      _presenter.getRoomTypesByHotelId(hotelId);
    });
  }

  void _showEditSearchModalBottomSheet(BuildContext context) {
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return EditSearchBottomsheet();
    //   },
    // );
  }

  void _showDetailModalBottomSheet(BuildContext context, String roomTypeId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ChooseRoomRoomDetailScreen(
            roomTypeId: roomTypeId,
            checkInDate: checkInDate.toString(),
            checkOutDate: checkOutDate.toString(),
            numberOfRooms: numberOfRooms);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (checkInDate != null && checkOutDate != null) {
      try {
        DateFormat dateFormat = DateFormat('dd/MM/yyyy');
        // Parse the dates using the correct format
        DateTime checkIn = dateFormat.parse(checkInDate!);
        DateTime checkOut = dateFormat.parse(checkOutDate!);

        setState(() {
          numberOfDays = checkOut.difference(checkIn).inDays;
        });
        // Calculate the difference in days
      } catch (e) {
        print('Error parsing dates: $e');
      }
    }
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContent(context),
                Container(
                  color: appTheme.gray10001,
                  // child: _buildFiltereditems(context)
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Danh sách các loại phòng:",
                        style: theme.textTheme.titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      _buildList(context),
                      SizedBox(height: 46.h)
                    ],
                  ),
                )
              ],
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
          text: hotelName,
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

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 8.h),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        border: Border(
          top: BorderSide(
            color: appTheme.whiteA700.withOpacity(0.15),
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomImageView(
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapperGray60024x24,
            height: 24.h,
            width: 24.h,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Text(
                checkInDate.toString(),
                style: CustomTextStyles.bodyMediumwhiteA700,
              ),
            ),
          ),
          CustomImageView(
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapper9,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 20.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              numberOfDays.toString(),
              style: CustomTextStyles.bodyMediumwhiteA700,
            ),
          ),
          CustomImageView(
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapper10,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 20.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              numberOfRooms.toString(),
              style: CustomTextStyles.bodyMediumwhiteA700,
            ),
          ),
          // CustomImageView(
          //   color: Colors.white,
          //   imagePath: ImageConstant.imgIconWrapper11,
          //   height: 24.h,
          //   width: 24.h,
          //   margin: EdgeInsets.only(left: 20.h),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: 4.h),
          //   child: Text(
          //     "3",
          //     style: CustomTextStyles.bodyMediumwhiteA700,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(left: 20.h),
            child: CustomIconButton(
              onTap: () {
                _showEditSearchModalBottomSheet(context);
              },
              height: 24.h,
              width: 24.h,
              padding: EdgeInsets.all(4.h),
              child: CustomImageView(
                color: Colors.white,
                imagePath: ImageConstant.imgArrowDownWhiteA700,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return _roomTypes.isEmpty && _roomPrices.isEmpty
        ? ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12.h,
              );
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                  border: Border.all(
                    color: appTheme.black900.withOpacity(0.2),
                    width: 1.h,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.fromLTRB(16.h, 8.h, 16.h, 6.h),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 150.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.h),
                              ),
                              child: Skeleton(
                                height: 150.h,
                                width: double.infinity,
                              )),
                          SizedBox(height: 8.h),
                          Skeleton(
                            width: 200.h,
                          ),
                          SizedBox(height: 2.h),
                          Skeleton(width: 100.h),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      decoration: BoxDecoration(
                        color: appTheme.whiteA700,
                      ),
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgIconWrapper15,
                            height: 24.h,
                            width: 24.h,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.only(left: 8.h),
                                child: Skeleton(
                                  width: 100.h,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: double.maxFinite,
                      child: Divider(),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: appTheme.whiteA700,
                      ),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Skeleton(width: 100.h)),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.h,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadiusStyle.roundedBorder4,
                              ),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Xem chi tiết phòng",
                                    style: TextStyle(color: Colors.white),
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
              );
            },
          )
        : ListView.separated(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemCount: _roomTypes.length,
            itemBuilder: (context, index) {
              return ChooseRoomWidget(
                hotelId: (_roomTypes[index].roomTypeId).toString(),
                roomTypes: _roomTypes[index],
                checkInDate: checkInDate.toString(),
                checkOutDate: checkOutDate.toString(),
                numberOfRooms: numberOfRooms,
              );
            },
          );
  }

  // Show loading indicator
  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    }); // Show loading indicator (e.g., CircularProgressIndicator)
  }

  @override
  void hideLoading() {}

  @override
  void showRoomTypes(List<RoomType> roomTypes) {
    setState(() async {
      _roomTypes = roomTypes;
      setState(() {
        _isLoading = false;
      }); // Hide loading indicator
    });
  }

  @override
  void onGetRoomImageSuccess(List<RoomImage> roomImage) {
    setState(() {
      _roomImage = roomImage; // Update state with the fetched images
    });
  }

  @override
  void onGetRoomTypeSuccess(RoomType hotel) {
    // TODO: implement onGetRoomTypeSuccess
  }

  @override
  void showTypes(List<Types> types) {
    // TODO: implement showTypes
  }

  @override
  void onGetPriceSuccess(double price) {}

  @override
  void showFacility(List<RoomFacility> facilities) {
    // TODO: implement showFacility
  }

  @override
  void onGetSingleRoomImageSuccess(RoomImage roomImage) {
    // TODO: implement onGetSingleRoomImageSuccess
  }
}
