import 'package:fhotel_1/data/models/reservation.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class CreateReservationRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<void> create(Reservation reservation) async {
    final url = Uri.parse('$_baseUrl/reservations');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(reservation.toJson()),
      );
      print(json.encode(reservation.toJson()));
      print('Status Code: ${response.statusCode}');
      final jsonResponse = jsonDecode(response.body);
      print('Response Body: $jsonResponse');

      if (response.statusCode == 201) {
        print('Reservation created successfully');
      } else {
        print('Failed to create reservation: ${response.statusCode}');
        throw Exception('Failed to create reservation');
      }
    } catch (error) {
      print('Error: $error');
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

}
