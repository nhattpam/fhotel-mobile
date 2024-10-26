import 'package:badges/badges.dart' as badges; // Alias the badges package
import 'package:fhotel_1/data/models/service.dart';
import 'package:fhotel_1/data/repository/list_service.dart';
import 'package:fhotel_1/data/repository/service_type_repo.dart';
import 'package:fhotel_1/presenters/list_service_presenter.dart';
import 'package:fhotel_1/presenters/service_type_presenter.dart';
import 'package:fhotel_1/views/search_service_result/search_service_result.dart';
import 'package:fhotel_1/views/service_cart/service_cart.dart';
import 'package:fhotel_1/views/service_listing_screen/list_service_view.dart';
import 'package:fhotel_1/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../core/app_export.dart';
import '../../data/models/service_type.dart';
import '../service_detail_screen/service_detail_screen.dart';
import 'widgets/listpizza_one_item_widget.dart';

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
            child: SingleChildScrollView(
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
                      width: 294.h,
                      child: ListView.separated(
                        padding: EdgeInsets.only(right: 34.h),
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
                          return ChipTheme(
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
                          height: 500.h, // Adjust the height as needed
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
                                        builder: (context) =>
                                            const ServiceDetailScreen()),
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
                                      Image.network(
                                        service.image.toString(),
                                        height: 140.h,
                                        width: double.maxFinite,
                                        // radius: BorderRadius.circular(10.h),
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
                                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                            // SizedBox(width: 12.h),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.end,
                                            //   mainAxisSize: MainAxisSize.min,
                                            //   children: [
                                            //     CustomImageView(
                                            //       imagePath: ImageConstant.imgImage170x128,
                                            //       height: 16.h,
                                            //       width: 22.h,
                                            //     ),
                                            //     Padding(
                                            //       padding: EdgeInsets.only(left: 8.h),
                                            //       child: Text(
                                            //         "Free",
                                            //         style: CustomTextStyles.titleSmallGray600,
                                            //       ),
                                            //     )
                                            //   ],
                                            // ),
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
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context)),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Adjusts alignment
          children: [
            AppbarTitle(
              text: "Danh sách dịch vụ",
              margin: EdgeInsets.only(left: 8.h),
            ),
            _buildCartIconWithBadge(cartItemCount)
          ],
        ),
        styleType: Style.bgFill);
  }

  Widget _buildCartIconWithBadge(int cartItemCount) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MyCartScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 16.h,
          right: 16.h,
          bottom: 16.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // AppbarImage or an icon for shopping cart
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
              child: badges.Badge(
                badgeColor: Colors.redAccent, // Use the alias for the badge
                badgeContent: Text(
                  // Use 'badge' instead of 'badgeContent'
                  cartItemCount.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 28.h,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
          label: 'Lịch sử giao dịch',
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

  Widget _buildColumnheyhalalg(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchView(
            controller: searchController,
            hintText: "Search dishes, restaurants",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.h,
              vertical: 22.h,
            ),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.maxFinite,
            child: _buildRowopen(
              context,
              openone: "All Categories",
              seeallone: "See All",
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListpizzaone(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 24.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 16.h,
            children: List.generate(
              3,
              (index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => SearchServiceResult()),
                      );
                    },
                    child: const ListpizzaOneItemWidget());
              },
            ),
          ),
        ),
      ),
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
      print(_services);
    });
  }

  @override
  void onGetServiceTypesSuccess(List<ServiceType> types) {
    setState(() {
      _typeServices = types;
      print(_typeServices);
    });
    // TODO: implement onGetServiceTypesSuccess
  }
}
