import 'package:fhotel_1/data/models/hotel.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class ListHotelRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<List<Hotel>> getHotels() async {

    final url = Uri.parse('$_baseUrl/hotels');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((hotelJson) => Hotel.fromJson(hotelJson))
          .where((hotel) => hotel.isActive == true) // Filter active hotels
          .toList();
    } else {
      throw Exception('Failed to fetch hotel.');
    }
  }


}
