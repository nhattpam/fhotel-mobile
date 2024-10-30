import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/data/models/room_facility.dart';
import 'package:fhotel_1/data/models/type.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/models/room_image.dart';
import '../../../data/models/room_types.dart';
import '../../../data/repository/list_room_type_repo.dart';
import '../../../presenters/list_room_type_presenter.dart';
import '../../choose_room/choose_room_view.dart';

class CarouselunitItemWidget extends StatefulWidget {
  final String roomTypeId;
  const CarouselunitItemWidget({super.key, required this.roomTypeId});

  @override
  State<CarouselunitItemWidget> createState() => _CarouselunitItemWidgetState();
}

class _CarouselunitItemWidgetState extends State<CarouselunitItemWidget> implements ChooseRoomView {
  int activeIndex = 0;
  late ListRoomTypePresenter _presenter;
  RoomType? _roomType;
  List<RoomImage> _roomImage = [];

  @override
  void initState() {
    super.initState();
    _presenter = ListRoomTypePresenter(this, ListRoomTypeRepo());
    _presenter.getRoomImages(widget.roomTypeId);
    _presenter.getRoomTypeById(widget.roomTypeId);
  }

  // Generates list of GestureDetector-wrapped images for tapping and zooming
  List<Widget> generateImagesTiles() {
    return _roomImage
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
                    count:  _roomImage.isNotEmpty ? _roomImage.length : 1, // Update count to the number of images
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
    // Show loading indicator (e.g., CircularProgressIndicator)
  }

  @override
  void hideLoading() {
    // Hide loading indicator
  }

  @override
  void showRoomTypes(List<RoomType> roomTypes) {
    // Logic to handle room types if necessary
  }

  @override
  void onGetRoomImageSuccess(List<RoomImage> roomImage) {
    if (roomImage.isNotEmpty && _roomImage.isEmpty) {
      setState(() {
        _roomImage = roomImage; // Update state with the fetched images only if it's empty
      });
    }
  }

  @override
  void onGetRoomTypeSuccess(RoomType roomType) {
    // TODO: implement onGetRoomTypeSuccess
    setState(() {
      _roomType = roomType;
    });
  }

  @override
  void showTypes(List<Types> types) {
    // TODO: implement showTypes
  }

  @override
  void onGetPriceSuccess(double price) {
    // TODO: implement onGetPriceSuccess
  }

  @override
  void showFacility(List<RoomFacility> roomTypes) {
    // TODO: implement showFacility
  }

  @override
  void onGetSingleRoomImageSuccess(RoomImage roomImage) {
    // TODO: implement onGetSingleRoomImageSuccess
  }

}
