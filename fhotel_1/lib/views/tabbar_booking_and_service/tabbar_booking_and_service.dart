import 'package:fhotel_1/views/my_booking_full_screen/my_booking_full_screen.dart';
import 'package:fhotel_1/views/my_service/my_service.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../data/models/user.dart';
import '../../presenters/login_presenter.dart';

class TabbarBookingAndService extends StatefulWidget {
  TabbarBookingAndService({Key? key}) : super(key: key);

  @override
  TabbarBookingAndServiceState createState() => TabbarBookingAndServiceState();
}

class TabbarBookingAndServiceState extends State<TabbarBookingAndService>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  int _currentIndex = 2;
  SessionManager sessionManager = SessionManager();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<FocusNode> focusNodes = List.generate(3, (index) => FocusNode());


  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController repasswordInputController = TextEditingController();

  late LoginPresenter _presenter;

  String? repasswordError;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
    _checkUserSession(); // Check user session on init
  }

  Future<void> _checkUserSession() async {
    await sessionManager.init(); // Initialize session manager
    String? userId = sessionManager.getUserId();

    if (userId == null || userId.isEmpty) {
      // If userId is not available, redirect to login or any other page
      _showLoginDialog();
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoginDialog(
          onCreateAccount: () {
            Navigator.pop(context); // Close login dialog
            _showRegisterDialog(); // Open register dialog
          }, onLogin: () {
          Navigator.pushReplacementNamed(context, AppRoutes.myOrderPageAndServicePage);
        }, onCloseDialog: () {
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        },
        );
      },
    );
  }

  void _showRegisterDialog() {
    String email = ''; // Declare variables to store the data
    String password = '';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RegisterDialog(
          onBackToLogin: () {
            Navigator.pop(context); // Close register dialog
            _showLoginDialog(); // Open login dialog
          },
          onRegisterFillInformation: (String enteredEmail, String enteredPassword) {
            // Capture the data entered in RegisterDialog
            email = enteredEmail;
            password = enteredPassword;
            Navigator.pop(context);
            _showRegisterFillInformationDialog(email, password); // Pass data to the next dialog
          }, onCloseDialog: () {
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);

        },
        );
      },
    );
  }
  void _showRegisterFillInformationDialog(String email, String password) {
    User _user = User(); // Declare variables to store the data
    String myauth = '';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RegisterFillInformationDialog(
          email: email,
          password: password,
          onRegisterFillInformation: (User user) {
            Navigator.pop(context);
            _showOTPDialog(user);
          }, onCloseDialog: () {
          Navigator.pushReplacementNamed(context, AppRoutes.homePage);
        },
        );
      },
    );
  }
  void _showOTPDialog(User user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return OtpSignupDialog(
          user: user,
          onBackToLogin: (){
            Navigator.pop(context);
            _showLoginDialog();
          },
        );
      },
    );
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
              "Đặt phòng",
            ),
          ),
          Tab(
            child: Text(
              "Dịch vụ",
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

}
