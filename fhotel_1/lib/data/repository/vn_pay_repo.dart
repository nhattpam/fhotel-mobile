import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class VnPayRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  // Future<String> PaymentMethodVNPAY(String reservationId) async {
  //   final url = Uri.parse('$_baseUrl/reservations/$reservationId/pay');
  //   print(url);
  //   final data = {
  //     "reservationId": reservationId,
  //   };
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(data), // Wrap reservationId in a map
  //     );
  //
  //     // Check for the success status
  //     if (response.statusCode == 200) {
  //       try {
  //         final responseData = json.decode(response.body);
  //         return response.body; // Return a string from the response
  //       } catch (e) {
  //         // Handle JSON decode error
  //         print('Error decoding JSON: $e');
  //         throw Exception('Failed to decode JSON response: $e');
  //       }
  //     } else {
  //       // If the server returns an error, throw an exception with details
  //       throw Exception('Failed to pay. Status code: ${response.statusCode}, body: ${response.body}');
  //     }
  //   } catch (e) {
  //     // Catch any network or other errors and print them for debugging
  //     print('Error during pay: $e');
  //     throw Exception('Failed to pay due to: $e');
  //   }
  // }
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

