import 'package:fhotel_1/data/models/reservation.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class CreateReservationRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<void> create(Reservation reservation) async {

    final url = Uri.parse('$_baseUrl/reservations');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(reservation.toJson()),
    );
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode != 201) {
      throw Exception('Failed to create reservation');
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
