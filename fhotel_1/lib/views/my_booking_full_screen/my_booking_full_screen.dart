import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/repository/list_reservation_repo.dart';
import 'package:fhotel_1/views/my_booking_full_screen/widgets/maincontent7_item_widget.dart';
import 'package:fhotel_1/views/tabbar_booking_and_service/list_reservation_view.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../core/app_export.dart';
import '../../presenters/list_reservation_presenter.dart';

class MyBookingFullScreen extends StatefulWidget {
  MyBookingFullScreen({Key? key}) : super(key: key);

  @override
  MyBookingFullScreenState createState() => MyBookingFullScreenState();
}

class MyBookingFullScreenState extends State<MyBookingFullScreen>
    with AutomaticKeepAliveClientMixin<MyBookingFullScreen>
    implements ListReservationView {
  @override
  bool get wantKeepAlive => true;
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
    _reservation.sort((a, b) => DateTime.parse(a.createdDate.toString()).compareTo(DateTime.parse(b.createdDate.toString())));
    return GroupedListView<Reservation, String>(
      shrinkWrap: true,
      elements: _reservation,
      groupBy: (reservation) {
        DateTime parsedDate = DateTime.parse(reservation.createdDate.toString());
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
      itemBuilder: (context, Reservation reservation) {
        return Maincontent7ItemWidget(reservation: reservation);
      },
      separator: SizedBox(height: 12.h),
      order: GroupedListOrder.DESC,
    );
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onGetReservationsError(String error) {
    setState(() {
      _error = error;
    });
  }

  @override
  void onGetReservationsSuccess(List<Reservation> reservations) {
    setState(() {
      _reservation = reservations;
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void onGetReservationSuccess(Reservation reservation) {
    // Additional logic if needed when a specific reservation is fetched
  }

  // Show notification when payment status changes
  }
