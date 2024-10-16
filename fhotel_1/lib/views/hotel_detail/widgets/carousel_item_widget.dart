import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/presenters/hotel_detail_presenter.dart';
import 'package:fhotel_1/views/home_hotel_region_empty/widgets/carouselunit_item_widget.dart';
import 'package:fhotel_1/views/hotel_detail/hotel_detail_view.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../data/models/hotel.dart';
import '../../../data/models/hotel_amenity.dart';
import '../../hotel_edit_search/hotel_edit_search.dart';

class HotelDetailScreen extends StatefulWidget {

  @override
  HotelDetailScreenState createState() => HotelDetailScreenState();
}

class HotelDetailScreenState extends State<HotelDetailScreen>
    with TickerProviderStateMixin implements HotelDetailView{

  int sliderIndex = 1;
  late TabController tabviewController;

  // GlobalKeys for sections
  final GlobalKey overviewKey = GlobalKey();
  final GlobalKey reviewsKey = GlobalKey();
  final GlobalKey amenitiesKey = GlobalKey();
  final GlobalKey descriptionKey = GlobalKey();

  late HotelDetailPresenter _presenter;
  bool _isLoading = false;
  Hotel? _hotel;
  String? _error;
  late String hotelId;

  List<HotelAmenity> _amenities = [];

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
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the arguments passed safely in didChangeDependencies
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    hotelId = args['hotelId'];

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
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return  EditSearchBottomsheet();
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
                              ?  const SizedBox(
                                width: 350,
                                child:  Skeleton(width: 350, height: 150),
                              )
                              : GestureDetector(
                                onTap: () {
                                  _showZoomableImageDialog(
                                      context, _hotel?.image.toString() ?? ''); // Open zoomable dialog
                                },
                                child: Container(
                                  width: 350,
                                  child: Image.network(
                                    _hotel?.image.toString() ?? '',
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
                                                  initialRating: _hotel?.star?.toDouble() ?? 0,
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
                                                      _hotel?.description.toString() ?? '',
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
                                      child: _buildGridView(context)
                                    )
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
                                    )
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
                                              "Nảm dọc theo bãi biển Mỹ Khê cát trắng trải dài thơ mộng, khu nghỉ dưỡng dành cho gia đình sang trọng bật nhất thế giới Premier Village Danang được ưu ái tọa lạc ở vị trí đặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệtđặc biệt",
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
          onTap: (){
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
                "02/02/2022",
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
              "2",
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
              "2",
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

  Widget _buildSheetheader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 4.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 100.h),
              child: Text(
                "Chi tiết khách sạn",
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
          ),
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
          _amenities[index].image.toString(),// Replace with your image asset path
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
            context, AppRoutes.roomListing,
          arguments: {
            'hotelId': _hotel?.hotelId.toString(),
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
      _isLoading = false;
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
}
