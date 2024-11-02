import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/hotel_image.dart';
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
    implements HotelDetailView, LateCheckoutPolicyView, RefundPolicyView, ListHotelView {
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
    _policyPresenter =
        LateCheckoutPolicyPresenter(this, LateCheckoutPolicyRepo());
    _policyPresenter.getLateCheckOutPolicies();
    _policyRefundPresenter = RefundPolicyPresenter(this, RefundPolicyRepo());
    _policyRefundPresenter.getRefundPolicies();
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
    String cancellationTimeBefore9PM =
    _refundPolicies[0].cancellationTime.toString();
    String cancellationTimeAfter9PM =
    _refundPolicies[1].cancellationTime.toString();

    String refundPercentageBefore9PM =
    _refundPolicies[0].refundPercentage.toString();
    String refundPercentageAfter9PM =
    _refundPolicies[1].refundPercentage.toString();

    String descriptionBefore9PM = _refundPolicies[0].description.toString();
    String descriptionAfter9PM = _refundPolicies[1].description.toString();

    String policyAfter6PM = _policies[0].description.toString();
    String policyBetween6PM = _policies[1].description.toString();
    String policyBetween2PM = _policies[2].description.toString();

    String chargePercentageAfter6PM = _policies[0].chargePercentage.toString();
    String chargePercentageBetween6PM =
    _policies[1].chargePercentage.toString();
    String chargePercentageBetween2PM =
    _policies[2].chargePercentage.toString();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            child: html.Html(
              data: """
              <h2>Chính Sách Khách</h2>

              <h3>Điều Khoản Và Điều Kiện Chung</h3>

              <ul>
                <li>Khách chính phải trên 16 tuổi để có thể nhận phòng tại khách sạn.</li>
                <li>Bắt buộc khách phải xuất trình giấy tờ tùy thân hợp lệ tại thời điểm nhận phòng. Các giấy tờ chấp nhận bao gồm Chứng minh nhân dân, Giấy phép lái xe hoặc Hộ chiếu. Nếu không có bản gốc của giấy tờ hợp lệ, khách sẽ không được nhận phòng.</li>
                <li>Miễn phí lưu trú cho 1 trẻ em dưới 5 tuổi nếu không sử dụng giường phụ. Có thể vẫn áp dụng phí ăn sáng cho trẻ em.</li>
                <li>Không cho phép thú cưng vào khu vực khách sạn.</li>
                <li>Khách sạn có quyền hành động đối với khách nếu hành vi của khách bị cho là không phù hợp sau khi đã điều tra cáo buộc.</li>
                <li>Không thể sửa đổi đối với các đặt phòng đã được chiết khấu. Trường hợp trả phòng sớm, số tiền đặt phòng đã thanh toán sẽ không được hoàn lại.</li>
                <li>Một số khách sạn ở các điểm đến khác nhau có thể áp dụng chính sách khác nhau vào các thời điểm nhất định trong năm.</li>
                <li>Khách phải chịu trách nhiệm cho bất kỳ thiệt hại nào, ngoại trừ hao mòn thông thường đối với tài sản của khách sạn. Khách phải giữ phòng khách sạn trong tình trạng tốt và duy trì vệ sinh và sạch sẽ.</li>
                <li>Một số chính sách áp dụng riêng cho từng đặt phòng và được thông báo cho khách khi thực hiện đặt phòng.</li>
                <li>Khách có thể được liên hệ gần đến ngày nhận phòng để xác nhận trạng thái hoặc thời gian đến của họ qua cuộc gọi hoặc tin nhắn. Nếu không nhận được phản hồi từ khách sau nhiều lần liên hệ, đặt phòng có thể bị tạm dừng hoặc hủy bỏ. Trong trường hợp có phòng trống, khách sạn sẽ cố gắng khôi phục đặt phòng khi khách liên hệ lại hoặc thanh toán qua các phương thức thanh toán của chúng tôi.</li>
                <li>Trong quá trình nỗ lực cải thiện dịch vụ, chúng tôi có thể liên hệ với khách để lấy ý kiến phản hồi về trải nghiệm của họ qua cuộc gọi hoặc tin nhắn.</li>
              </ul>

              <h3>Chính Sách Gia Hạn Đặt Phòng</h3>

              <ul>
                <li>Gia hạn đặt phòng sẽ được cung cấp theo mức giá phòng hiện tại và tùy thuộc vào tình trạng phòng trống.</li>
                <li>Giá phòng hiện tại có thể khác với giá khi đặt phòng ban đầu.</li>
              </ul>

              <h3>Chính Sách Hủy Đặt Phòng</h3>
              <h4>Hủy đặt phòng tại FHotel dễ dàng và nhanh chóng như đặt phòng</h4>
              
              <p>Chúng tôi mong muốn phục vụ bạn, nhưng trong trường hợp kế hoạch thay đổi, quy trình hủy đơn giản của chúng tôi đảm bảo bạn nhận được xác nhận nhanh chóng và hoàn tiền nhanh chóng. Thời gian nhận phòng tiêu chuẩn là 2 giờ chiều và bạn có thể nhận phòng bất kỳ lúc nào sau đó cho đến khi đặt phòng hợp lệ.</p>

              <ul>
                <li>$descriptionBefore9PM	| Hủy miễn phí ($cancellationTimeBefore9PM, hoàn lại $refundPercentageBefore9PM%).</li>
                <li>$descriptionAfter9PM	| $cancellationTimeAfter9PM, hoàn lại $refundPercentageAfter9PM%</li>
              </ul>
              
              <h4>Trước khi nhận phòng</h4>

              <p>Chúng tôi sẽ hoàn lại đầy đủ cho bất kỳ đặt phòng nào hủy trước thời gian 24 giờ so với ngày nhận phòng đã lên lịch. Đối với bất kỳ hủy nào trong vòng 24 giờ trước khi nhận phòng đã lên lịch, toàn bộ số tiền đặt phòng sẽ được trừ làm phí hủy.</p>
              <h4>Ngày nhận phòng</h4>

              <p>Trong trường hợp bạn quyết định hủy sau thời gian nhận phòng đã lên lịch hoặc không đến khách sạn, toàn bộ số tiền đặt phòng sẽ được trừ làm phí hủy/không đến.</p>

              <h4>Hủy giữa kỳ lưu trú</h4>

              <p>Trong thời gian lưu trú, nếu bạn quyết định rút ngắn đặt phòng trước 2 giờ chiều, bạn sẽ bị tính phí một đêm. Nếu bạn quyết định rút ngắn đặt phòng sau 2 giờ chiều, bạn sẽ bị tính phí hai đêm. Số tiền đã thanh toán cho các đêm còn lại sẽ được hoàn lại theo chính sách hoàn tiền.</p>

              <h3>Chính Sách Thanh Toán</h3>

              <p>Đối với các đặt phòng trên 7 đêm, khách phải thanh toán các khoản nợ hàng tuần. Khách sạn sẽ không cung cấp chỗ ở thêm nếu chưa thanh toán các khoản nợ.</p>

              <h3>Nhận Phòng Sớm và Trả Phòng Muộn</h3>
              <h4>Nhận phòng sớm (tùy thuộc vào tình trạng phòng trống)</h4>

              <p>Sẽ phát sinh phí bổ sung tùy theo thời gian:</p>

              <ul>
                <li>Trước 8 giờ sáng: Tính phí 100% cho một ngày theo giá phòng ngày trước.</li>
                <li>Từ 8 giờ sáng đến 12 giờ trưa: Tính phí 30% theo giá phòng ngày trước, tùy chính sách khách sạn.</li>
                <li>Từ 12 giờ trưa đến 2 giờ chiều: Miễn phí (không thu phí thêm).</li>
              </ul>
              <h4>Trả phòng muộn (tùy thuộc vào tình trạng phòng trống)</h4>

              <p>Có thể phát sinh phí bổ sung:</p>

              <ul>
                <li>$policyBetween2PM: Miễn phí ($chargePercentageBetween2PM%).</li>
                <li>$policyBetween6PM: Tính phí $chargePercentageBetween6PM% theo giá phòng ngày tiếp theo.</li>
                <li>$policyAfter6PM: Tính phí $chargePercentageAfter6PM% theo giá phòng ngày tiếp theo.</li>
              </ul>

              <h3>Chính Sách Đặc Thù của Khách Sạn</h3>

              <p>Các tiện nghi của khách sạn được liệt kê trên trang web và ứng dụng. Khách được khuyến khích tham khảo trước khi đặt phòng. Một số khách sạn có thể từ chối khách mời vào phòng, vì vậy nên xác nhận với khách sạn trước khi mời khách vào phòng.</p>
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
    String description = (_hotel?.description).toString();
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
                                                _hotel?.district?.city?.cityName != null
                                                ? Align(
                                                  alignment: Alignment.center,
                                                  child: SizedBox(
                                                    width: 260.h,
                                                    child: Text(
                                                      "${_hotel?.address}, ${_hotel?.district?.districtName}, ${_hotel?.district?.city?.cityName}",
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
                                                : Align(
                                                  alignment: Alignment.center,
                                                  child: SizedBox(
                                                    width: 260.h,
                                                    child: Skeleton(
                                                      width: 260.h,
                                                      height: 50.h,
                                                    )
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
          height: 100.h, // Set a fixed height for the horizontal scroll view if necessary
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3, // Specify the number of items
            itemBuilder: (context, index) {
              return SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.h), // Add spacing between items
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
                          "Nguyen Van A", // Change based on index
                          style: theme.textTheme.bodySmall,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Khách sạn mới và đẹp, gần biển đi lại thuận tiện nhân viên nhiệt tình và thân thiện. Xung...",
                          maxLines: 3,
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
}
