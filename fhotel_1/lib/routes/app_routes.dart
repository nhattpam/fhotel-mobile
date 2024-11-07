import 'package:fhotel_1/views/change_password/change_password.dart';
import 'package:fhotel_1/views/choose_room/choose_room.dart';
import 'package:fhotel_1/views/edit_user_profile/edit_user_profile.dart';
import 'package:fhotel_1/views/home_hotel_region_empty/home_hotel_region_empty.dart';
import 'package:fhotel_1/views/hotel_detail_facilities_screen/hotel_detail_facilities_screen.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/hotel_listing_nearby_screen.dart';
import 'package:fhotel_1/views/hotel_rating_and_reviews/hotel_rating_and_reviews.dart';
import 'package:fhotel_1/views/list_hotel_by_search/list_hotel_by_search_empty.dart';
import 'package:fhotel_1/views/login_screen/login_screen.dart';
import 'package:fhotel_1/views/otp_signup_screen/otp_signup_screen.dart';
import 'package:fhotel_1/views/register_fill_information/register_fill_information.dart';
import 'package:fhotel_1/views/register_screen/register_screen.dart';
import 'package:fhotel_1/views/service_listing_screen/service_listing_screen.dart';
import 'package:fhotel_1/views/successful_payment_screen/successful_payment_screen.dart';
import 'package:fhotel_1/views/user_profile/user_profile.dart';
import 'package:flutter/material.dart';

import '../views/hotel_detail/widgets/carousel_item_widget.dart';
import '../views/list_hotel_by_search/list_hotel_by_search.dart';
import '../views/list_room_by_search/list_room_by_search.dart';
import '../views/tabbar_booking_and_service/tabbar_booking_and_service.dart';
import '../views/user_edit_bank_account/user_edit_bank_account.dart';

class AppRoutes {
  ///Navigation bar
  static const String initialRoute = '/initialRoute';
  static const String registerPage = '/register_screen';
  static const String registerFillInformation = '/register_fill_information';
  static const String otpScreen = '/otp_signup_screen.dart';
  static const String homePage = '/home_hotel_region_empty';
  static const String servicePage = '/service_listing_screen';
  static const String myOrderPageAndServicePage = '/tabbar_booking_and_service';
  static const String userPage = '/user_profile';

  // static const String homeDestination = '/homeDestination';

  ///Hotel widgets
  static const String hotelListing = '/hotelListing';
  static const String hotelListingBySearch = '/hotelListingBySearch';
  static const String hotelListingBySearchEmpty = '/hotelListingBySearchEmpty';
  static const String hotelDetail = '/carousel_item_widget';
  static const String hotelRatingAndReviews = '/hotel_rating_and_reviews';
  static const String hotelFacilities = '/hotel_detail_facilities_screen';

  ///Room widgets
  static const String roomListing = '/choose_room';
  static const String roomListingBySearch = '/choose_room_by_search';

  ///Guest fill information
  // static const String guestInformation = '/guest_information_book';
  // static const String guestCheckout = '/checkout';
  static const String guestPayment = '/successful_payment_screen';
  static const String userProfile = '/edit_user_profile';
  static const String userChangePassword = '/change_password';
  static const String userChangeBank = '/user_edit_bank_account';
  static Map<String, WidgetBuilder> routes = {
    ///Navigation bar
    initialRoute: (context) => LoginScreen(),
    registerPage: (context) => RegisterScreen(),
    registerFillInformation: (context) => RegisterFillInformation(),
    otpScreen: (context) => OTPScreen(),
    homePage: (context) => HomeHotelRegionEmptyScreen(),
    servicePage: (context) => ServiceListingScreen(),
    myOrderPageAndServicePage: (context) => TabbarBookingAndService(),
    userPage: (context) => UserProfileScreen(),

    ///Hotel widgets
    // homeDestination: (context) => HomeDestinationDefaultBottomsheet(),
    hotelListing: (context) => HotelListingNearbyScreen(),
    hotelListingBySearch: (context) => ListHotelBySearch(),
    hotelListingBySearchEmpty: (context) => ListHotelBySearchEmpty(),
    hotelDetail: (context) => HotelDetailScreen(),
    hotelRatingAndReviews: (context) => HotelDetailsRatingsReviewsScreen(),
    hotelFacilities: (context) => HotelDetailsFacilitiesScreen(),

    ///Room widgets
    roomListing: (context) => ChooseRoomFullScreen(),
    roomListingBySearch: (context) => ListRoomBySearch(),

    ///Guest fill information
    // guestInformation: (context) => GuestInformationBookForOthersScreen(),
    // guestCheckout: (context) => CheckoutScreen(),
    guestPayment: (context) => SuccessfulPaymentScreen(),
    userProfile: (context) => EditProfileScreen(),
    userChangePassword: (context) => ChangePasswordScreen(),
    userChangeBank: (context) => UserEditBankAccount(),
  };
}
