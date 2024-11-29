import 'package:fhotel_1/data/models/caculate.dart';
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

  Future<Calculate> calculate(Reservation reservation) async {
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
      print(responseBody);
      return Calculate.fromJson(responseBody);
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

  Future<String> refund(String reservationId) async {
    final url = Uri.parse('$_baseUrl/reservations/refund?id=$reservationId');
    print(url);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'reservationId': reservationId}), // Wrap reservationId in an object
    );

    // Log the response body for debugging
    print('Response body: ${response.body}');

    // Check for the success status
    if (response.statusCode == 201) {
      return response.body; // Assuming the response body is a valid JSON string
    } else {
      // If the server returns an error, throw an exception with details
      throw Exception('Failed to pay. Status code: ${response.statusCode}, body: ${response.body}');
    }
  }


}
