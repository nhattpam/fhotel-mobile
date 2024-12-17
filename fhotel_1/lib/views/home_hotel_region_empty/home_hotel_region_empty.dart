import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/hotel_image.dart';
import 'package:fhotel_1/data/repository/search_service.dart';
import 'package:fhotel_1/presenters/search_presenter.dart';
import 'package:fhotel_1/views/home_check_in_date_default/home_check_in_date_default.dart';
import 'package:fhotel_1/views/home_destination_default/home_destination_default.dart';
import 'package:fhotel_1/views/home_hotel_region_empty/location_view.dart';
import 'package:fhotel_1/views/home_hotel_region_empty/widgets/maincontent_item_widget.dart';
import 'package:fhotel_1/views/home_hotel_region_empty/widgets/maincontent_one_item_widget.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/list_hotel_view.dart';
import 'package:fhotel_1/views/hotel_listing_nearby_screen/search_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/app_export.dart';
import '../../data/models/hotel.dart';
import '../../data/models/search.dart';
import '../../data/repository/list_hotel_repo.dart';
import '../../presenters/list_hotel_presenter.dart';
import '../../presenters/location_presenter.dart';
import '../home_filter_bottomsheet/home_filter_bottomsheet.dart';
import '../home_room_guest_default/home_room_guest_default.dart';

class HomeHotelRegionEmptyScreen extends StatefulWidget {
  HomeHotelRegionEmptyScreen({Key? key}) : super(key: key);

  @override
  HomeHotelRegionEmptyScreenState createState() =>
      HomeHotelRegionEmptyScreenState();
}

