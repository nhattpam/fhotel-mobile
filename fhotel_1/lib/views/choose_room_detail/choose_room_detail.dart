import 'package:fhotel_1/core/utils/skeleton.dart';
import 'package:fhotel_1/data/models/room_facility.dart';
import 'package:fhotel_1/data/models/type.dart';
import 'package:fhotel_1/data/models/user.dart';
import 'package:fhotel_1/presenters/create_reservation.dart';
import 'package:fhotel_1/views/checkout/checkout.dart';
import 'package:fhotel_1/views/home_check_in_date_default/home_check_in_date_default.dart';
import 'package:fhotel_1/views/home_hotel_region_empty/widgets/carouselunit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;

import '../../core/app_export.dart';
import '../../data/models/reservation.dart';
import '../../data/models/room_image.dart';
import '../../data/models/room_types.dart';
import '../../data/repository/list_room_type_repo.dart';
import '../../presenters/list_room_type_presenter.dart';
import '../choose_room/choose_room_view.dart';
import 'create_reservation_view.dart';

class ChooseRoomRoomDetailScreen extends StatefulWidget {
  final String roomTypeId;
  final String checkInDate;
  final String checkOutDate;
  final int numberOfRooms;

  const ChooseRoomRoomDetailScreen(
      {super.key,
      required this.roomTypeId,
      required this.checkInDate,
      required this.checkOutDate,
      required this.numberOfRooms});

  @override
  ChooseRoomRoomDetailScreenState createState() =>
      ChooseRoomRoomDetailScreenState();
}

