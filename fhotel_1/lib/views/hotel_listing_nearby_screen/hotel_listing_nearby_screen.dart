import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/facility.dart';
import 'package:fhotel_1/data/models/room_image.dart';
import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/type.dart';
import 'package:fhotel_1/data/repository/list_room_type_repo.dart';
import 'package:fhotel_1/views/choose_room/choose_room_view.dart';
import 'package:fhotel_1/views/hotel_listing_filter_bottomsheet/hotel_listing_filter_bottomsheet.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/widgets/list_one_item_widget.dart';
import 'package:flutter/material.dart';

import '../../data/models/hotel.dart';
import '../../data/repository/list_hotel_repo.dart';
import '../../presenters/list_hotel_presenter.dart';
import '../../presenters/list_room_type_presenter.dart';
import 'list_hotel_view.dart';

class HotelListingNearbyScreen extends StatefulWidget {
  @override
  _HotelListingNearbyScreenState createState() =>
      _HotelListingNearbyScreenState();
}

class _HotelListingNearbyScreenState extends State<HotelListingNearbyScreen>
    implements ListHotelView, ChooseRoomView {
  late HotelPresenter _presenter;
  late ListRoomTypePresenter _listRoomTypePresenter;
  bool _isLoading = false;
  List<Hotel> _hotels = [];
  List<RoomType> _roomTypes = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _presenter = HotelPresenter(this, ListHotelRepo());
    _presenter.getHotels(); // Fetch the list of hotels when the screen loads
    _listRoomTypePresenter = ListRoomTypePresenter(this, ListRoomTypeRepo());
  }

  void _showHotelFilterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const HotellistingFilterBottomsheet();
      },
    );
  }

  void _showEditSearchModalBottomSheet(BuildContext context) {
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return EditSearchBottomsheet();
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.gray10001,
              ),
              child: Column(
                children: [
                  _buildContent(context),
                  _buildFiltersort(context),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              _buildListOne(context),
                              SizedBox(height: 12.h),
                              // _buildSubcontent(context)
                            ],
                          ),
                        )
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
          text: "Khách sạn gần bạn",
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                "02/02/2022",
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
              "2",
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
              "2",
              style: CustomTextStyles.bodyMediumwhiteA700,
            ),
          ),
          CustomImageView(
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapper11,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 20.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "3",
              style: CustomTextStyles.bodyMediumwhiteA700,
            ),
          ),
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

  Widget _buildFiltersort(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomOutlinedButton(
            onPressed: () {
              _showHotelFilterModalBottomSheet(context);
            },
            buttonStyle: CustomButtonStyles.outlineWhiteTL16,
            buttonTextStyle: CustomTextStyles.titleSmallWhite,
            width: 68.h,
            text: "Lọc",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 4.h),
              child: CustomImageView(
                color: appTheme.black900.withOpacity(0.15),
                imagePath: ImageConstant.imgIconWrapper1,
                height: 20.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          CustomOutlinedButton(
            width: 102.h,
            text: "Gần nhất",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 4.h),
              child: CustomImageView(
                color: Colors.blueAccent,
                imagePath: ImageConstant.imgActionSort,
                height: 20.h,
                width: 20.h,
                fit: BoxFit.contain,
              ),
            ),
            buttonStyle: CustomButtonStyles.outlineBlueTL16,
            buttonTextStyle: CustomTextStyles.titleSmallBlue,
          )
        ],
      ),
    );
  }

  Widget _buildListOne(BuildContext context) {
    return _isLoading
        ? ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12.h,
              );
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.h,
                    vertical: 10.h,
                  ),
                  child: const Skeleton(
                    height: 120,
                    width: 120,
                  ));
            },
          )
        : ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12.h,
              );
            },
            itemCount: _hotels.length,
            itemBuilder: (context, index) {
              _listRoomTypePresenter.getRoomTypesByHotelId(_hotels[index].hotelId.toString());
              print("This is" + _roomTypes.length.toString());
              return
                  // _hotels[index].isActive ?? false
                  // ?
                  ListHotelWidget(
                hotelId: _hotels[index].hotelId.toString(),
                image: _hotels[index].image.toString(),
                name: _hotels[index].hotelName.toString(),
                rate: _hotels[index]?.star ?? 0,
                basePrice: 0, checkInDate: '', checkOutDate: '', numberOfRooms: 0,
              );
              // : Container();
            },
          );
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  // Hide loading indicator
  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  // Handle success: display list of hotels
  @override
  void onGetHotelsSuccess(List<Hotel> hotels) {
    setState(() {
      _hotels = hotels;
      _error = null;
    });
  }

  // Handle error: display error message
  @override
  void onGetHotelsError(String error) {
    setState(() {
      _error = error;
    });
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
  void showRoomTypes(List<RoomType> roomTypes) {
    // TODO: implement showRoomTypes
    setState(() async {
      _roomTypes = roomTypes;
      });
  }

  @override
  void showTypes(List<Types> types) {
    // TODO: implement showTypes
  }

  @override
  void onGetPriceSuccess(List<double?> price) {
    // TODO: implement onGetPriceSuccess
  }

  @override
  void showFacility(List<Facility> roomTypes) {
    // TODO: implement showFacility
  }
}
