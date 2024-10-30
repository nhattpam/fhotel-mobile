import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/hotel.dart';
import 'package:fhotel_1/data/models/hotel_image.dart';
import 'package:fhotel_1/data/models/room_facility.dart';
import 'package:fhotel_1/data/models/room_image.dart';
import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/type.dart';
import 'package:fhotel_1/data/repository/list_hotel_repo.dart';
import 'package:fhotel_1/presenters/list_hotel_presenter.dart';
import 'package:fhotel_1/presenters/list_room_type_presenter.dart';
import 'package:flutter/material.dart';

import '../../../data/repository/list_room_type_repo.dart';
import '../../choose_room_detail/choose_room_detail.dart';
import '../../hotel_listing_nearby_screen/list_hotel_view.dart';
import '../choose_room_view.dart';

class ChooseRoomWidget extends StatefulWidget {
  final String hotelId;
  final String checkInDate;
  final String checkOutDate;
  final int numberOfRooms;
  final RoomType roomTypes;
  const ChooseRoomWidget({super.key, required this.hotelId, required this.roomTypes, required this.checkInDate, required this.checkOutDate, required this.numberOfRooms});

  @override
  _ChooseRoomWidgetState createState() => _ChooseRoomWidgetState();
}

class _ChooseRoomWidgetState extends State<ChooseRoomWidget> implements ChooseRoomView{
  late ListRoomTypePresenter _presenter;
  bool _isLoading = false;
  String? _error;
  RoomImage? singleRoomImage;
  double? roomPrice;
  @override
  void initState() {
    super.initState();
    _presenter = ListRoomTypePresenter(this, ListRoomTypeRepo());
    _presenter.getRoomImage(widget.hotelId); // Fetch the list of hotels when the screen loads
    _presenter.loadRoomPrice(widget.hotelId);
  }
  void _showDetailModalBottomSheet(BuildContext context, String roomTypeId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ChooseRoomRoomDetailScreen(
            roomTypeId: roomTypeId,
            checkInDate: widget.checkInDate.toString(),
            checkOutDate: widget.checkOutDate.toString(),
            numberOfRooms: widget.numberOfRooms);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                (singleRoomImage?.image != null)
                ? Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: (singleRoomImage?.image).toString(),
                    // Use the imageUrl property
                    fit: BoxFit.fitWidth,
                  ),
                )
                : Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                  child: Skeleton(
                    height: 150.h,
                    width: double.infinity,
                  )
                ),
                SizedBox(height: 8.h),
                Text(
                  (widget.roomTypes.type?.typeName).toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall!
                      .copyWith(height: 1.50),
                ),
                SizedBox(height: 2.h),
                (widget.roomTypes.roomSize != null)
                ? Text(
                  "Diện tích: ${NumberFormat('#,###', 'en_US').format(widget.roomTypes.roomSize)}m²",
                  style: theme.textTheme.bodySmall,
                )
                    : Skeleton(width: 50.h),
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
                    child: Text(
                      "Tối đa ${widget.roomTypes.type?.maxOccupancy.toString() ?? ''} người",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
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
                  child: RichText(
                    text: TextSpan(
                      children: [
                        roomPrice != null && roomPrice! > 0
                            ? TextSpan(
                          text: NumberFormat('#,###', 'en_US').format(roomPrice) + " ₫",
                          style: CustomTextStyles.titleSmallBlue,
                        )
                            : TextSpan(
                          text: "0 ₫",
                          style: CustomTextStyles.titleSmallBlue,
                        ),
                        TextSpan(
                          text: "/ phòng / đêm",
                          style: CustomTextStyles.bodySmallOnPrimary,
                        )
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showDetailModalBottomSheet(context, widget.roomTypes.roomTypeId.toString());
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
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void onGetPriceSuccess(double price) {
    // TODO: implement onGetPriceSuccess
    setState(() {
      roomPrice = price;
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
  void onGetSingleRoomImageSuccess(RoomImage roomImage) {
    // TODO: implement onGetSingleRoomImageSuccess
    setState(() {
      singleRoomImage = roomImage;
    });
  }

  @override
  void showFacility(List<RoomFacility> facilities) {
    // TODO: implement showFacility
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  void showRoomTypes(List<RoomType> roomTypes) {
    // TODO: implement showRoomTypes
  }

  @override
  void showTypes(List<Types> types) {
    // TODO: implement showTypes
  }

}
