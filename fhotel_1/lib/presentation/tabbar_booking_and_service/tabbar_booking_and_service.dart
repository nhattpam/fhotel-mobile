import 'package:fhotel_1/presentation/my_booking_full_screen/my_booking_full_screen.dart';
import 'package:fhotel_1/presentation/my_service/my_service.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class TabbarBookingAndService extends StatefulWidget {
  TabbarBookingAndService({Key? key}) : super(key: key);

  @override
  TabbarBookingAndServiceState createState() => TabbarBookingAndServiceState();
}

class TabbarBookingAndServiceState extends State<TabbarBookingAndService>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 18.h),
              _buildTabview(context),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: tabviewController,
                    children: [MyBookingFullScreen(), MyService()],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildTabview(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: appTheme.blue600,
        labelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Sen',
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelColor: appTheme.gray600,
        unselectedLabelStyle: TextStyle(
          fontSize: 14.fSize,
          fontFamily: 'Sen',
          fontWeight: FontWeight.w400,
        ),
        indicatorColor: appTheme.blue600,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            child: Text(
              "Booking",
            ),
          ),
          Tab(
            child: Text(
              "Service",
            ),
          )
        ],
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

}