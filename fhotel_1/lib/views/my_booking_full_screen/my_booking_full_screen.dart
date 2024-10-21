import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/repository/list_reservation_repo.dart';
import 'package:fhotel_1/views/my_booking_full_screen/widgets/maincontent7_item_widget.dart';
import 'package:fhotel_1/views/tabbar_booking_and_service/list_reservation_view.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../core/app_export.dart';
import '../../presenters/list_reservation_presenter.dart';

class MyBookingFullScreen extends StatefulWidget {
  MyBookingFullScreen({Key? key}) : super(key: key);

  @override
  MyBookingFullScreenState createState() => MyBookingFullScreenState();
}

class MyBookingFullScreenState extends State<MyBookingFullScreen>
    implements ListReservationView {
  int sliderIndex = 1;
  int _currentIndex = 3;

  late ListReservationPresenter _presenter;
  List<Reservation> _reservation = [];

  String? _error;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = ListReservationPresenter(
        this, ListReservationRepo()); // Initialize the presenter
    _presenter.getListReservationByCustomerId(); // Fetch customer data
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
        text: "Danh sách đặt phòng",
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
              SizedBox(width: 8.h),
              AppbarIconbutton(
                imagePath: ImageConstant.imgDivider,
                margin: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 4.h,
                ),
              )
            ],
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  Widget _buildAngx1(BuildContext context) {
    return CustomElevatedButton(
      height: 28.h,
      width: 94.h,
      text: "Đang xử lý",
      buttonStyle: CustomButtonStyles.fillYellow,
      buttonTextStyle: CustomTextStyles.bodyMediumSecondaryContainer,
    );
  }

  Widget _buildMaincontent(BuildContext context) {
    return GroupedListView<Reservation, String>(
      shrinkWrap: true,
      elements: _reservation,
      groupBy: (reservation) {
        DateTime parsedDate = DateTime.parse(reservation.createdDate.toString());
        return DateFormat('yyyy-MM-dd').format(parsedDate);
      },
      // Group by createDate
      groupSeparatorBuilder: (String groupByValue) {
        // Parse the date string and format it as dd/MM/yyyy
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
      itemBuilder: (context, Reservation reservation) {
        return Maincontent7ItemWidget(reservation: reservation);
      },
      separator: SizedBox(height: 12.h),
      // Add spacing between items
      order: GroupedListOrder.DESC, // Adjust based on your desired order
    );
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
  }

  @override
  void onGetReservationsError(String error) {
    // TODO: implement onGetReservationsError
  }

  @override
  void onGetReservationsSuccess(List<Reservation> reservations) {
    setState(() {
      _reservation = reservations;
    });
  }

  @override
  void showLoading() {
    // TODO: implement showLoading
  }
}
