import 'package:fhotel_1/data/models/reservation.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class CreateReservationRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<Reservation> create(Reservation reservation) async {
    final url = Uri.parse('$_baseUrl/reservations');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(reservation.toJson()),
      );
      print(reservation.toJson());
      print('Response Body: ${response.body}');


      // Check if the request was successful
      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);

        // Parse the created reservation from the response
        Reservation createdReservation = Reservation.fromJson(jsonResponse);
        // Return the newly created reservation
        return createdReservation;
      } else {
        print('Failed to create reservation: ${response.statusCode}');
        throw Exception('Failed to create reservation');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error creating reservation');
    }
  }

  Future<double> calculate(Reservation reservation) async {
    final url = Uri.parse('$_baseUrl/reservations/calculate');
    print(url);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(reservation.toJson()),
    );
      print(json.encode(reservation.toJson()));
      print(response.statusCode);
    if (response.statusCode == 200) {
      // Parse the response body to extract the totalAmount
      final responseBody = json.decode(response.body);
      double totalAmount = responseBody['totalAmount'];
      print(totalAmount);
      return totalAmount;
    } else {
      throw Exception('Failed to calculate');
    }
  }

  Future<int> availableRoom(String roomtypeId, String checkInDate, String checkOutDate) async {

    final url = Uri.parse('$_baseUrl/reservations/api/roomtypes/$roomtypeId/available-on-date?checkinDate=$checkInDate&checkoutDate=$checkOutDate');
    print(url);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // Parse the response body to extract the totalAmount
      final responseBody = json.decode(response.body);
      int availableRooms = responseBody['availableRooms'];

      return availableRooms;
    } else {
      throw Exception('Failed to check available room');
    }
  }

  Future<void> refund(String reservationId) async {

    final url = Uri.parse('$_baseUrl/reservations/refund?id=$reservationId');
    print(reservationId);
    print(url);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(reservationId),
    );
    print(response.statusCode);
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (response.statusCode != 201) {
      throw Exception('Failed to refund');
    }

  }

}
