import 'package:fhotel_1/presentation/search_service_result/search_service_result.dart';
import 'package:fhotel_1/presentation/service_cart/service_cart.dart';
import 'package:fhotel_1/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges; // Alias the badges package
import '../../core/app_export.dart';
import '../home_hotel_region_empty/home_hotel_region_empty.dart';
import '../service_detail_screen/service_detail_screen.dart';
import '../tabbar_booking_and_service/tabbar_booking_and_service.dart';
import '../user_profile/user_profile.dart';
import 'widgets/listpizza_one_item_widget.dart';

// ignore_for_file: must_be_immutable

class ServiceListingScreen extends StatefulWidget {
  ServiceListingScreen({Key? key}) : super(key: key);

  @override
  ServiceListingScreenState createState() => ServiceListingScreenState();
}

class ServiceListingScreenState extends State<ServiceListingScreen> {
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 1;
  int cartItemCount = 5;
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
                  SizedBox(height: 22.h),
                  _buildColumnheyhalalg(context),
                  SizedBox(height: 16.h),
                  _buildListpizzaone(context),
                  SizedBox(height: 38.h),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.h, 0, 20.h, 0),
                    child: _buildRowopen(
                      context,
                      openone: "Open Restaurants",
                      seeallone: "See All",
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 12.h),
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    // Provide a fixed height to the ListView.builder
                    child: SizedBox(
                      height: 300.h, // You can adjust the height as needed
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const ServiceDetailScreen()),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgImage170x128,
                                    height: 140.h,
                                    width: double.maxFinite,
                                    radius: BorderRadius.circular(10.h),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    "Rose Garden Restaurant",
                                    style: CustomTextStyles.titleSmallGray600,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    "Burger - Chicken - Riche - Wings",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: 12.h),
                                  _buildRowszone(context),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context)
      ),
    );
  }
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjusts alignment
          children: [
            AppbarTitle(
              text: "Danh sách dịch vụ",
              margin: EdgeInsets.only(left: 8.h),
            ),
            _buildCartIconWithBadge(cartItemCount)
          ],
        ),
        styleType: Style.bgFill
    );
  }
  Widget _buildCartIconWithBadge(int cartItemCount) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>  MyCartScreen()),
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
                badgeColor: Colors.redAccent,// Use the alias for the badge
                badgeContent: Text( // Use 'badge' instead of 'badgeContent'
                  cartItemCount.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: Icon(Icons.shopping_bag_outlined, size: 28.h, color: Colors.white,),
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
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => HomeHotelRegionEmptyScreen()),
            );
            break;
          case 1:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ServiceListingScreen()),
            );
            break;
          case 2:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TabbarBookingAndService()),
            );
            break;
          case 3:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UserProfileScreen()),
            );
            // Add navigation logic for index 3
            break;
          case 4:
          // Add navigation logic for index 4
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Hotel',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood_outlined),
          label: 'Service',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.moneyBill1),
          label: 'My Booking',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.wallet),
        //   label: 'Transaction',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
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
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>  SearchServiceResult()),
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

  Widget _buildRowszone(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          SizedBox(
            width: 46.h,
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    Icons.star, // Star icon
                    color: Colors.yellow, // Yellow color
                    size: 20.h, // Set the size to match the previous height
                  ),
                ),
                SizedBox(width: 4.h),
                Text(
                  "4.7",
                  style: CustomTextStyles.titleSmallGray600,
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
          SizedBox(width: 12.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.h),
              child: Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,             // Star icon
                    color: Colors.grey,    // Set the color to yellow
                    size: 20.h,              // Adjust the size according to your requirement
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Text(
                        "20 min",
                        style: CustomTextStyles.titleSmallGray600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
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
}
