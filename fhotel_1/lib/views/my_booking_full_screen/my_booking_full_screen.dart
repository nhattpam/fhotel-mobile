import 'package:diacritic/diacritic.dart';
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
    with AutomaticKeepAliveClientMixin<MyBookingFullScreen>
    implements ListReservationView {
  @override
  bool get wantKeepAlive => true;
  int sliderIndex = 1;
  int _currentIndex = 3;

  late ListReservationPresenter _presenter;
  List<Reservation> _reservation = [];
  List<Reservation> _filteredReservations = [];

  String? _error;
  bool _isLoading = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _presenter = ListReservationPresenter(this, ListReservationRepo());
    _presenter.getListReservationByCustomerId();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value.toLowerCase();

      _filteredReservations = _reservation.where((reservation) {
        // Format the createdDate to match the user input style
        DateTime parsedDate = DateTime.parse(reservation.createdDate.toString());
        String formattedDate =
            '${parsedDate.day}${parsedDate.month}${parsedDate.year}'; // e.g., 3122024

        // Create a searchable string representation of the reservation
        String searchableString = [
          reservation.code,
          reservation.totalAmount.toString(),
          formattedDate,
          reservation.roomType?.hotel?.hotelName ?? '',
          removeDiacritics(reservation.roomType?.hotel?.hotelName ?? '').toLowerCase()
        ].join('').toLowerCase();

        // Check if the search query matches the searchable string
        return searchableString.contains(_searchQuery);
      }).toList();
    });
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
                      children: [
                        _buildSearchField(),
                        _buildMaincontent(context),
                      ],
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

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Tìm kiếm đặt phòng', // Vietnamese translation
          labelStyle: TextStyle(color: Colors.grey), // Default label color
          floatingLabelStyle: TextStyle(color: Colors.blue), // Blue color when focused
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Blue border when focused
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0), // Blue border when focused
          ),
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Colors.blue
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }


  Widget _buildMaincontent(BuildContext context) {
    List<Reservation> displayList =
    _searchQuery.isEmpty ? _reservation : _filteredReservations;

    displayList.sort((a, b) =>
        DateTime.parse(a.createdDate.toString()).compareTo(DateTime.parse(b.createdDate.toString())));

    return GroupedListView<Reservation, String>(
      shrinkWrap: true,
      elements: displayList,
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
      _filteredReservations = reservations; // Initialize filtered list
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
}

