import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/data/models/hotel_image.dart';
import 'package:fhotel_1/views/hotel_edit_search/hotel_edit_search.dart';
import 'package:fhotel_1/views/hotel_listing_filter_bottomsheet/hotel_listing_filter_bottomsheet.dart';
import 'package:flutter/material.dart';

import '../../data/models/hotel.dart';

class ListHotelBySearchEmpty extends StatefulWidget {
  @override
  _ListHotelBySearchEmptyState createState() =>
      _ListHotelBySearchEmptyState();
}

class _ListHotelBySearchEmptyState extends State<ListHotelBySearchEmpty>{
  bool _isLoading = false;
  List<Hotel> listHotel = [];
  List<Hotel> listHotel2 = [];
  List<HotelImage> _hotelImage = [];
  String? checkInDate;
  String? checkInDate2;
  String? checkOutDate;
  String? checkOutDate2;
  String? city;
  String? city2;
  int numberOfRooms = 0;
  int numberOfRooms2 = 0;
  int? numberOfDays;
  Key _pageKey = UniqueKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Safely retrieve and cast the arguments
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map) {
      setState(() {
        // Retrieve and cast each argument safely
        checkInDate = arguments['checkInDate'] as String;
        checkOutDate = arguments['checkOutDate'] as String;
        city = arguments['city'] as String;
        numberOfRooms = arguments['numberOfRooms'] as int;
        // Retrieve the listHotels if provided
        final hotels = arguments['listHotels'];
        if (hotels is List<Hotel>) {
          listHotel = hotels;
        } else {
          print('Error: Invalid listHotels argument');
        }
      }

      );
    } else {
      // Handle the case where arguments are null or not a Map
      print('Error: No arguments found or invalid argument type');
    }
  }

  void _showHotelFilterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const HotellistingFilterBottomsheet();
      },
    );
  }

  void _showEditSearchModalBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return EditSearchBottomsheet(
          numberOfRooms: numberOfRooms,
          checkOutDate: checkOutDate ?? '',
          checkInDate: checkInDate ?? '',
          city: city ?? '',
        );
      },
    );

    // Check if result is not null and update the values
    if (result != null) {
      setState(() {
        checkInDate2 = result['checkInDate'] ?? checkInDate;
        listHotel2 = result['listHotels'] ?? listHotel;  // Update listHotels with the new search result
        numberOfRooms2 = result['numberOfRooms'] ?? numberOfRooms;
        checkOutDate2 = result['checkOutDate'] ?? checkOutDate;
        city2 = result['city'] ?? city;
        _pageKey = UniqueKey();
        print(result);
        // This will reload the page with the new data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (checkInDate != null && checkOutDate != null) {
      try {
        DateFormat dateFormat = DateFormat('dd/MM/yyyy');
        DateTime checkIn = dateFormat.parse(checkInDate!);
        DateTime checkOut = dateFormat.parse(checkOutDate!);

        setState(() {
          numberOfDays = checkOut.difference(checkIn).inDays;
        });
      } catch (e) {
        print('Error parsing dates: $e');
      }
    }
    return SafeArea(
      child: Scaffold(
        key: _pageKey,
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  _buildContent(context),
                  _buildFiltersort(context),
                  SizedBox(
                    width: double.maxFinite,
                    child: Divider(),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Center(  // Center widget here
                            child: Column(
                              children: [
                                SizedBox(height: 240.h),
                                Text(
                                  'Không tìm thấy khách sạn bạn muốn tìm',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Customize as needed
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
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
          text: "Kết quả tìm kiếm",
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
                (checkInDate2?.isNotEmpty ?? false) ? checkInDate2.toString() : checkInDate.toString(),
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
              (numberOfRooms2 != 0) ? numberOfRooms2.toString() : numberOfRooms.toString(),
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
              onTap: () async {
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

}
