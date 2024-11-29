import 'package:fhotel_1/data/models/cancellation_policy.dart';
import 'package:fhotel_1/data/models/feedback.dart';
import 'package:fhotel_1/data/models/hotel.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';
import '../models/hotel_amenity.dart';

class CancellationPolicyRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<CancellationPolicy> getCancellationPolicyByHotelId(String hotelId) async {

    final url = Uri.parse('$_baseUrl/hotels/$hotelId/cancellation-policies');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return CancellationPolicy.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch cancellation-policies.');
    }
  }

}
