import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/service.dart';
import 'package:fhotel_1/data/repository/list_service.dart';
import 'package:fhotel_1/data/repository/service_type_repo.dart';
import 'package:fhotel_1/presenters/list_service_presenter.dart';
import 'package:fhotel_1/presenters/service_type_presenter.dart';
import 'package:fhotel_1/views/search_service_result/search_service_result.dart';
import 'package:fhotel_1/views/service_listing_screen/list_service_view.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../core/app_export.dart';
import '../../data/models/service_type.dart';
import '../service_detail_screen/service_detail_screen.dart';

// ignore_for_file: must_be_immutable

class ServiceListingScreen extends StatefulWidget {
  ServiceListingScreen({Key? key}) : super(key: key);

  @override
  ServiceListingScreenState createState() => ServiceListingScreenState();
}

class ServiceListingScreenState extends State<ServiceListingScreen>
    implements ListServiceView {
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 1;
  int cartItemCount = 5;
  late ListServicePresenter _presenter;
  late ServiceTypePresenter _typePresenter;
  bool _isLoading = false;
  List<Services> _services = [];
  List<ServiceType> _typeServices = [];
  String? _error;
  Services? _service;

  @override
  void initState() {
    super.initState();
    _presenter = ListServicePresenter(this, ListServiceRepo());
    _typePresenter = ServiceTypePresenter(this, ServiceTypeRepo());
    _presenter.getServices(); // Fetch the list of hotels when the screen loads
    _typePresenter.getServiceTypes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: _buildAppbar(context),
          resizeToAvoidBottomInset: false,
          backgroundColor: appTheme.gray10001,
          body: SizedBox(
            width: double.maxFinite,
            child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    SizedBox(height: 32.h),
                    Container(
                      margin: EdgeInsets.fromLTRB(20.h, 0, 20.h, 0),
                      child: _buildRowopen(
                        context,
                        openone: "Loại dịch vụ",
                        seeallone: "Xem tất cả",
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 32.h,
                      width: double.maxFinite,
                      child: ListView.separated(
                        padding: EdgeInsets.only(left: 14.h, right: 14.h),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 8.h,
                          );
                        },
                        itemCount: _typeServices.length,
                        itemBuilder: (context, index) {
                          String name =
                              _typeServices[index].serviceTypeName.toString();
                          return GestureDetector(
                            onTap: () {
                              // Create a new list containing only the services with the desired serviceTypeName
                              List<Services> filteredServices = _services.where((service) => service.serviceType?.serviceTypeName == name).toList();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchServiceResult(service: filteredServices),
                                ),
                              );
                            },
                            child: ChipTheme(
                              data: ChipTheme.of(context).copyWith(
                                backgroundColor: Colors.white,
                                selectedColor: Colors.blue,
                                disabledColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.grey, // Border color
                                    width: 1, // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      50), // Rounded corners
                                ),
                              ),
                              child: Chip(
                                label: Text(
                                  name,
                                ),
                                // selected: false,
                                // onSelected: (bool selected) {},
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 38.h),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 12.h),
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: SizedBox(
                          height: 470.h, // Adjust the height as needed
                          child: GroupedListView<Services, String>(
                            elements: _services,
                            // Your list of services
                            groupBy: (element) =>
                                (element.serviceType?.serviceTypeName)
                                    .toString(),
                            // Grouping criteria
                            groupHeaderBuilder: (Services service) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0.h),
                              child: Text(
                                (service.serviceType?.serviceTypeName)
                                    .toString(), // Display the group name
                                style: TextStyle(
                                  fontSize: 18.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            itemBuilder: (context, Services service) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ServiceDetailScreen(service: service)),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  padding: EdgeInsets.all(12.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.h),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      service.image != null && service.image != 'string'
                                     ? Container(
                                        height: 140.h,
                                        width: double.maxFinite,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10.h)
                                       ),
                                       child: Image.network(
                                          service.image.toString(),
                                          height: 140.h,
                                          width: double.maxFinite,
                                        ),
                                     )
                                      : Container(
                                        height: 140.h,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.h)
                                        ),
                                        child: Skeleton(
                                          height: 140.h,
                                          width: double.maxFinite,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        service.serviceName.toString(),
                                        // Adjust according to your model
                                        style:
                                            CustomTextStyles.titleSmallGray600,
                                      ),
                                      SizedBox(height: 12.h),
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 100.h,
                                              child: Row(
                                                children: [
                                                  Text(
                                                  "Giá ",
                                                    style: CustomTextStyles
                                                        .titleSmallGray600,
                                                  ),
                                                  Text(
                                                  NumberFormat('#,###', 'en_US').format(service.price) + " ₫",
                                                    style: CustomTextStyles
                                                        .titleSmallGray600,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                    )
                  ],
                ),
              ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context)),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // Adjusts alignment
          children: [
            AppbarTitle(
              text: "Dịch vụ",
              margin: EdgeInsets.only(left: 8.h),
            ),
            // _buildCartIconWithBadge(cartItemCount)
          ],
        ),
        styleType: Style.bgFill);
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

  Widget _buildRowopen(
    BuildContext context, {
    required String openone,
    required String seeallone,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            openone,
            style: theme.textTheme.titleMedium,
          ),
        ),
        const Spacer(),
        Text(
          seeallone,
          style:
              CustomTextStyles.bodyMediumPrimary.copyWith(color: Colors.blue),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRightGray600,
          height: 10.h,
          width: 15.h,
          margin: EdgeInsets.only(
            left: 10.h,
            top: 6.h,
          ),
        )
      ],
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
  void onGetServicesError(String error) {
    setState(() {
      _error = error;
    });
  }

  @override
  void onGetServicesSuccess(List<Services> services) {
    setState(() {
      _services = services;
    });
  }

  @override
  void onGetServiceTypesSuccess(List<ServiceType> types) {
    setState(() {
      _typeServices = types;
    });
    // TODO: implement onGetServiceTypesSuccess
  }

  @override
  void onGetServiceSuccess(Services service) {
    setState(() {
      _service = service;
    });
  }
}