class HomeHotelRegionEmptyScreenState extends State<HomeHotelRegionEmptyScreen>
    implements ListHotelView, SearchView, LocationView {
  int sliderIndex = 1;
  int _currentIndex = 0;
  String dateStarSelected = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String dateEndSelected = DateFormat('dd/MM/yyyy').format(DateTime.now().add(Duration(days: 1)));
  String dateStarSelectedForSearch = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dateEndSelectedForSearch = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)));
  List<Map<String, dynamic>> selectedRoomData = [];
  String _searchQuery = ''; // Add a variable to store the search query
  String _currentLocation = ''; // Add a variable to store the search query
  late SearchPresenter _searchPresenter;
  late HotelPresenter _presenter;
  late LocationPresenter _locationPresenter;
  bool _isLoading = false;
  List<Hotel> _hotels = [];
  List<Hotel> listHotels = [];
  String? _error;
  List<String> searchHistory = [];
  String roomType = ''; // Add a variable to store the search query
  int quantity = 0; // Add a variable to store the search query
  HotelImage? _hotelImage;
  List<Map<String, dynamic>> hotelSessions = [];
  List<String> distance = [];
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _presenter = HotelPresenter(this, ListHotelRepo());
    _presenter.getHotels(); // Fetch the list of hotels when the screen loads
    _searchPresenter = SearchPresenter(this, SearchService());
    _locationPresenter = LocationPresenter(this);
    _loadHotelSessions();
  }

  Future<void> _loadHotelSessions() async {
    final sessionManager = SessionManager();
    await sessionManager.init();
    // Retrieve the list of hotel sessions
    setState(() {
      hotelSessions = sessionManager.getHotelSessions();
    });
  }

  void _showModalBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return HomeDestinationDefaultBottomsheet();
      },
    );

    if (result != null && result.isNotEmpty) {
      print('User searched for: $result');
      setState(() {
        _searchQuery = result;
        searchHistory.add(result);
      });
    }
  }

  void _showCalendarModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return HomeCheckInDateDefaultBottomsheet(
          onDateStarSelected: (selectedDate) {
            if (selectedDate != null) {
              // Update the state with the selected date
              setState(() {
                // Format the date as desired, here I’m using the default DateTime format
                dateStarSelected = DateFormat('dd/MM/yyyy').format(selectedDate);
                dateStarSelectedForSearch = DateFormat('yyyy-MM-dd').format(selectedDate);
              });
            }
          },
          onDateEndSelected: (selectedDate) {
            if (selectedDate != null) {
              // Update the state with the selected date
              setState(() {
                // Format the date as desired, here I’m using the default DateTime format
                dateEndSelected = DateFormat('dd/MM/yyyy').format(selectedDate);
                dateEndSelectedForSearch = DateFormat('yyyy-MM-dd').format(selectedDate);
              });
            }
          },
        );
      },
    );
  }

  void _showRoomAndGuestModalBottomSheet(BuildContext context) async {
    // Await the result from the modal bottom sheet
    List<Map<String, dynamic>>? result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return HomeRoomGuestFilledBottomsheet();
      },
    );

    // Check if the result is not null (user didn't dismiss without selecting)
    if (result != null) {
      setState(() {
        selectedRoomData = result;
      });

      // You can also print or log the data to verify it:
      print("Selected Room Data: $selectedRoomData");
    }
  }

  void _showFilterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return HomeFilterBottomsheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Container(
                  // height: 700.h,
                  height: hotelSessions.isNotEmpty ? 760.h : 700.h,
                  decoration: BoxDecoration(
                    color: appTheme.gray10001,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _buildStackherobanner(context),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildColumniconwrapp(context),
                          SizedBox(height: 16.h),
                          if (hotelSessions.isNotEmpty) _buildSection(context),
                          SizedBox(height: 12.h),
                          // _buildSectionone(context),
                          Container(
                            height: 8.h,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: appTheme.gray10001,
                            ),
                          ),
                          _buildColumntitleone(context)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(context)));
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.homePage);
            break;
          case 1:
            Navigator.pushNamed(context, AppRoutes.servicePage);
            break;
          case 2:
            Navigator.pushNamed(context, AppRoutes.myOrderPageAndServicePage);
            break;
          case 3:
            Navigator.pushNamed(context, AppRoutes.userPage);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Khách sạn',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood_outlined),
          label: 'Dịch vụ',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.moneyBill1),
          label: 'Lịch sử',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Tôi',
        ),
      ],
      selectedFontSize: 12,
      selectedLabelStyle: CustomTextStyles.bodyLargeGray600,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.blue,
    );
  }

  Widget _buildStackherobanner(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 96.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgHerobanner,
              height: 96.h,
              width: double.maxFinite,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumniconwrapp(BuildContext context) {
    String selectedRoomInfo = selectedRoomData.isNotEmpty
        ? selectedRoomData.map((room) {
            setState(() {
              roomType = room['typeId'];
              quantity = room['quantity'];
            });
            return "Loại ${room['roomType']}, Số lượng: ${room['quantity']}";
          }).join("\n") // Concatenate room info
        : "Chọn loại phòng bạn muốn tìm"; // Default placeholder text

    List<RoomSearchRequest> searchRequests = selectedRoomData.map((room) {
      return RoomSearchRequest(
        typeId: room['typeId'],
        quantity: room['quantity'],
        checkInDate: dateStarSelectedForSearch,
        checkOutDate: dateEndSelectedForSearch,
      );
    }).toList();
    print(searchRequests);
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(children: [
        Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(16.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadiusStyle.roundedBorder8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: appTheme.blueGray50,
                              width: 1.h,
                            ),
                          ),
                        ),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgIconWrapperGray600,
                              height: 24.h,
                              width: 24.h,
                              color: appTheme.black900.withOpacity(0.5),
                            ),
                            SizedBox(width: 6.h),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Địa điểm, vị trí",
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    SizedBox(height: 6.h),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _showModalBottomSheet(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0, // Remove shadow/elevation
                                      ),
                                      child: Text(
                                        // Show the search query if it's not empty, otherwise show the hint text
                                        _searchQuery.isNotEmpty
                                            ? _searchQuery
                                            : "Nhập địa điểm, vị trí",
                                        style: _searchQuery.isNotEmpty
                                            ? CustomTextStyles
                                            .titleSmallGray600 // Style for search query
                                            : CustomTextStyles.titleSmallGray600
                                            .copyWith(
                                            color: Colors
                                                .grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 6.h),

                            ///Test current Location
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: CustomIconButton(
                                onTap: () async {
                                  await _locationPresenter.requestPermission();
                                  _locationPresenter.getCurrentLocation();
                                  setState(() {
                                    _searchQuery = _currentLocation;
                                  });
                                },
                                height: 24.h,
                                width: 24.h,
                                padding: EdgeInsets.all(4.h),
                                decoration: IconButtonStyleHelper.fillBlackTL12,
                                child: CustomImageView(
                                  imagePath:
                                      ImageConstant.imgIconWrapperBlueGray700,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant
                                        .imgIconWrapperGray60024x24,
                                    height: 24.h,
                                    width: 24.h,
                                    color: appTheme.black900.withOpacity(0.5),
                                    margin: EdgeInsets.only(top: 8.h),
                                  ),
                                  SizedBox(width: 8.h),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ngày nhận phòng:",
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                            SizedBox(height: 4.h),
                                            ElevatedButton(
                                              onPressed: () {
                                                _showCalendarModalBottomSheet(
                                                    context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                // Set background to transparent
                                                elevation:
                                                    0, // Remove shadow/elevation
                                              ),
                                              child: Text(
                                                dateStarSelected,
                                                style:
                                                    theme.textTheme.titleSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 18.0, top: 8),
                                    child: Container(
                                      height: 70.0,
                                      width: 1.0,
                                      color: Colors.black,
                                      // margin: const EdgeInsets.only(
                                      //     right: 10.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Ngày trả phòng:",
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                            SizedBox(height: 4.h),
                                            ElevatedButton(
                                              onPressed: () {
                                                _showCalendarModalBottomSheet(
                                                    context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                // Set background to transparent
                                                elevation:
                                                    0, // Remove shadow/elevation
                                              ),
                                              child: Text(
                                                dateEndSelected,
                                                style:
                                                    theme.textTheme.titleSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Số đêm nghỉ
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     SizedBox(height: 10.h),
                            //     Text(
                            //       "Sõ đêm nghỉ",
                            //       style: theme.textTheme.bodyMedium,
                            //     ),
                            //     SizedBox(height: 4.h),
                            //     ElevatedButton(
                            //       onPressed: () {
                            //         _showDurationModalBottomSheet(context);
                            //       },
                            //       style: ElevatedButton.styleFrom(
                            //         backgroundColor: Colors.transparent,
                            //         // Set background to transparent
                            //         elevation: 0, // Remove shadow/elevation
                            //       ),
                            //       child: Text(
                            //         "1 đêm",
                            //         style: theme.textTheme.titleSmall,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),

                      /// Ngày trả phòng dưới ngày nhận phòng
                      // SizedBox(height: 8.h),
                      // Container(
                      //   width: double.maxFinite,
                      //   margin: EdgeInsets.only(
                      //     left: 32.h,
                      //     right: 38.h,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         "Ngày trả phòng:",
                      //         style: theme.textTheme.bodySmall,
                      //       ),
                      //       SizedBox(width: 4.h),
                      //       Expanded(
                      //         child: Text(
                      //           dateEndSelected,
                      //           style: theme.textTheme.labelLarge,
                      //           maxLines: 1,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 8.h),
                      SizedBox(width: double.maxFinite, child: Divider()),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgIconWrapper24x24,
                                height: 24.h,
                                width: 24.h,
                                color: appTheme.black900.withOpacity(0.5),
                              ),
                              SizedBox(width: 8.h),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Số lượng phòng và loại phòng",
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: theme.colorScheme.onPrimary,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        ElevatedButton(
                                            onPressed: () {
                                              _showRoomAndGuestModalBottomSheet(
                                                  context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              // Set background to transparent
                                              elevation:
                                                  0, // Remove shadow/elevation
                                            ),
                                            child: Text(
                                              selectedRoomInfo,
                                              style: CustomTextStyles
                                                  .titleSmallGray600
                                                  .copyWith(
                                                color: appTheme.gray600,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // SizedBox(width: double.maxFinite, child: Divider()),
                      // SizedBox(
                      //   width: double.maxFinite,
                      //   child: _buildListmasterTwo(
                      //     context,
                      //     iconwrapper: ImageConstant.imgIconWrapper1,
                      //     labelfilterone: "Bộ lọc",
                      //     placeholderOne: "Chọn bộ lọc",
                      //   ),
                      // ),
                      SizedBox(height: 16.h),
                      CustomElevatedButton(
                        onPressed: () async {
                          listHotels.clear();
                          await _searchPresenter.searchListRoomTypes(
                              searchRequests, _searchQuery);
                             await _locationPresenter.requestPermission();
                             await _locationPresenter.calculateDistance(listHotels);
                             print(distance);
                              listHotels.isNotEmpty
                              /// Navigator to list hotel
                              ? Navigator.pushNamed(
                                  context,
                                  AppRoutes.hotelListingBySearch,
                                  arguments: {
                                    "listHotels": listHotels,
                                    "checkInDate": dateStarSelected,
                                    "checkOutDate": dateEndSelected,
                                    "numberOfRooms": quantity,
                                    "city": _searchQuery,
                                    "distance": distance
                                  },
                                )
                              : Navigator.pushNamed(
                                  context,
                                  AppRoutes.hotelListingBySearchEmpty,
                                  arguments: {
                                    "listHotels": listHotels,
                                    "checkInDate": dateStarSelected,
                                    "checkOutDate": dateEndSelected,
                                    "numberOfRooms": quantity,
                                    "city": _searchQuery,
                                  },
                                );
                        },
                        buttonStyle: CustomButtonStyles.fillBlue,
                        buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
                        text: "Tìm kiếm",
                      )
                    ],
                  ),
                )
              ],
            )),
      ]),
    );
  }

  Widget _buildSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(right: 16.h),
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tra cứu gần đây",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        "Xóa",
                        style: CustomTextStyles.bodyMediumPrimary
                            .copyWith(color: Colors.blue),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            height: 80.h,
            width: 344.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8.h,
                );
              },
              itemCount: hotelSessions.length,
              itemBuilder: (context, index) {
                final session = hotelSessions[index];
                return MaincontentItemWidget(
                  name: session['hotelName'],
                  address: session['address'],
                  checkInDate: dateStarSelected,
                  checkOutDate: dateEndSelected,
                  hotelId: session['hotelId'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  right: 292.h,
                ),
                child: Column(
                  children: [
                    Text(
                      "Ưu đãi",
                      style: theme.textTheme.titleMedium,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          // SizedBox(
          //   width: double.maxFinite,
          //   child: CarouselSlider.builder(
          //     options: CarouselOptions(
          //       height: 108.h,
          //       initialPage: 0,
          //       autoPlay: true,
          //       viewportFraction: 1.0,
          //       enableInfiniteScroll: true,
          //       scrollDirection: Axis.horizontal,
          //       onPageChanged: (index, reason) {
          //         setState(() {
          //           sliderIndex = index;
          //         });
          //       },
          //     ),
          //     itemCount: 5,
          //     itemBuilder: (context, index, realIndex) {
          //       return CarouselunitItemWidget();
          //     },
          //   ),
          // ),
          SizedBox(height: 14.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                  child: AnimatedSmoothIndicator(
                    activeIndex: sliderIndex,
                    count: 5,
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

  Widget _buildColumntitleone(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 14.h,
              right: 198.h,
            ),
            child: Column(
              children: [
                Text(
                  "Điểm đến phố biến",
                  style: theme.textTheme.titleMedium,
                )
              ],
            ),
          ),
          (_hotels.isNotEmpty)
              ? SizedBox(
                  height: 128.h,
                  width: 344.h,
                  child: ListView.separated(
                    cacheExtent: 1000,
                    padding: EdgeInsets.only(left: 14.h),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 8.h,
                      );
                    },
                    itemCount: _hotels.length,
                    itemBuilder: (context, index) {
                      return (_hotels[index].isActive ?? false)
                          ? MaincontentOneltemWidget(
                              hotelId: _hotels[index].hotelId.toString(),
                              image: '',
                              name: _hotels[index].hotelName.toString(),
                              rate: _hotels[index]?.star ?? 0,
                              description:
                                  _hotels[index].description.toString(),
                              checkInDate: dateStarSelected,
                              checkOutDate: dateEndSelected,
                            )
                          : const SizedBox();
                    },
                  ),
                )
              : SizedBox(
                  height: 128.h,
                  width: 344.h,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 14.h),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 8.h,
                      );
                    },
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Skeleton(
                        height: 128.h,
                        width: 150.h,
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildListmasterTwo(
    BuildContext context, {
    required String iconwrapper,
    required String labelfilterone,
    required String placeholderOne,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: iconwrapper,
            height: 24.h,
            width: 24.h,
            color: appTheme.black900.withOpacity(0.5),
          ),
          SizedBox(width: 8.h),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      labelfilterone,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    ElevatedButton(
                        onPressed: () {
                          _showFilterModalBottomSheet(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          // Set background to transparent
                          elevation: 0, // Remove shadow/elevation
                        ),
                        child: Text(
                          placeholderOne,
                          style: CustomTextStyles.titleSmallGray600.copyWith(
                            color: appTheme.gray600,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
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

  // Handle success: display list of hotels
  @override
  void onGetHotelsSuccess(List<Hotel> hotels) {
    setState(() async {
      _hotels = hotels;
      _error = null;
    });
  }

  // Handle error: display error message
  @override
  void onGetHotelsError(String error) {
    setState(() {
      _error = error;
    });
  }

  @override
  void onSearchComplete(List<Hotel> roomTypes) {
    setState(() {
      listHotels = roomTypes;
      _isLoading = false;
    });
  }

  @override
  void onSearchError(String error) {
    setState(() {
      _error = error;
      _isLoading = false;
    });
  }

  @override
  void onGetHotelImagesSuccess(List<HotelImage> hotels) {
    setState(() {});
  }

  @override
  void onGetSingleHotelImageSuccess(HotelImage hotels) {
    // TODO: implement onGetSingleHotelImageSuccess
    setState(() {
      _hotelImage = hotels;
    });
  }

  @override
  void updatePosition(Position position) {
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  void updateAddress(String address) {
    setState(() {
      _currentLocation = address;
    });
  }

  @override
  void updateDistance(List<String> distances) {
    setState(() {
      distance = distances;
    });
  }

  @override
  void updateHotel(List<Hotel> hotels) {
    // TODO: implement updateHotel
  }
}
