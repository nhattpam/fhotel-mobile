import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/hotel.dart';
import 'package:fhotel_1/data/models/hotel_image.dart';
import 'package:fhotel_1/data/repository/list_hotel_repo.dart';
import 'package:fhotel_1/presenters/list_hotel_presenter.dart';
import 'package:flutter/material.dart';

import '../../hotel_listing_nearby_screen/list_hotel_view.dart';

class MaincontentOneltemWidget extends StatefulWidget {
  final String hotelId;
  final String image;
  final String name;
  final int rate;
  final String description;
  final String checkInDate;
  final String checkOutDate;

  const MaincontentOneltemWidget(
      {super.key,
      required this.hotelId,
      required this.image,
      required this.name,
      required this.rate,
      required this.description,
      required this.checkInDate,
      required this.checkOutDate});

  @override
  _MaincontentOneltemWidgetState createState() =>
      _MaincontentOneltemWidgetState();
}

class _MaincontentOneltemWidgetState extends State<MaincontentOneltemWidget>
    implements ListHotelView {
  late HotelPresenter _presenter;
  bool _isLoading = false;
  String? _error;
  HotelImage? _hotelImage;

  @override
  void initState() {
    super.initState();
    _presenter = HotelPresenter(this, ListHotelRepo());
    _presenter.getHotelImage(widget.hotelId); // Fetch the list of hotels when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.hotelDetail,
          arguments: {
            'hotelId': widget.hotelId,
            "checkInDate": widget.checkInDate,
            "checkOutDate": widget.checkOutDate,
            "numberOfRooms": 1,
          },
        );
      },
      child: SizedBox(
        width: 128.h,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyle.roundedBorder8,
          ),
          child: Container(
            height: 170.h,
            width: 128.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _hotelImage != null
                    ? CustomImageView(
                      fit: BoxFit.contain,
                      imagePath: _hotelImage?.image.toString(),
                      height: 100.h,
                      width: double.maxFinite,
                      radius: BorderRadius.circular(
                        8.h,
                      ),
                    )
                    : Skeleton(
                        height: 170.h,
                        width: double.maxFinite,
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.h),
                        bottomRight: Radius.circular(8.h),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          appTheme.blue600,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 26.h),
                        Text(
                          widget.name,
                          style: CustomTextStyles.bodySmallBlack900.copyWith(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1), // Đổ bóng nhẹ
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void onGetHotelImagesSuccess(List<HotelImage> hotels) {
    // TODO: implement onGetHotelImagesSuccess
  }

  @override
  void onGetHotelsError(String error) {
    // TODO: implement onGetHotelsError
  }

  @override
  void onGetHotelsSuccess(List<Hotel> hotels) {
    // TODO: implement onGetHotelsSuccess
  }

  @override
  void onGetSingleHotelImageSuccess(HotelImage hotels) {
    // TODO: implement onGetSingleHotelImageSuccess
    setState(() {
      _hotelImage = hotels;
    });
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }
}
