import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/hotel.dart';
import 'package:fhotel_1/data/models/hotel_image.dart';
import 'package:fhotel_1/presenters/list_hotel_presenter.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/list_hotel_view.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../data/repository/list_hotel_repo.dart';

class ListHotelWidget extends StatefulWidget {
  final String hotelId;
  final String image;
  final String name;
  final String checkInDate;
  final String checkOutDate;
  final String address;
  final int numberOfRooms;
  const ListHotelWidget({super.key, required this.hotelId ,required this.image, required this.name,required this.address, required this.checkInDate, required this.checkOutDate, required this.numberOfRooms});

  @override
  _ListHotelWidgetState createState() => _ListHotelWidgetState();
}

class _ListHotelWidgetState extends State<ListHotelWidget> implements ListHotelView{
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
        Navigator.pushReplacementNamed(
            context,
            AppRoutes.hotelDetail,
          arguments: {
            'hotelId': widget.hotelId,
            "checkInDate": widget.checkInDate,
            "checkOutDate": widget.checkOutDate,
            "numberOfRooms": widget.numberOfRooms,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          borderRadius: BorderRadiusStyle.circleBorder16,
        ),
        child: Row(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.roundedBorder8,
              ),
              child: Container(
                height: 120.h,
                width: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder8,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    (_hotelImage?.image != null)
                    ? Container(
                      height: 120.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                        8.h,
                      ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: (_hotelImage?.image).toString(),
                        fit: BoxFit.fitWidth,
                      ),
                    )
                    : Container(
                      height: 120.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                        8.h,
                      ),
                      ),
                      child: Skeleton(
                        height: 120.h,
                        width: double.maxFinite,
                      ),
                    ),
                    // IntrinsicHeight(
                    //   child: Align(
                    //     alignment: Alignment.bottomCenter,
                    //     child: Container(
                    //       height: 100.h,
                    //       padding: EdgeInsets.symmetric(vertical: 4.h),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.end,
                    //         children: [
                    //           CustomImageView(
                    //             color: appTheme.whiteA700,
                    //             imagePath: ImageConstant.imgIconWrapper13,
                    //             height: 24.h,
                    //             width: 24.h,
                    //             margin: EdgeInsets.only(top: 28.h),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.only(bottom: 2.h),
                    //             child: Text(
                    //               "380m",
                    //               style: CustomTextStyles.bodySmallWhiteA700,
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.titleSmallBlue,
                  ),
                  SizedBox(height: 4.h),
                  // CustomRatingBar(
                  //   color: Colors.yellow,
                  //   ignoreGestures: true,
                  //   initialRating: widget.rate.toDouble(),
                  // ),
                  SizedBox(height: 6.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      "Địa chỉ: ${widget.address}",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        height: 1.50,
                      ),
                      maxLines: 3,
                    ),
                  )
                ],
              ),
            )
          ],
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
