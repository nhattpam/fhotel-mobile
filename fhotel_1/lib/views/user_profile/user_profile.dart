import 'package:fhotel_1/core/app_export.dart';
import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/user.dart';
import 'package:fhotel_1/data/models/wallet.dart';
import 'package:fhotel_1/presenters/user_profile_presenter.dart';
import 'package:fhotel_1/views/user_profile/user_profile_view.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({Key? key}) : super(key: key);

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends State<UserProfileScreen>
    implements UserProfileView {
  int sliderIndex = 1;
  int _currentIndex = 3;

  late UserProfilePresenter _presenter;
  User? _customer;
  Wallet? _wallet;
  String? _error;
  bool _isLoading = false;
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    _presenter = UserProfilePresenter(this); // Initialize the presenter
    _presenter.getCustomerById(); // Fetch customer data
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
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 24.h,
                  top: 18.h,
                  right: 24.h,
                ),
                child: Column(
                  children: [
                    _buildProfilesix(context),
                    SizedBox(height: 32.h),
                    _buildOne(context),
                    SizedBox(height: 20.h),
                    // _buildTwo(context),
                    // SizedBox(height: 18.h),
                    _buildThree(context),
                    SizedBox(height: 18.h),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context)),
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

  Widget _buildProfilesix(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100.h,
            width: 100.h,
            decoration: BoxDecoration(
              color: appTheme.gray10002,
              borderRadius: BorderRadiusStyle.circleBorder50,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                (_customer?.image != null && _customer?.image != '' && _customer?.image != 'null')
                ? Image.network(
                  _customer?.image ?? 'https://htmlcolorcodes.com/assets/images/colors/steel-gray-color-solid-background-1920x1080.png',
                  fit: BoxFit.cover, // Adjust the fit as necessary
                  height: 100.h, // Set height to match the container
                  width: 100.h,  // Set width to match the container
                )
                : Skeleton(
                  width: 100.h,
                  height: 100.h,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 194.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customer?.name == null
                    ? const Skeleton(
                        width: 120,
                        height: 30,
                      )
                    : Text(
                        "${_customer?.name}",
                        style: CustomTextStyles.titleSmallGray600,
                      ),
                SizedBox(height: 8.h),
                _customer?.email == null
                    ? const Skeleton(
                        width: 150,
                        height: 30,
                      )
                    : Text(
                        "${_customer?.email}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium,
                      ),
                SizedBox(height: 8.h),
                _wallet?.balance == null
                    ? const Skeleton(
                        width: 150,
                        height: 30,
                      )
                    : Text(
                        "Số dư: ${NumberFormat('#,###', 'en_US').format(_wallet?.balance)} ₫",
                        style: theme.textTheme.bodyMedium,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOne(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadiusStyle.circleBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: _buildAddress(
              route: AppRoutes.userProfile,
              color: Colors.orangeAccent,
              context,
              userOne: ImageConstant.imgCircle24x24,
              addressesOne: "Trang cá nhân",
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: _buildAddress(
              route: AppRoutes.transactionPage,
              color: Colors.brown,
              context,
              userOne: ImageConstant.imgCircle24x25,
              addressesOne: "Lịch sử nhận tiền",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThree(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: appTheme.gray10002,
        borderRadius: BorderRadiusStyle.circleBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: _buildAddress(
              route: AppRoutes.initialRoute,
              color: Colors.red,
              context,
              userOne: ImageConstant.imgImage12,
              addressesOne: "Trung tâm trợ giúp",
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: _buildAddress(
              route: AppRoutes.initialRoute,
              color: Colors.blueAccent,
              context,
              userOne: ImageConstant.imgImage11,
              addressesOne: "Cài đặt",
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: _buildLogout(
              route: AppRoutes.initialRoute,
              color: Colors.purple,
              context,
              userOne: ImageConstant.imgImage13,
              addressesOne: "Đăng xuất",
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddress(
    BuildContext context, {
    required String userOne,
    required String addressesOne,
    required Color color,
    required String route,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          color: color,
          imagePath: userOne,
          height: 20.h,
          width: 20.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 14.h),
          child: Text(
            addressesOne,
            style: CustomTextStyles.titleSmallGray600.copyWith(
              color: appTheme.black900,
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(route);
          },
          child: CustomImageView(
            color: Colors.grey,
            imagePath: ImageConstant.imgArrowRight,
            height: 24.h,
            width: 24.h,
          ),
        )
      ],
    );
  }

  Widget _buildLogout(
    BuildContext context, {
    required String userOne,
    required String addressesOne,
    required Color color,
    required String route,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          color: color,
          imagePath: userOne,
          height: 20.h,
          width: 20.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 14.h),
          child: Text(
            addressesOne,
            style: CustomTextStyles.titleSmallGray600.copyWith(
              color: appTheme.black900,
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(route);
            SessionManager().clearSession();
          },
          child: CustomImageView(
            color: Colors.grey,
            imagePath: ImageConstant.imgArrowRight,
            height: 24.h,
            width: 24.h,
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
  void onGetCustomerSuccess(User customer) {
    setState(() {
      _customer = customer;
      _error = null;
    });
  }

  @override
  void onGetCustomerError(String error) {
    setState(() {
      _error = error;
      _customer = null;
    });
  }

  @override
  void showValidationError(String field, String message) {
    // TODO: implement showValidationError
  }

  @override
  void onGetWalletSuccess(Wallet wallet) {
    // TODO: implement onGetWalletSuccess
    setState(() {
      _wallet = wallet;
    });
  }
}
