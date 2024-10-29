import 'package:fhotel_1/data/models/hotel.dart';
import 'package:fhotel_1/data/models/hotel_image.dart';
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

  Future<List<HotelImage>> getHotelImageByHotelId(String hotelId) async {

    final url = Uri.parse('$_baseUrl/hotels/$hotelId/hotel-images');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Mapping the list of dynamic to List<RoomImage>
      return responseData
          .map((data) => HotelImage.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to fetch hotel images.');
    }
  }

  Future<HotelImage> getSingleHotelImageByHotelId(String hotelId) async {
    final url = Uri.parse('$_baseUrl/hotels/$hotelId/hotel-images');
    print('Requesting URL: $url');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.isNotEmpty) {
        final hotelImage = HotelImage.fromJson(responseData[0]);
        print((responseData[0]));
        return hotelImage;
      } else {
        throw Exception('No image found for the provided hotel ID.');
      }
    } else {
      throw Exception('Failed to fetch hotel image. Status code: ${response.statusCode}');
    }
  }
}
