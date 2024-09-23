import 'package:fhotel_1/presentation/home_destination_default/home_destination_default.dart';
import 'package:fhotel_1/presentation/home_hotel_region_empty/home_hotel_region_empty.dart';
import 'package:fhotel_1/presentation/hotel_listing_nearby_screen/hotel_listing_nearby_screen.dart';
import 'package:flutter/material.dart';
class AppRoutes {
  static const String homePage = '/home_page';
  static const String initialRoute = '/initialRoute';
  static const String homeDestination = '/homeDestination';
  static const String hotelListing = '/hotelListing';

  static Map<String, WidgetBuilder> routes = {
    // homePage: (context) => HomePage(),
    initialRoute: (context) => HomeHotelRegionEmptyScreen(),
    homeDestination: (context) => HomeDestinationDefaultBottomsheet(),
    hotelListing: (context) => HotelListingNearbyScreen(),
  };
}
