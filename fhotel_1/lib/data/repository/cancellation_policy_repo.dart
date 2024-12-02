import 'dart:convert';
import 'package:fhotel_1/data/models/cancellation_policy.dart';
import 'package:http/http.dart' as http;

class CancellationPolicyRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<CancellationPolicy> getCancellationPolicyByHotelId(String hotelId) async {
    final url = Uri.parse('$_baseUrl/hotels/$hotelId/cancellation-policies');
    print("Request URL: $url");

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print("Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData[0]);
      if (responseData.isNotEmpty) {
        // Parse and return the first item in the list
        return CancellationPolicy.fromJson(responseData[0]);
      } else {
        // Throw an exception if the list is empty
        throw Exception('No cancellation policies found for the provided hotel.');
      }
    } else {
      throw Exception('Failed to fetch cancellation policies.');
    }
  }
}
