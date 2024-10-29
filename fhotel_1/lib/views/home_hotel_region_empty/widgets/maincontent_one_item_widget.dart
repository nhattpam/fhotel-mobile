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
  const MaincontentOneltemWidget({super.key, required this.hotelId ,required this.image, required this.name, required this.rate, required this.description});

  @override
  _MaincontentOneltemWidgetState createState() => _MaincontentOneltemWidgetState();
  }

  class _MaincontentOneltemWidgetState extends State<MaincontentOneltemWidget> implements ListHotelView{
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
        Navigator.pushNamed(context, AppRoutes.hotelListing);
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
                  imagePath: _hotelImage?.image.toString(),
                  height: 170.h,
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
                    padding: EdgeInsets.only(
                      left: 8.h,
                      top: 6.h,
                      bottom: 6.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.5, 0),
                        end: Alignment(0.5, 1),
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.blueAccent
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
                          style: CustomTextStyles.bodySmallBlack900,
                        ),
                        SizedBox(height: 6.h),
                      ],
                    ),
                  ),
                )
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
