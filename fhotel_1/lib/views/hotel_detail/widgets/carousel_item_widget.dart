import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/cancellation_policy.dart';
import 'package:fhotel_1/data/models/feedback.dart';
import 'package:fhotel_1/data/models/hotel_image.dart';
import 'package:fhotel_1/data/models/late_checkout_policy.dart';
import 'package:fhotel_1/data/models/refund_policy.dart';
import 'package:fhotel_1/data/repository/late_checkout_policy_repo.dart';
import 'package:fhotel_1/data/repository/refund_policy_repo.dart';
import 'package:fhotel_1/presenters/cancellation_policy_presenter.dart';
import 'package:fhotel_1/presenters/hotel_detail_presenter.dart';
import 'package:fhotel_1/presenters/late_checkout_policy_presenter.dart';
import 'package:fhotel_1/presenters/refund_policy_presenter.dart';
import 'package:fhotel_1/views/hotel_detail/cancellation_policy_view.dart';
import 'package:fhotel_1/views/hotel_detail/hotel_detail_view.dart';
import 'package:fhotel_1/views/hotel_detail/late_checkout_policy_view.dart';
import 'package:fhotel_1/views/hotel_detail/refund_policy_view.dart';
import 'package:fhotel_1/views/hotel_detail/widgets/list_hotel_image_widget.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/list_hotel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;

import '../../../core/app_export.dart';
import '../../../data/models/hotel.dart';
import '../../../data/models/hotel_amenity.dart';

class HotelDetailScreen extends StatefulWidget {
  @override
  HotelDetailScreenState createState() => HotelDetailScreenState();
}