class ChooseRoomRoomDetailScreenState extends State<ChooseRoomRoomDetailScreen>
    implements ChooseRoomView, CreateReservationView {
  int activeIndex = 0;
  late ListRoomTypePresenter _presenter;
  late CreateReservation _createReservation;
  double? _totalAmount = 0;
  List<RoomFacility> _facilities = [];
  SessionManager sessionManager = SessionManager();
  String? dateStarSelected;
  String? dateEndSelected;
  int quantity = 1;
  RoomType? _roomType;
  bool error = false;
  TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _presenter = ListRoomTypePresenter(this, ListRoomTypeRepo());
    _createReservation = CreateReservation(this);
    _presenter.getRoomTypeById(widget.roomTypeId);
    _presenter.getFacilityByRoomTypeId(widget.roomTypeId);
    dateStarSelected = widget.checkInDate;
    dateEndSelected = widget.checkOutDate;
    _quantityController.text = quantity.toString();
    quantity = widget.numberOfRooms;
    _calculateTotalAmount();
  }

  Future<bool> _checkUserSession() async {
    await sessionManager.init(); // Initialize session manager
    String? userId = sessionManager.getUserId();

    if (userId == null || userId.isEmpty) {
      // If userId is not available, return false and show the login dialog
      _showLoginDialog();
      return false;
    }

    // If userId exists, user is logged in, return true
    return true;
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
          },
          onLogin: () {
            Navigator.pop(context); // Close login dialog
          },
          onCloseDialog: () {
            Navigator.pop(context); // Close login dialog
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
          onRegisterFillInformation:
              (String enteredEmail, String enteredPassword) {
            // Capture the data entered in RegisterDialog
            email = enteredEmail;
            password = enteredPassword;
            Navigator.pop(context);
            _showRegisterFillInformationDialog(
                email, password); // Pass data to the next dialog
          },
          onCloseDialog: () {
            Navigator.pop(context);
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
          onRegisterFillInformation: (User user, String otp) {
            Navigator.pop(context);
            _showOTPDialog(user, otp);
          },
          onCloseDialog: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showOTPDialog(User user, String otp) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return OtpSignupDialog(
          user: user,
          myauth: otp,
          onBackToLogin: () {
            Navigator.pop(context);
            _showLoginDialog();
          },
        );
      },
    );
  }

  Future<void> _calculateTotalAmount() async {
    try {
      // Use await to get the total amount from the async method
      DateFormat inputFormat = DateFormat('dd/MM/yyyy');

      // Parse the date string
      DateTime parsedInDate = inputFormat.parse(dateStarSelected.toString());
      DateTime parsedOutDate = inputFormat.parse(dateEndSelected.toString());

      // Define the desired output format (ISO 8601 format)
      DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

      // Format the parsed date to the desired format
      String isoFormattedInDate = outputFormat.format(parsedInDate);
      String isoFormattedOutDate = outputFormat.format(parsedOutDate);

      double? amount = await _createReservation.createReservationToCalculate(
        isoFormattedInDate,
        isoFormattedOutDate,
        widget.roomTypeId,
        quantity,
      );
      setState(() {
        _totalAmount = amount; // Update the total amount in the state
      });
    } catch (e) {
      // Handle any errors during the calculation
      print("Error calculating total amount: $e");
      // Optionally notify the user of the error

    }
  }
  void _showCalendarModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return HomeCheckInDateDefaultBottomsheet(
          onDateStarSelected: (selectedDate) {
            if (selectedDate != null) {
              // Update the state with the selected date
              setState(() {
                // Format the date as desired
                dateStarSelected = DateFormat('dd/MM/yyyy').format(selectedDate);
              });
            }
          },
          onDateEndSelected: (selectedDate) {
            if (selectedDate != null) {
              // Update the state with the selected date
              setState(() {
                // Format the date as desired
                dateEndSelected = DateFormat('dd/MM/yyyy').format(selectedDate);
              });
            }
          },
        );
      },
    ).then((_) {
      // This will execute after the modal bottom sheet is closed
      _calculateTotalAmount();
    });
  }

  void _incrementRooms() {
    setState(() {
      if (_roomType != null && _roomType!.availableRooms != null) {
        if (quantity < _roomType!.availableRooms!) {
          error = false;
          quantity++;
          _quantityController.text = quantity.toString();
          _calculateTotalAmount();
        } else {
          error = true;
        }
      }
    });
  }

  void _decrementRooms() {
    if (quantity > 1) { // Ensure quantity doesn't go below 0
      setState(() {
        error = false;
        quantity--;
        _quantityController.text = quantity.toString();
        _calculateTotalAmount();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String description = _roomType?.description.toString() ?? '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 80.h,
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 76.h),
              ),
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: appTheme.gray10001,
                borderRadius: BorderRadiusStyle.customBorderTL16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSheetheader(context),
                  CarouselunitItemWidget(roomTypeId: widget.roomTypeId),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 2.h),
                        _roomType?.description != null
                       ? html.Html(
                          data: """
                               $description
                              """,
                          style: {
                            "body": html.Style(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          },
                        )
                        : Skeleton(
                          width: 400.h,
                          height: 50.h,
                        ),
                        // Text(
                        //   _roomType?.description.toString() ?? '',
                        //   style: theme.textTheme.titleMedium,
                        // ),
                        SizedBox(height: 10.h),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: appTheme.whiteA700,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                width: double.maxFinite,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (_roomType?.roomSize != null)
                                    ? Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 286.h,
                                        child: Text(
                                          "Diện tích: ${NumberFormat('#,###', 'en_US').format(_roomType?.roomSize)}m²",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: appTheme.black900
                                                .withOpacity(0.5),
                                            fontSize: 12,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                    )
                                    : Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 100.h,
                                        child: Skeleton(
                                          width: 100.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 16.h),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      color: appTheme.black900.withOpacity(0.5),
                                      imagePath: ImageConstant.imgIconWrapper15,
                                      height: 18.h,
                                      width: 18.h,
                                    ),
                                    (_roomType?.type?.maxOccupancy != null)
                                    ? Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Text(
                                          "Tối đa ${_roomType?.type?.maxOccupancy.toString() ?? ''} người",
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                    )
                                    : Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Skeleton(
                                          width: 100.h,
                                        )
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 18.h),
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                ),
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      color: appTheme.black900.withOpacity(0.5),
                                      imagePath: ImageConstant.imgIconWrapper16,
                                      height: 18.h,
                                      width: 18.h,
                                    ),
                                    (_roomType?.type?.typeName != null)
                                    ? Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Text(
                                          _roomType?.type?.typeName
                                                  .toString() ??
                                              '',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                    )
                                    : Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Skeleton(
                                          width: 100.h,
                                        )
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Divider(),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 12.h,
                    ),
                    color: Colors.white,
                    child: Text(
                      "Các tiện ích của phòng:",
                      textAlign: TextAlign.start,
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  _facilities.isNotEmpty
                      ? Container(
                          height: 200,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: _facilities.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: double.maxFinite,
                                child: _buildSectionOne(
                                  context,
                                  descriptionOne: (_facilities[index].facility?.facilityName).toString(),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                    height: 29,
                    width: double.infinity,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        decoration: BoxDecoration(
                          color: appTheme.whiteA700,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.only(left: 6.h),
                              decoration: BoxDecoration(
                                color: appTheme.whiteA700,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Khách sạn này chưa có tiện nghi',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.colorScheme.onPrimary,
                                      height: 1.50,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: appTheme.whiteA700,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: GestureDetector(
                                  onTap: (){
                                    _showCalendarModalBottomSheet(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8.h),
                                          child: Text(
                                            "Ngày",
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "$dateStarSelected-$dateEndSelected",
                                        style: theme.textTheme.titleSmall,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (error)
                                          Text(
                                            'Chỉ còn trống ${_roomType!.availableRooms} phòng',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8.h),
                                            child: Text(
                                              "Số phòng",
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: _decrementRooms,
                                    ),
                                  SizedBox(
                                    width: quantity > 9 ? 30 : 20,
                                    child: TextFormField(
                                      controller: _quantityController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: Theme.of(context).textTheme.titleSmall,
                                      onFieldSubmitted: (value) {
                                        int newQuantity = int.tryParse(value) ?? quantity;

                                        // Prevent 0 or values lower than 1
                                        if (newQuantity < 1) newQuantity = 1;

                                        setState(() {
                                          if (_roomType != null && _roomType!.availableRooms != null) {
                                            if (newQuantity <= _roomType!.availableRooms!) {
                                              error = false;
                                              quantity = newQuantity;
                                              _quantityController.text = quantity.toString();
                                              _calculateTotalAmount();
                                            } else {
                                              error = true;
                                            }
                                          }
                                        });
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: _incrementRooms,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildSumsectionat(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSheetheader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 6.h, 16.h, 4.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 110.h),
              child: Text(
                textAlign: TextAlign.center,
                "Chi tiết phòng",
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCloseIcon,
            height: 24.h,
            width: 24.h,
          ),
        ],
      ),
    );
  }

  Widget _buildSumsectionat(BuildContext context) {
    return Container(
      height: 115.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.blueGray50,
            width: 1.h,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng giá tiền",
                        style: theme.textTheme.titleSmall,
                      ),
                      _totalAmount != null && _totalAmount! > 0
                          ? Text(
                        "${NumberFormat('#,###', 'en_US').format(_totalAmount)} ₫",
                        style: CustomTextStyles.titleSmallBlue,
                      )
                          : Text(
                        "0 ₫",
                        style: CustomTextStyles.titleSmallBlue,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 14.h),
          // Padding(
          //   padding: EdgeInsets.only(right: 14.h),
          //   child: Text(
          //     "Đã bao gồm thuế",
          //     style: theme.textTheme.bodySmall,
          //   ),
          // ),
          SizedBox(height: 4.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_buildChnphng(context)],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChnphng(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        bool isLoggedIn = await _checkUserSession(); // Check user session on init
        if (isLoggedIn) {
          if ((_totalAmount ?? 0) > 0 ) {
            if ((_roomType?.availableRooms ?? 0) >= quantity) {
              // Define the input date format

              DateFormat inputFormat = DateFormat('dd/MM/yyyy');

              // Parse the date string
              DateTime parsedInDate = inputFormat.parse(dateStarSelected.toString());
              DateTime parsedOutDate = inputFormat.parse(dateEndSelected.toString());

              // Define the desired output format (ISO 8601 format)
              DateFormat outputFormat = DateFormat(
                  "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

              // Format the parsed date to the desired format
              String isoFormattedInDate = outputFormat.format(parsedInDate);
              String isoFormattedOutDate = outputFormat.format(parsedOutDate);

              // Call the createReservation method
              Reservation newReservation = await _createReservation
                  .createReservation(
                isoFormattedInDate,
                isoFormattedOutDate,
                widget.roomTypeId,
                quantity
              );

              // Show success dialog
              AwesomeDialog(
                context: context,
                animType: AnimType.scale,
                dialogType: DialogType.success,
                body: const Center(
                  child: Text(
                    'Đặt thành công!!!',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                btnOkOnPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            CheckoutScreen(reservation: newReservation)),
                  );
                },
              ).show();
            } else {
              AwesomeDialog(
                context: context,
                animType: AnimType.scale,
                dialogType: DialogType.error,
                body: const Center(
                  child: Text(
                    'Không đủ số lượng phòng trống để đặt',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                btnCancelText: 'Quay lại',
                btnCancelOnPress: () {},
              ).show();
            }
          } else{
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.error,
              body: const Center(
                child: Text(
                  'Ngày bạn đặt chưa có giá',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              btnCancelText: 'Quay lại',
              btnCancelOnPress: () {},
            ).show();
          }
        }
      },
      text: "Đặt phòng",
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.bodyMediumwhiteA700,
    );
  }

  Widget _buildSectionOne(
    BuildContext context, {
    required String descriptionOne,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 6.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              border: Border(
                bottom: BorderSide(
                  color: appTheme.blueGray50,
                  width: 1.h,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  descriptionOne,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                    height: 1.50,
                  ),
                ),
                SizedBox(height: 4.h)
              ],
            ),
          )
        ],
      ),
    );
  }

  // Show loading indicator
  @override
  void showLoading() {
    // Show loading indicator (e.g., CircularProgressIndicator)
  }

  @override
  void hideLoading() {
    // Hide loading indicator
  }

  @override
  void showRoomTypes(List<RoomType> roomTypes) {
    // Logic to handle room types if necessary
  }

  @override
  void onGetRoomImageSuccess(List<RoomImage> roomImage) {}

  @override
  void onGetRoomTypeSuccess(RoomType roomType) {
    // TODO: implement onGetRoomTypeSuccess
    setState(() {
      _roomType = roomType;
    });
  }

  @override
  void showTypes(List<Types> types) {
    // TODO: implement showTypes
  }

  @override
  void onCreateError(String error) {
    // TODO: implement onCreateError
  }

  @override
  void onCreateSuccess() {
    // TODO: implement onCreateSuccess
  }

  @override
  void showValidationError(String field, String message) {
    // TODO: implement showValidationError
  }

  @override
  void onCreateTotalAmountSuccess(double totalAmount) {
    // Ensure async work is completed before calling setState
    // setState(() {
    //   _totalAmount = totalAmount;
    // });
  }

  @override
  void onGetPriceSuccess(double price) {
    // TODO: implement onGetPriceSuccess
  }

  @override
  void showFacility(List<RoomFacility> facilities) {
    setState(() {
      _facilities = facilities; // Update state with the fetched images
    });
  }

  @override
  void onGetSingleRoomImageSuccess(RoomImage roomImage) {
    // TODO: implement onGetSingleRoomImageSuccess
  }
}
