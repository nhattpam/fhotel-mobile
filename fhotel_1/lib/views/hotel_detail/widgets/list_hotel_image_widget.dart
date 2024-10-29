import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/data/models/hotel_image.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/list_hotel_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/models/hotel.dart';
import '../../../data/repository/list_hotel_repo.dart';
import '../../../presenters/list_hotel_presenter.dart';

class ListHotelImageWidget extends StatefulWidget {
  final String hotelId;
  const ListHotelImageWidget({super.key, required this.hotelId});

  @override
  State<ListHotelImageWidget> createState() => _ListHotelImageWidgetState();
}

class _ListHotelImageWidgetState extends State<ListHotelImageWidget> implements ListHotelView {
  int activeIndex = 0;
  bool _isLoading = false;
  late HotelPresenter _presenter;
  String? _error;
  List<HotelImage> _hotelImage = [];
  List<Hotel> _hotels = [];

  @override
  void initState() {
    super.initState();
    _presenter = HotelPresenter(this, ListHotelRepo());
    _presenter.getHotelImages(widget.hotelId);
  }

  // Generates list of GestureDetector-wrapped images for tapping and zooming
  List<Widget> generateImagesTiles() {
    return _hotelImage
        .map((element) => GestureDetector(
      onTap: () {
        _showZoomableImageDialog(context, element.image.toString()); // Use imagePath from RoomImage
      },
      child: Container(
        width: 350,
        child: CachedNetworkImage(
          imageUrl: element.image.toString(),
          fit: BoxFit.fitWidth,
        ),
      ),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CarouselSlider(
            items: generateImagesTiles(), // Load images from _roomImage
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 108.h,
              initialPage: 0,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) => setState(() => activeIndex = index),
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count:  _hotelImage.isNotEmpty ? _hotelImage.length : 1, // Update count to the number of images
                    effect: ScrollingDotsEffect(
                      spacing: 4,
                      activeDotColor: theme.colorScheme.primary,
                      dotColor: appTheme.black900.withOpacity(0.1),
                      dotHeight: 2.h,
                      dotWidth: 16.h,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the zoomable image in a dialog with wider width
  void _showZoomableImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: InteractiveViewer(
              panEnabled: false, // Enable panning inside the dialog
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.network(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Show loading indicator
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
    setState(() async {
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
  void onSearchComplete(List<Hotel> roomTypes) {
    // setState(() {
    //   _hotels = roomTypes;
    //   _isLoading = false;
    // });
  }

  @override
  void onSearchError(String error) {
    setState(() {
      _error = error;
      _isLoading = false;
    });
  }

  @override
  void onGetHotelImagesSuccess(List<HotelImage> hotels) {
    setState(() {
      _hotelImage = hotels;
    });
  }

  @override
  void onGetSingleHotelImageSuccess(HotelImage hotels) {
    // TODO: implement onGetSingleHotelImageSuccess
  }

}
