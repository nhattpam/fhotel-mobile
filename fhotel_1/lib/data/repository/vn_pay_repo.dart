import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class VnPayRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<String> PaymentMethodVNPAY(String reservationId) async {
    final url = Uri.parse('$_baseUrl/reservations/$reservationId/pay');
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
    if (response.statusCode == 200) {
      return response.body; // Assuming the response body is a valid JSON string
    } else {
      // If the server returns an error, throw an exception with details
      throw Exception('Failed to pay. Status code: ${response.statusCode}, body: ${response.body}');
    }
  }

}