class HotelDetailScreenState extends State<HotelDetailScreen>
    with TickerProviderStateMixin
    implements
        HotelDetailView,
        CancellationPolicyView,
        ListHotelView {
  int sliderIndex = 1;
  late TabController tabviewController;

  // GlobalKeys for sections
  final GlobalKey overviewKey = GlobalKey();
  final GlobalKey reviewsKey = GlobalKey();
  final GlobalKey amenitiesKey = GlobalKey();
  final GlobalKey descriptionKey = GlobalKey();

  late HotelDetailPresenter _presenter;
  late CancellationPolicyPresenter _policyPresenter;
  bool _isLoading = false;
  Hotel? _hotel;
  CancellationPolicy? _cancellationPolicy;
  String? _error;
  late String hotelId;
  String? checkInDate;
  String? checkOutDate;
  int numberOfRooms = 0;
  int? numberOfDays;

  List<HotelAmenity> _amenities = [];
  List<Feedbacks> _feedbacks = [];

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
    _policyPresenter = CancellationPolicyPresenter(this);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Retrieve the arguments passed safely in didChangeDependencies
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    hotelId = args['hotelId'] as String;
    checkInDate = args['checkInDate'] as String;
    checkOutDate = args['checkOutDate'] as String;
    numberOfRooms = args['numberOfRooms'] as int;
    // Fetch the hotel details using the presenter
    await _presenter.getHotelById(hotelId);
    _presenter.getHotelAmenities(hotelId);
    _presenter.getHotelFeedbacks(hotelId);
    _policyPresenter.getCancellationPolicyByHotelId(hotelId);
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
    String cancellationTime = (_cancellationPolicy?.cancellationTime).toString();
    String cancellationDay = (_cancellationPolicy?.cancellationDays).toString();

    String refundPercentage = (_cancellationPolicy?.refundPercentage).toString();
    // String refundPercentageAfter9PM =
    //     _refundPolicies[1].refundPercentage.toString();
    //
    // String descriptionBefore9PM = _refundPolicies[0].description.toString();
    // String descriptionAfter9PM = _refundPolicies[1].description.toString();
    //
    // String policyAfter6PM = _policies[0].description.toString();
    // String policyBetween6PM = _policies[1].description.toString();
    // String policyBetween2PM = _policies[2].description.toString();
    //
    // String chargePercentageAfter6PM = _policies[0].chargePercentage.toString();
    // String chargePercentageBetween6PM =
    //     _policies[1].chargePercentage.toString();
    // String chargePercentageBetween2PM =
    //     _policies[2].chargePercentage.toString();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            child: html.Html(
              data: """
            <section>
                    <h4>Điều khoản và điều kiện chung</h4>
                    <ul>
                        <li>Khách chính phải trên 16 tuổi mới được nhận phòng tại khách sạn.</li>
                        <li>
                            Khách phải xuất trình giấy tờ tùy thân có ảnh hợp lệ khi nhận phòng. Các loại giấy tờ tùy thân được chấp nhận bao gồm:
                            <ul>
                                <li>Chứng minh nhân dân</li>
                                <li>Giấy phép lái xe</li>
                                <li>Hộ chiếu</li>
                            </ul>
                            Nếu không có ID hợp lệ, sẽ không được phép làm thủ tục nhận phòng.
                        </li>
                        <li>Khách sạn có quyền thực hiện hành động chống lại khách có hành vi không phù hợp sau khi điều tra.</li>
                        <li>Khách phải chịu trách nhiệm về mọi thiệt hại, ngoại trừ hao mòn thông thường, đối với tài sản của khách sạn. Phòng phải được giữ sạch sẽ và vệ sinh.</li>
                        <li>Khách có thể được liên hệ trước khi nhận phòng để xác nhận tình trạng hoặc thời gian đến. Nếu không liên lạc được, đặt phòng có thể bị giữ lại hoặc hủy bỏ.</li>
                        <li>FHotel có thể liên hệ với khách hàng để xin phản hồi nhằm cải thiện dịch vụ.</li>
                    </ul>
                </section>

                <section>
                    <h4>Chính sách gia hạn đặt phòng</h4>
                    <ul>
                        <li>Việc gia hạn đặt phòng tùy thuộc vào tình trạng phòng trống và giá phòng hiện tại, có thể khác với giá ban đầu.</li>
                    </ul>
                </section>

                <section>
                    <h4>Chính sách hủy bỏ</h4>
                    <p>Hủy đặt phòng FHotel nhanh chóng và dễ dàng. Dưới đây là thông tin chi tiết:</p>
                    <ul>
                        <li>Thời gian nhận phòng tiêu chuẩn là 2 giờ chiều và bạn có thể nhận phòng bất cứ lúc nào sau đó trong khi đặt phòng của bạn vẫn còn hiệu lực.</li>
                        <li>
                            <strong>Trước khi nhận phòng:</strong> Nếu hủy phòng $cancellationDay ngày trước ngày nhận phòng, trước $cancellationTime giờ sáng. Số tiền đặt phòng sẽ được hoàn $refundPercentage%.
                        </li>
                        <li>
                            <strong>Vào ngày nhận phòng:</strong> Nếu bạn hủy hoặc không đến, toàn bộ số tiền đặt phòng sẽ không được hoàn lại.
                        </li>
                    </ul>
                </section>

                <section>
                    <h4>Chính sách đặt phòng</h4>
                    <ul>
                        <li>Chỉ được đặt trong 3 vòng tháng</li>
                        <li>Nếu đặt nhiều hơn 2 phòng thì phải thanh toán trước</li>
                    </ul>
                </section>
                
                <section>
                    <h4>Chính sách thanh toán</h4>
                    <ul>
                        <li>Đối với kỳ nghỉ trên 7 đêm, bắt buộc thanh toán trước.</li>
                    </ul>
                </section>

                <section>
                    <h4>Trả phòng trễ</h4>
                        <strong>Giờ trả phòng phí</strong>
                        <ul>
                        <li>12 PM - 2 PM Miễn phí</li>
                        <li>2PM trở đi 100% của tỷ giá ngày hôm sau</li>
                       </ul>
                </section>

                <section>
                    <h4>Chính sách cụ thể của khách sạn</h4>
                    <ul>
                        <li>Tiện nghi và chính sách được liệt kê trên ứng dụng. Vui lòng xem lại trước khi đặt phòng.</li>
                        <li>Một số khách sạn có thể hạn chế khách vào phòng. Xác nhận với khách sạn trước khi mời khách.</li>
                    </ul>
                </section>
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
  // <ul>
  // <li>$descriptionBefore9PM	| Hủy miễn phí ($cancellationTimeBefore9PM, hoàn lại $refundPercentageBefore9PM%).</li>
  // <li>$descriptionAfter9PM	| $cancellationTimeAfter9PM, hoàn lại $refundPercentageAfter9PM%</li>
  // </ul>
  // <ul>
  // <li>$policyBetween2PM: Miễn phí ($chargePercentageBetween2PM%).</li>
  // <li>$policyBetween6PM: Tính phí $chargePercentageBetween6PM% theo giá phòng ngày tiếp theo.</li>
  // <li>$policyAfter6PM: Tính phí $chargePercentageAfter6PM% theo giá phòng ngày tiếp theo.</li>
  // </ul>

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
    String description = (_hotel?.description).toString();
    print((_cancellationPolicy?.cancellationPolicyId).toString());
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
                              ListHotelImageWidget(hotelId: hotelId),
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
                                    _hotel?.hotelName != null
                                        ? Text(
                                            _hotel?.hotelName.toString() ?? '',
                                            style: theme.textTheme.titleMedium,
                                          )
                                        : Skeleton(
                                            width: 200.h,
                                            height: 20.h,
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
                                                _hotel?.district?.city
                                                            ?.cityName !=
                                                        null
                                                    ? Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: SizedBox(
                                                          width: 260.h,
                                                          child: Text(
                                                            "${_hotel?.address}, ${_hotel?.district?.districtName}, ${_hotel?.district?.city?.cityName}",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                              height: 1.50,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: SizedBox(
                                                            width: 260.h,
                                                            child: Skeleton(
                                                              width: 260.h,
                                                              height: 50.h,
                                                            )),
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
                                                                .hotelRatingAndReviews,
                                                            arguments: {
                                                              "listHotels":
                                                                  _feedbacks,
                                                            });
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
                                              _feedbacks.length != 0
                                              ? SizedBox(
                                                width: double.maxFinite,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "4,6/5",
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
                                                          _feedbacks.isNotEmpty
                                                              ? Text(
                                                                  "từ ${_feedbacks.length} lượt đánh giá",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodySmall,
                                                                )
                                                              : Skeleton(
                                                                  width: 170.h,
                                                                  height: 10.h,
                                                                )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 14.h),
                                _feedbacks.isNotEmpty
                                    ? _buildColumndescripti(context)
                                    : (_feedbacks.isEmpty && _feedbacks.length == 0)
                                    ? Center(
                                  child: Text(
                                    "Khách sạn này chưa có đánh giá",
                                    style: theme.textTheme.titleMedium, // You can customize this style as needed
                                  ),
                                )
                                    : Container(
                                  width: 488.h,
                                  margin: EdgeInsets.only(left: 14.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
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
                                        height: 100.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 2,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              child: Padding(
                                                padding: EdgeInsets.only(right: 8.h),
                                                child: Container(
                                                  width: 200.h,
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
                                                      Skeleton(
                                                        width: 100.h,
                                                        height: 15.h,
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Skeleton(
                                                        width: 100.h,
                                                        height: 15.h,
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Skeleton(
                                                        width: 200.h,
                                                        height: 30.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                                    _amenities.isNotEmpty
                                        ? SizedBox(
                                            width: double.maxFinite,
                                            height: 120,
                                            child: _buildGridView(context))
                                        : SizedBox(
                                            width: double.maxFinite,
                                            height: 120,
                                            child: GridView.builder(
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3, // Adjust the number of columns
                                                childAspectRatio: 3, // Adjust the aspect ratio if necessary
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                              ),
                                              itemCount: 9, // Number of items in the grid
                                              itemBuilder: (context, index) {
                                                return Skeleton(
                                                  width: 7.h,
                                                  height: 10.h,
                                                );
                                              },
                                            ))
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
                                                  "14:00 chiều",
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
                                                  "trước 12:00 trưa",
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
                                          'Xem chính sách',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 20),
                                        ),
                                        onTap: () => {
                                              _showGuestPolicyModalBottomSheet(
                                                  context)
                                            }),
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
                                    Container(
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: appTheme.whiteA700,
                                      ),
                                      child: Column(
                                        children: [
                                          html.Html(
                                            data: """
                                             $description
                                            """,
                                            style: {
                                              "body": html.Style(
                                                  maxLines: 5,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
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
          height: 100.h,
          // Set a fixed height for the horizontal scroll view if necessary
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _feedbacks.length, // Specify the number of items
            itemBuilder: (context, index) {
              return SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.h),
                  // Add spacing between items
                  child: Container(
                    width: 200.h, // Set a fixed width for each item
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
                          (_feedbacks[index].reservation?.customer?.name)
                              .toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          // Change based on index
                          style: theme.textTheme.bodySmall,
                        ),
                        SizedBox(height: 4.h),
                        CustomRatingBar(
                          color: Colors.yellow,
                          ignoreGestures: true,
                          initialRating:
                              (_feedbacks[index].hotelRating)?.toDouble(),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          (_feedbacks[index].comment).toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
          (_amenities[index].amenity?.image).toString(),
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
      height: 57.h,
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
    setState(() {});
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
  }

  @override
  void showFeedbacks(List<Feedbacks> feedbacks) {
    setState(() {
      _feedbacks = feedbacks;
    });
  }

  @override
  void onGetCancellationPolicyError(String error) {
    // TODO: implement onGetCancellationPolicyError
  }

  @override
  void onGetCancellationPolicySuccess(CancellationPolicy cancellation) {
    // TODO: implement onGetCancellationPolicySuccess
    setState(() {
      _cancellationPolicy = cancellation;
    });
  }
}
