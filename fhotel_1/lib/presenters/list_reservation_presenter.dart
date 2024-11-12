import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/repository/list_reservation_repo.dart';
import 'package:fhotel_1/views/tabbar_booking_and_service/list_reservation_view.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
class ListReservationPresenter {
  final ListReservationView _view;
  final ListReservationRepo _reservationRepo;

  ListReservationPresenter(this._view, this._reservationRepo);

  // Method to get the list of hotels
  Future<void> getListReservationByCustomerId() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<Reservation> reservations = await _reservationRepo.getListReservationByCustomerId();
      // Reservation? reservation = await _reservationRepo.getFirstCheckInReservationByCustomerId();
      _view.onGetReservationsSuccess(reservations); // Pass the data to the view on success
      // print(reservation);
      // showPaymentNotification(reservation!);

    } catch (error) {
      _view.onGetReservationsError(error.toString()); // Pass the error to the view on failure
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }
  // Future<void> showPaymentNotification(Reservation reservation) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> notifiedReservations = prefs.getStringList('notifiedReservations') ?? [];
  //
  //   // Check if this reservation ID has already triggered a notification
  //   if (!notifiedReservations.contains(reservation.reservationId)) {
  //     // Send the notification
  //     const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //     AndroidNotificationDetails(
  //       'payment_status_channel',
  //       'Payment Status Notifications',
  //       channelDescription: 'Notifications for payment status updates',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker',
  //     );
  //
  //     const NotificationDetails platformChannelSpecifics =
  //     NotificationDetails(android: androidPlatformChannelSpecifics);
  //
  //     await flutterLocalNotificationsPlugin.show(
  //       0,
  //       'Phòng của bạn đặt đẵ sẵn sàng',
  //       'Hãy kiểm tra phòng của bạn trong chi tiết đặt phòng',
  //       platformChannelSpecifics,
  //       payload: 'Reservation status: ${reservation.reservationStatus}',
  //     );
  //
  //     // Add the reservation ID to the list and save it
  //     notifiedReservations.add((reservation.reservationId).toString());
  //     await prefs.setStringList('notifiedReservations', notifiedReservations);
  //   }
  // }

  Future<void> getReservationById(String reservationId) async {
    _view.showLoading(); // Show loading before fetching data
    try {
      // Call the network method to get the customer by ID
      final reservation = await _reservationRepo.getReservationByReservationId(reservationId);
      // Notify the view about success
      _view.onGetReservationSuccess(reservation);
    } catch (error) {
      // Notify the view about failure
      _view.onGetReservationsError('Error fetching reservation: $error');
    } finally{
      _view.hideLoading(); // Hide loading after the process
    }
  }
  Future<void> updateReservation(
      String reservationId,
      int numberOfRooms,
      String code,
      String roomTypeId,
      String checkInDate,
      String checkOutDate,
      double totalAmount,
      String customerId,
      String paymentStatus,
      String reservationStatus,
      String paymentMethodId,
      String createDate,
      ) async {

    // Call the authenticate method from the network layer
    Reservation reservation = Reservation(
        reservationId: reservationId,
        numberOfRooms: numberOfRooms,
        code: code,
        roomTypeId: roomTypeId,
        checkInDate: checkInDate,
        checkOutDate: checkOutDate,
        totalAmount: totalAmount,
        customerId: customerId,
        paymentStatus: paymentStatus,
        reservationStatus: reservationStatus,
        paymentMethodId: paymentMethodId,
        createdDate: createDate
        );
    _view.showLoading();

    bool success = await _reservationRepo.updateReservation(reservation);

    if (success) {
      _view.hideLoading();
    } else {
      _view.showLoading();
    }
  }
}
