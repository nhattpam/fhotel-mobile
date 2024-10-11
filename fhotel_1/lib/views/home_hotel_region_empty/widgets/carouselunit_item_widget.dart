import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:fhotel_1/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselunitItemWidget extends StatefulWidget {
  const CarouselunitItemWidget({super.key});

  @override
  State<CarouselunitItemWidget> createState() => _CarouselunitItemWidgetState();
}

class _CarouselunitItemWidgetState extends State<CarouselunitItemWidget> {
  int activeIndex = 0;

  final List<String> images = [
    ImageConstant.imgImage,
    ImageConstant.imgImage108x328,
    ImageConstant.imgImage108x328,
    ImageConstant.imgImage108x328,
  ];

  // Generates list of GestureDetector-wrapped images for tapping and zooming
  List<Widget> generateImagesTiles() {
    return images
        .map((element) => GestureDetector(
              onTap: () {
                _showZoomableImageDialog(
                    context, element); // Open zoomable dialog
              },
              child: Container(
                width: 350,
                child: Image.asset(
                  element,
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
            items: generateImagesTiles(), // Load images with zoom functionality
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 108.h,
              initialPage: 0,
              autoPlay: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
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
                    count: images.length,
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
            // Set dialog width to 90% of screen width
            // height: MediaQuery.of(context).size.height * 0.9, // Set dialog height to 80% of screen height
            child: InteractiveViewer(
              panEnabled: false, // Enable panning inside the dialog
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
