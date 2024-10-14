import 'package:fhotel_1/data/models/hotel.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class HotelDetailRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<Hotel> getHotelByHotelId(String hotelId) async {

    final url = Uri.parse('$_baseUrl/hotels/$hotelId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return Hotel.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch hotel.');
    }
  }
}
