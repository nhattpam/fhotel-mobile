import 'package:fhotel_1/data/models/reservation.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class ListReservationRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';
  final customerId = SessionManager().getUserId();

  Future<List<Reservation>> getListReservationByCustomerId() async {
    final url = Uri.parse('$_baseUrl/users/$customerId/reservations');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Mapping the list of dynamic to List<RoomImage>
      return responseData.map((data) => Reservation.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch list reservation.');
    }
  }
  Future<Reservation?> getFirstCheckInReservationByCustomerId() async {
    final url = Uri.parse('$_baseUrl/users/$customerId/reservations');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Map the data to List<Reservation> and find the first match
      return responseData
          .map((data) => Reservation.fromJson(data))
          .cast<Reservation?>() // Ensure the type is nullable
          .firstWhere(
            (reservation) => reservation?.reservationStatus == 'CheckIn',
        orElse: () => null, // Return null if no match is found
      );
    } else {
      throw Exception('Failed to fetch list reservation.');
    }
  }


  Future<Reservation> getReservationByReservationId(String reservationId) async {

    final url = Uri.parse('$_baseUrl/reservations/$reservationId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return Reservation.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch reservation.');
    }
  }
  Future<bool> updateReservation(Reservation reservation) async {
    String reservationId = reservation.reservationId.toString();
    final url = Uri.parse('$_baseUrl/reservations/$reservationId');
    print(url);
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any authentication headers here
        },
        body: jsonEncode(reservation.toJson()),
      );
      print(jsonEncode(reservation.toJson()));

      if (response.statusCode == 200) {
        return true; // Update successful
      } else {
        print('Failed to update reservation. Status code: ${response.statusCode}');
        return false; // Update failed
      }
    } catch (e) {
      throw Exception('Failed to update reservation');
    }
  }

}
