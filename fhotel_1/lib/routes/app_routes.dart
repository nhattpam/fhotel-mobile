import 'package:fhotel_1/presentation/checkout/checkout.dart';
import 'package:fhotel_1/presentation/choose_room/choose_room.dart';
import 'package:fhotel_1/presentation/home_destination_default/home_destination_default.dart';
import 'package:fhotel_1/presentation/home_hotel_region_empty/home_hotel_region_empty.dart';
import 'package:fhotel_1/presentation/hotel_detail_facilities_screen/hotel_detail_facilities_screen.dart';
import 'package:fhotel_1/presentation/hotel_listing_nearby_screen/hotel_listing_nearby_screen.dart';
import 'package:fhotel_1/presentation/hotel_rating_and_reviews/hotel_rating_and_reviews.dart';
import 'package:fhotel_1/presentation/login_screen/login_screen.dart';
import 'package:fhotel_1/presentation/service_listing_screen/service_listing_screen.dart';
import 'package:fhotel_1/presentation/successful_payment_screen/successful_payment_screen.dart';
import 'package:fhotel_1/presentation/user_profile/user_profile.dart';
import 'package:flutter/material.dart';

import '../presentation/guest_information_book/guest_information_book.dart';
import '../presentation/hotel_detail/widgets/carousel_item_widget.dart';
import '../presentation/tabbar_booking_and_service/tabbar_booking_and_service.dart';
class AppRoutes {
  ///Navigation bar
  static const String initialRoute = '/initialRoute';
  static const String homePage = '/home_hotel_region_empty';
  static const String servicePage = '/service_listing_screen';
  static const String myOrderPageAndServicePage = '/tabbar_booking_and_service';
  static const String userPage = '/user_profile';

  static const String homeDestination = '/homeDestination';
  ///Hotel widgets
  static const String hotelListing = '/hotelListing';
  static const String hotelDetail = '/carousel_item_widget';
  static const String hotelRatingAndReviews = '/hotel_rating_and_reviews';
  static const String hotelFacilities = '/hotel_detail_facilities_screen';
  ///Room widgets
  static const String roomListing = '/choose_room';
  ///Guest fill information
  static const String guestInformation = '/guest_information_book';
  static const String guestCheckout = '/checkout';
  static const String guestPayment = '/successful_payment_screen';
  static Map<String, WidgetBuilder> routes = {
    ///Navigation bar
    initialRoute: (context) => LoginScreen(),
    homePage: (context) => HomeHotelRegionEmptyScreen(),
    servicePage: (context) => ServiceListingScreen(),
    myOrderPageAndServicePage: (context) => TabbarBookingAndService(),
    userPage: (context) => UserProfileScreen(),
    ///Hotel widgets
    homeDestination: (context) => HomeDestinationDefaultBottomsheet(),
    hotelListing: (context) => HotelListingNearbyScreen(),
    hotelDetail: (context) => CarouselItemWidget(),
    hotelRatingAndReviews: (context) => HotelDetailsRatingsReviewsScreen(),
    hotelFacilities: (context) => HotelDetailsFacilitiesScreen(),
    ///Room widgets
    roomListing: (context) => ChooseRoomFullScreen(),
    ///Guest fill information
    guestInformation: (context) => GuestInformationBookForOthersScreen(),
    guestCheckout: (context) => CheckoutScreen(),
    guestPayment: (context) => SuccessfulPaymentScreen(),

  };
}
