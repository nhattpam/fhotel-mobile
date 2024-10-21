import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/late_checkout_policy.dart';
import 'package:fhotel_1/data/models/refund_policy.dart';
import 'package:fhotel_1/data/repository/late_checkout_policy_repo.dart';
import 'package:fhotel_1/data/repository/refund_policy_repo.dart';
import 'package:fhotel_1/presenters/hotel_detail_presenter.dart';
import 'package:fhotel_1/presenters/late_checkout_policy_presenter.dart';
import 'package:fhotel_1/presenters/refund_policy_presenter.dart';
import 'package:fhotel_1/views/hotel_detail/hotel_detail_view.dart';
import 'package:fhotel_1/views/hotel_detail/late_checkout_policy_view.dart';
import 'package:fhotel_1/views/hotel_detail/refund_policy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;

import '../../../core/app_export.dart';
import '../../../data/models/hotel.dart';
import '../../../data/models/hotel_amenity.dart';
import '../../hotel_edit_search/hotel_edit_search.dart';

class HotelDetailScreen extends StatefulWidget {
  @override
  HotelDetailScreenState createState() => HotelDetailScreenState();
}

class HotelDetailScreenState extends State<HotelDetailScreen>
    with TickerProviderStateMixin
    implements HotelDetailView, LateCheckoutPolicyView, RefundPolicyView {
  int sliderIndex = 1;
  late TabController tabviewController;

  // GlobalKeys for sections
  final GlobalKey overviewKey = GlobalKey();
  final GlobalKey reviewsKey = GlobalKey();
  final GlobalKey amenitiesKey = GlobalKey();
  final GlobalKey descriptionKey = GlobalKey();

  late HotelDetailPresenter _presenter;
  late LateCheckoutPolicyPresenter _policyPresenter;
  late RefundPolicyPresenter _policyRefundPresenter;
  bool _isLoading = false;
  Hotel? _hotel;
  String? _error;
  late String hotelId;
  String? checkInDate;
  String? checkOutDate;
  int numberOfRooms = 0;
  int? numberOfDays;

  List<HotelAmenity> _amenities = [];
  List<LateCheckOutPolicy> _policies = [];
  List<RefundPolicy> _refundPolicies = [];

  @override
  void initState() {
    super.initState();

    tabviewController = TabController(length: 4, vsync: this);
    tabviewController.addListener(() {
      switch (tabviewController.index) {
        case 0:
          _scrollToSection(overviewKey);
          break;
        case 1:
          _scrollToSection(reviewsKey);
          break;
        case 2:
          _scrollToSection(amenitiesKey);
          break;
        case 3:
          _scrollToSection(descriptionKey);
          break;
      }
    });
    _presenter = HotelDetailPresenter(this);
    _policyPresenter = LateCheckoutPolicyPresenter(this, LateCheckoutPolicyRepo());
    _policyPresenter.getLateCheckOutPolicies();
    _policyRefundPresenter = RefundPolicyPresenter(this, RefundPolicyRepo());
    _policyRefundPresenter.getRefundPolicies();
  }

  @override
  void didChangeDependencies()  {
    super.didChangeDependencies();

    // Retrieve the arguments passed safely in didChangeDependencies
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    hotelId = args['hotelId'];
    checkInDate = args['checkInDate'] as String;
    checkOutDate = args['checkOutDate'] as String;
    numberOfRooms = args['numberOfRooms'] as int;
    // Fetch the hotel details using the presenter
    _presenter.getHotelById(hotelId);
    _presenter.getHotelAmenities(hotelId);

  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(seconds: 1), curve: Curves.easeOut);
    }
  }

  void _showEditSearchModalBottomSheet(BuildContext context) {
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return EditSearchBottomsheet();
    //   },
    // );
  }
  void _showGuestPolicyModalBottomSheet(BuildContext context) {
    String cancellationTimeBefore9PM = _refundPolicies[0].cancellationTime.toString();
    String cancellationTimeAfter9PM = _refundPolicies[1].cancellationTime.toString();

    String refundPercentageBefore9PM = _refundPolicies[0].refundPercentage.toString();
    String refundPercentageAfter9PM = _refundPolicies[1].refundPercentage.toString();

    String descriptionBefore9PM = _refundPolicies[0].description.toString();
    String descriptionAfter9PM = _refundPolicies[1].description.toString();

    String policyAfter6PM = _policies[0].description.toString();
    String policyBetween6PM = _policies[1].description.toString();
    String policyBetween2PM = _policies[2].description.toString();

    String chargePercentageAfter6PM = _policies[0].chargePercentage.toString();
    String chargePercentageBetween6PM = _policies[1].chargePercentage.toString();
    String chargePercentageBetween2PM = _policies[2].chargePercentage.toString();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            // Your modal bottom sheet content here
            child: html.Html(
              data: """
              <h2>Guest Policies</h2>

              <h3>General Terms and Conditions</h3>

              <ul>
                <li>The primary guest must be above the age of 16 years to be able to check-in the hotel.</li>
                <li>It is mandatory for guests to present a valid photo identification document at the time of check-in. The identification proofs accepted are National ID card (Chung Minh Nhan Dan), Driving License, or Passport. Without the original copy of a valid ID, the guest will not be allowed to check-in.</li>
                <li>Stay of 1 child up to the age of 5 years is complimentary without the use of an extra bed. Breakfast charges may still be applicable for the child.</li>
                <li>Pets are not allowed in the hotel premises.</li>
                <li>Should any action by a guest be deemed inappropriate by the hotel or if any inappropriate behaviour is brought to the attention of the hotel staff, the hotel reserves the right to take action against the guest after the allegations have been investigated.</li>
                <li>A discounted booking cannot be modified. Additionally, in the case of an early check-out for such a booking, the booking amount paid cannot be refunded.</li>
                <li>Our hotels in certain destinations may have different policies applicable for specific times during the year.</li>
                <li>Guests shall be liable for any damage, except normal wear and tear to Hotel assets. Guests shall keep the Hotel room in a good condition and maintain hygiene and cleanliness.</li>
                <li>Certain policies are booking specific and are informed to the customer while making the booking.</li>
                <li>Guests may be contacted closer to their check-in date to confirm their arrival status or arrival time through calls or messages. In case we do not receive a response from the guest after multiple attempts, the booking may be put on hold or cancelled. In case of availability, the hotel will try to reinstate your booking when you contact us back or make a payment through our payment options.</li>
                <li>As we continue to strive to improve our services, we may reach out to guests to get feedback on their experience through calls or messages.</li>
              </ul>

              <h3>Booking Extension Policy</h3>

              <ul>
                <li>Extension of a booking would be provided at current room rates and is subject to availability.</li>
                <li>Current room rates can be different from the rates at which the rooms were first booked.</li>
              </ul>

              <h3>Cancellation Policy</h3>
              <h4>Cancelling an FHotel is as fast and easy as booking one</h4>
              
              <p>We would love to host you but in case your plans change, our simple cancellation process makes sure you receive a quick confirmation and fast refunds. Our standard check-in time is 2 PM and you can check-in any time after that till your reservation is valid. </p>

              <ul>
                <li>$descriptionBefore9PM	| Free cancellation ($cancellationTimeBefore9PM, $refundPercentageBefore9PM% refund).</li>
                <li>$descriptionAfter9PM	| $cancellationTimeAfter9PM, $refundPercentageAfter9PM% refund</li>
              </ul>
              
              <h4>Before check-in</h4>

              <p>We will fully refund any booking cancelled up to 24 hours prior to the scheduled check-in date. For any cancellation within 24 hours of scheduled check-in, the complete booking amount shall be deducted as cancellation charges.</p>
              <h4>On the date of check-in</h4>

              <p>In case you decide to cancel a booking after the scheduled check-in time or do not show up at the hotel, the complete booking amount shall be deducted as cancellation/no-show charges.</p>

              <h4>Mid-Stay Cancellations</h4>

              <p>During your stay, if you decide to shorten your booking before 2 pm, you will be charged for one night. If you decide to shorten your booking after 2 pm, you will be charged for the next two nights. Money paid for the remaining nights will be refunded as per the refund policy.</p>

              <h3>Payment Policy</h3>

              <p>For bookings of more than 7 nights, guests have to settle all outstanding payments on a weekly basis. The hotel will be unable to provide further accommodation prior to settlement of the outstanding amount.</p>

              <h3>Early Check-in and Late Check-out</h3>
              <h4>Early check-in (subject to availability)</h4>

              <p>Will incur extra charges depending on the time:</p>

              <ul>
                <li>Before 8 AM: 100% charges for one day payable as per room rates of the previous day.</li>
                <li>Between 8 AM and 12 PM: 30% charges payable as per room rates of the previous day, depending on hotel policy.</li>
                <li>Between 12 PM and 2 PM: Complimentary (no extra charge).</li>
              </ul>
              <h4>Late check-out (subject to availability))</h4>

              <p>May incur extra charges:</p>

              <ul>
                <li>$policyBetween2PM: Complimentary ($chargePercentageBetween2PM%).</li>
                <li>$policyBetween6PM: $chargePercentageBetween6PM% charges payable as per room rates of the next day.</li>
                <li>$policyAfter6PM: $chargePercentageAfter6PM% charges payable as per room rates of the next day.</li>
              </ul>

              <h3>Hotel Specific Policies</h3>

              <p>Hotel-specific amenities are captured on the website and app. Guests are advised to refer to the same before booking. Some hotels may deny entry of visitors to rooms, so it’s advisable to confirm with the hotel before inviting visitors into the rooms.</p>
            """,
              style: {
                "body": html.Style(
                    fontWeight: FontWeight.normal, color: Colors.black),
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    tabviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (checkInDate != null && checkOutDate != null) {
      try {
        DateFormat dateFormat = DateFormat('dd/MM/yyyy');
        // Parse the dates using the correct format
        DateTime checkIn = dateFormat.parse(checkInDate!);
        DateTime checkOut = dateFormat.parse(checkOutDate!);

        setState(() {
          numberOfDays = checkOut.difference(checkIn).inDays;
        });
        // Calculate the difference in days
      } catch (e) {
        print('Error parsing dates: $e');
      }
    }
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.gray10001,
              ),
              child: Column(
                children: [
                  _buildContent(context),
                  _buildFiltersort(context),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              SizedBox(height: 12.h),
                              _isLoading
                                  ? const SizedBox(
                                      width: 350,
                                      child: Skeleton(width: 350, height: 150),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        _showZoomableImageDialog(
                                            context,
                                            _hotel?.image.toString() ??
                                                'https://casf.com.au/wp-content/uploads/2022/01/silver_grey.png'); // Open zoomable dialog
                                      },
                                      child: Container(
                                        width: 350,
                                        child: Image.network(
                                          _hotel?.image.toString() ??
                                              'https://casf.com.au/wp-content/uploads/2022/01/silver_grey.png',
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                              Container(
                                key: overviewKey,
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.h,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 2.h),
                                    Text(
                                      _hotel?.hotelName.toString() ?? '',
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: appTheme.whiteA700,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 150.h,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.h,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: appTheme.gray100,
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Khách sạn",
                                                  style: CustomTextStyles
                                                      .bodySmallOnPrimary10,
                                                ),
                                                SizedBox(width: 4.h),
                                                CustomRatingBar(
                                                  color: Colors.yellow,
                                                  ignoreGestures: true,
                                                  initialRating: _hotel?.star
                                                          ?.toDouble() ??
                                                      0,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: appTheme.whiteA700,
                                            ),
                                            width: double.maxFinite,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomImageView(
                                                  color: appTheme.black900
                                                      .withOpacity(0.5),
                                                  imagePath: ImageConstant
                                                      .imgIconWrapperGray600,
                                                  height: 24.h,
                                                  width: 24.h,
                                                ),
                                                SizedBox(width: 8.h),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: SizedBox(
                                                    width: 260.h,
                                                    child: Text(
                                                      _hotel?.address
                                                              .toString() ??
                                                          '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: theme
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                        height: 1.50,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                key: reviewsKey,
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4.h),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.h),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: double.maxFinite,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Xếp hạng và đánh giá",
                                                      style: theme.textTheme
                                                          .titleMedium,
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      "Xem tất cả",
                                                      style: CustomTextStyles
                                                          .bodyMediumPrimary,
                                                    ),
                                                    CustomImageView(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            AppRoutes
                                                                .hotelRatingAndReviews);
                                                      },
                                                      color: Colors.blueAccent,
                                                      imagePath: ImageConstant
                                                          .imgArrowRight,
                                                      height: 20.h,
                                                      width: 20.h,
                                                      margin: EdgeInsets.only(
                                                          left: 8.h),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 18.h),
                                              SizedBox(
                                                width: double.maxFinite,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "8,6",
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          color:
                                                              Colors.blueAccent,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(width: 8.h),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: double
                                                                .maxFinite,
                                                            child: Row(
                                                              children: [
                                                                CustomImageView(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgImage24x24,
                                                                  height: 24.h,
                                                                  width: 24.h,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              8.h),
                                                                  child: Text(
                                                                    "Ấn tượng",
                                                                    style: CustomTextStyles
                                                                        .titleSmallBlue,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            "từ 288 lượt đánh giá",
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall,
                                                          )
                                                        ],
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
                                    SizedBox(height: 14.h),
                                    SizedBox(
                                      height: 28.h,
                                      width: 472.h,
                                      child: ListView.separated(
                                        padding: EdgeInsets.only(left: 16.h),
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            width: 8.h,
                                          );
                                        },
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return ChipTheme(
                                            data:
                                                ChipTheme.of(context).copyWith(
                                              backgroundColor: Colors.white,
                                              selectedColor: Colors.blue,
                                              disabledColor: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                  color: Colors.grey,
                                                  // Border color
                                                  width: 1, // Border width
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50), // Rounded corners
                                              ),
                                            ),
                                            child: const Chip(
                                              label: Text(
                                                "1 sao",
                                                textAlign: TextAlign.center,
                                              ),
                                              // selected: false,
                                              // onSelected: (bool selected) {},
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 14.h),
                                    _buildColumndescripti(context)
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                key: amenitiesKey,
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.h,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 6.h),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Tiện nghi",
                                            style: theme.textTheme.titleMedium,
                                          ),

                                          ///Xem tất cả tiện nghi
                                          // const Spacer(),
                                          // Text(
                                          //   "Xem tất cả",
                                          //   style: CustomTextStyles
                                          //       .bodyMediumPrimary,
                                          // ),
                                          // CustomImageView(
                                          //   onTap: () {
                                          //     Navigator.pushNamed(context,
                                          //         AppRoutes.hotelFacilities);
                                          //   },
                                          //   color: Colors.blueAccent,
                                          //   imagePath:
                                          //       ImageConstant.imgArrowRight,
                                          //   height: 20.h,
                                          //   width: 20.h,
                                          //   margin: EdgeInsets.only(left: 8.h),
                                          // )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 14.h),
                                    SizedBox(
                                        width: double.maxFinite,
                                        height: 120,
                                        child: _buildGridView(context))
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.h,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Giờ nhận phòng / trả phòng",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: appTheme.whiteA700,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: double.maxFinite,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomImageView(
                                                  color: appTheme.black900
                                                      .withOpacity(0.5),
                                                  imagePath: ImageConstant
                                                      .imgIconWrapper14,
                                                  height: 24.h,
                                                  width: 24.h,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.h),
                                                    child: Text(
                                                      "Nhận phòng",
                                                      style: theme
                                                          .textTheme.bodyMedium,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "15:00 - 03:00",
                                                  style: theme
                                                      .textTheme.titleSmall,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          SizedBox(
                                            width: double.maxFinite,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomImageView(
                                                  color: appTheme.black900
                                                      .withOpacity(0.5),
                                                  imagePath: ImageConstant
                                                      .imgIconWrapper14,
                                                  height: 24.h,
                                                  width: 24.h,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.h),
                                                    child: Text(
                                                      "Trả phòng",
                                                      style: theme
                                                          .textTheme.bodyMedium,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "trước 11:00",
                                                  style: theme
                                                      .textTheme.titleSmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    InkWell(
                                          child: new Text(
                                            'View Guest Policy',
                                            style: TextStyle(color: Colors.red, fontSize: 20),
                                          ),
                                          onTap: () => {
                                            _showGuestPolicyModalBottomSheet(context)
                                          }
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                key: descriptionKey,
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.h,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Mô tả khách sạn",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: appTheme.whiteA700,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 324.h,
                                            child: Text(
                                              _hotel?.description.toString() ??
                                                  '',
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: theme.textTheme.bodyMedium!
                                                  .copyWith(
                                                height: 1.50,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.h)
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              _buildSumsectionat(context),
                            ],
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
          text: "Chi tiết khách sạn",
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                checkInDate.toString(),
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
              numberOfRooms.toString(),
              style: CustomTextStyles.bodyMediumwhiteA700,
            ),
          ),
          CustomImageView(
            color: Colors.white,
            imagePath: ImageConstant.imgIconWrapper11,
            height: 24.h,
            width: 24.h,
            margin: EdgeInsets.only(left: 20.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "3",
              style: CustomTextStyles.bodyMediumwhiteA700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.h),
            child: CustomIconButton(
              onTap: () {
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

  Widget _buildColumndescripti(BuildContext context) {
    return Container(
      width: 488.h,
      margin: EdgeInsets.only(left: 14.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          children: [
            Text(
              "Đánh giá hàng đầu",
              maxLines: 1,
              textAlign: TextAlign.start,
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.gray10001,
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Khách sạn mới và đẹp, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. Xung...",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          height: 1.50,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Nguyen V.A.",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.h),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.gray10001,
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Khách sạn mới và đẹp, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. Xung ",
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          height: 1.50,
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Tran V.B.",
                        style: theme.textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust the number of columns
        childAspectRatio: 3, // Adjust the aspect ratio if necessary
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: _amenities.length, // Number of items in the grid
      itemBuilder: (context, index) {
        return Image.network(
          _amenities[index].image.toString(),
          // Replace with your image asset path
          width: 1, // Set the width of the image
          height: 1, // Set the height of the image
          // fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildSumsectionat(BuildContext context) {
    return Container(
      height: 115.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Giá phòng mỗi đêm từ",
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        "2.000.000 đ",
                        style: theme.textTheme.titleSmall,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(right: 14.h),
            child: Text(
              "Đã bao gồm thuế",
              style: theme.textTheme.bodySmall,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_buildChnphng(context)],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChnphng(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          AppRoutes.roomListing,
          arguments: {
            'hotelId': _hotel?.hotelId.toString(),
            'hotelName': _hotel?.hotelName.toString(),
            "checkInDate": checkInDate,
            "checkOutDate": checkOutDate,
            "numberOfRooms": numberOfRooms,
          },
        );
      },
      text: "Chọn phòng",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
    );
  }

  Widget _buildFiltersort(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      width: double.maxFinite,
      child: TabBar(
        controller: tabviewController,
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        labelColor: appTheme.blue600,
        labelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelColor: appTheme.gray600,
        unselectedLabelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        indicatorColor: appTheme.blue600,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: appTheme.black900.withOpacity(0.2),
        tabs: [
          const Tab(
            child: Text(
              "Tổng quan",
            ),
          ),
          const Tab(
            child: Text(
              "Đánh giá",
            ),
          ),
          const Tab(
            child: Text(
              "Tiện nghi",
            ),
          ),
          const Tab(
            child: Text(
              "Mô tả",
            ),
          )
        ],
      ),
    );
  }

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
    });
  }

  @override
  void showAmenities(List<HotelAmenity> amenities) {
    setState(() {
      _amenities = amenities;
    });
  }

  // Handle success: display hotel details
  @override
  void onGetHotelSuccess(Hotel hotel) {
    setState(() {
      _hotel = hotel;
      _isLoading = false;
      _error = null;
    });
  }

  // Handle error: display error message
  @override
  void onGetHotelError(String error) {
    setState(() {
      _error = error;
    });
  }

  @override
  void onGetLateCheckOutPoliciesError(String error) {
    setState(() {
      _error = error;
    });
  }

  @override
  void onGetLateCheckOutPoliciesSuccess(List<LateCheckOutPolicy> policies) {
    setState(() {
      _policies = policies;
      _error = null;
    });
  }

  @override
  void onGetRefundPoliciesError(String error) {
    // TODO: implement onGetRefundPoliciesError
  }

  @override
  void onGetRefundPoliciesSuccess(List<RefundPolicy> policies) {
    // TODO: implement onGetRefundPoliciesSuccess
    _refundPolicies = policies;
  }
}
