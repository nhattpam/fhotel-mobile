import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/models/transaction.dart';
import 'package:fhotel_1/data/models/user.dart';
import 'package:fhotel_1/data/models/wallet.dart';
import 'package:fhotel_1/data/repository/list_reservation_repo.dart';
import 'package:fhotel_1/data/repository/list_transaction_repo.dart';
import 'package:fhotel_1/presenters/list_transaction_presenter.dart';
import 'package:fhotel_1/presenters/user_profile_presenter.dart';
import 'package:fhotel_1/views/my_booking_full_screen/widgets/maincontent7_item_widget.dart';
import 'package:fhotel_1/views/my_transaction_history/my_transaction_view.dart';
import 'package:fhotel_1/views/my_transaction_history/my_transactionn_widget.dart';
import 'package:fhotel_1/views/tabbar_booking_and_service/list_reservation_view.dart';
import 'package:fhotel_1/views/user_profile/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../core/app_export.dart';
import '../../presenters/list_reservation_presenter.dart';

class MyTransactionHistory extends StatefulWidget {
  MyTransactionHistory({Key? key}) : super(key: key);

  @override
  MyTransactionHistoryState createState() => MyTransactionHistoryState();
}

class MyTransactionHistoryState extends State<MyTransactionHistory>
    with AutomaticKeepAliveClientMixin<MyTransactionHistory>
    implements MyTransactionView, UserProfileView {
  @override
  bool get wantKeepAlive => true;
  int sliderIndex = 1;
  int _currentIndex = 3;

  late ListTransactionPresenter _presenter;
  List<Transaction> _transaction = [];
  Wallet? _wallet;
  late UserProfilePresenter _userProfilePresenter;

  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = ListTransactionPresenter(this, ListTransactionRepo()); // Initialize the presenter
    _userProfilePresenter = UserProfilePresenter(this); // Initialize the presenter
    _userProfilePresenter.getCustomerById(); // Fetch customer data
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
              color: appTheme.gray10001,
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 16.h,
                top: 28.h,
                right: 16.h,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [_buildMaincontent(context)],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMaincontent(BuildContext context) {
    _transaction.sort((a, b) => DateTime.parse(a.transactionDate.toString()).compareTo(DateTime.parse(b.transactionDate.toString())));
    return GroupedListView<Transaction, String>(
      shrinkWrap: true,
      elements: _transaction,
      groupBy: (transaction) {
        DateTime parsedDate = DateTime.parse(transaction.transactionDate.toString());
        return DateFormat('yyyy-MM-dd').format(parsedDate);
      },
      groupSeparatorBuilder: (String groupByValue) {
        DateTime parsedDate = DateTime.parse(groupByValue);
        String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            formattedDate, // Display the formatted date
            style: theme.textTheme.titleMedium,
          ),
        );
      },
      itemBuilder: (context, Transaction transaction) {
        return MyTransactionnWidget(transaction: transaction);
      },
      separator: SizedBox(height: 12.h),
      order: GroupedListOrder.DESC,
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
          text: "Lịch sử giao dịch",
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

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void onGetTransactionsError(String error) {
    // TODO: implement onGetTransactionsError
  }

  @override
  void onGetTransactionsSuccess(List<Transaction> transactions) {
    // TODO: implement onGetTransactionsSuccess
    print(transactions);
    setState(() {
      _transaction = transactions;
    });
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }

  @override
  void onGetCustomerError(String error) {
    // TODO: implement onGetCustomerError
  }

  @override
  void onGetCustomerSuccess(User user) {
    // TODO: implement onGetCustomerSuccess
  }

  @override
  void onGetWalletSuccess(Wallet wallet) {
    // TODO: implement onGetWalletSuccess
    setState(() {
      _wallet = wallet;
      _presenter.getListTransactionByWalletId((_wallet?.walletId).toString()); // Fetch customer data
    });
  }

  @override
  void showValidationError(String field, String message) {
    // TODO: implement showValidationError
  }

}
