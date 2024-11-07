import 'package:fhotel_1/data/models/user.dart';
import 'package:fhotel_1/data/models/wallet.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../presenters/user_profile_presenter.dart';
import '../user_profile/user_profile_view.dart';

class UserEditBankAccount extends StatefulWidget {
  @override
  _UserEditBankAccountState createState() => _UserEditBankAccountState();
}

class _UserEditBankAccountState extends State<UserEditBankAccount>
    implements UserProfileView {
  final List<FocusNode> focusNodes = List.generate(3, (index) => FocusNode());

  TextEditingController bankNumberInputController = TextEditingController();
  TextEditingController bankNameInputController = TextEditingController();


  late UserProfilePresenter _presenter;
  String? bankNumberError;
  String? bankNameError;

  User? _user;
  Wallet? _wallet;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = UserProfilePresenter(this); // Initialize presenter with the current view
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      _user = args['customer'] as User?;
      _wallet = args['wallet'] as Wallet?;
    }
  }


  void _unfocusAllExcept(int index) {
    for (int i = 0; i < focusNodes.length; i++) {
      if (i != index) {
        focusNodes[i].unfocus();
      }
    }
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    bankNumberInputController.dispose();
    bankNameInputController.dispose();
    // Dispose other controllers here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          height: SizeUtils.height,
          child: Container(
            padding: EdgeInsets.all(30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Thay đổi số tài khoản",
                  style: TextStyle(fontSize: 25, color: Colors.indigoAccent),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Số tài khoản của bạn sẽ chỉ dùng với mục đích hoàn tiền",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleSmallMedium,
                ),
                SizedBox(height: 74.h),
                _buildCurrentPasswordInput(context),
                SizedBox(height: 28.h),
                _buildNewPasswordInput(context),
                SizedBox(height: 30.h),
                _buildSignInButton(context),
                SizedBox(height: 8.h),
              ],
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
          text: "Thay đổi số tài khoản",
          margin: EdgeInsets.only(left: 8.h),
        ),
        styleType: Style.bgFill);
  }

  Widget _buildNewPasswordInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tên tài khoản ngân hàng',
          style: TextStyle(color: Colors.blue),
        ),
        if (bankNameError != null)
          Text(
            bankNameError!,
            style: TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            focusNode: focusNodes[0],
            textStyle: const TextStyle(color: Colors.black),
            fillColor: appTheme.blue50,
            controller: bankNameInputController,
            hintText: "Tên tài khoản ngân hàng",
            hintStyle: const TextStyle(color: Colors.grey),
            textInputType: TextInputType.emailAddress,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) async {
              final error = await _presenter.validateBankName(value); // Validate email on change
              setState(() {
                bankNameError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(0); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }


  Widget _buildCurrentPasswordInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Số tài khoản ngân hàng',
          style: TextStyle(color: Colors.blue),
        ),
        if (bankNumberError != null)
          Text(
            bankNumberError!,
            style: const TextStyle(color: Colors.red),
          ),
        Padding(
          padding: EdgeInsets.only(right: 8.h),
          child: CustomTextFormField(
            textStyle: const TextStyle(color: Colors.black),
            focusNode: focusNodes[1],
            fillColor: appTheme.blue50,
            controller: bankNumberInputController,
            hintText: "Số tài khoản ngân hàng",
            hintStyle: const TextStyle(color: Colors.grey),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.number,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onChanged: (value) async {
              final error = await _presenter.validateBankNumber(
                  value); // Validate password on change
              setState(() {
                bankNumberError = error; // Clear the error if validation passes
              });
            },
            onTap: () {
              _unfocusAllExcept(1); // Unfocus all except the email field
            },
          ),
        ),
      ],
    );
  }


  Widget _buildSignInButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        final bankNumber = bankNumberInputController.text;
        final bankName = bankNameInputController.text;
        int bankNumberInt = 0;

        if (bankNumber.isNotEmpty) {
          setState(() {
            bankNumberInt = int.parse(bankNumber);
          });
        }
        if (bankName.isEmpty) {
          setState(() {
            bankNameError = 'Tên tài khoản ngân hàng không được để trống';
          });
        }
        // Perform final validation
        if (bankNumberError == null &&
            bankNameError == null) {
          ///Update wallet
          _presenter.updateWallet((_user?.userId).toString(), (_wallet?.walletId).toString(), bankNumberInt, bankName, (_wallet?.balance ?? 0).toDouble());
          AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            body: const Center(
              child: Text(
                'Đổi số tài khoản ngân hàng thành công!!!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            // title: 'Warning',
            // desc:   'This is also Ignored',
            btnOkOnPress: () {
              Navigator.pushReplacementNamed(context, AppRoutes.initialRoute);
            },
          ).show();
        }
      },
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
      text: "Xác nhận thay đổi",
      margin: EdgeInsets.only(right: 8.h),
    );
  }

  @override
  void showValidationError(String field, String message) {
    setState(() {
      if (field == 'bankNumber') {
        bankNumberError = message;
      }else if (field == 'bankName') {
        bankNameError = message;
      }
    });
  }

  @override
  void onRegisterError(String error) {
    // Display an error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }

  @override
  void onRegisterSuccess() {
    // Handle successful registration (e.g., navigate to a new screen)
    // Navigator.pushReplacementNamed(context, AppRoutes.homePage);
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
      // _customer = customer;
      // _error = null;
    });
  }

  @override
  void onGetCustomerError(String error) {
    setState(() {
      // _error = error;
      // _customer = null;
    });
  }

  @override
  void onGetWalletSuccess(Wallet wallet) {
    // TODO: implement onGetWalletSuccess
  }
}
