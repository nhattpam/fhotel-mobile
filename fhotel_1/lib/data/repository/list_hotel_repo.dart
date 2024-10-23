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
    print("This is image link " + url.toString());
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print("This is response image link " + responseData.toString());

      // Mapping the list of dynamic to List<RoomImage>
      return responseData.map((data) => HotelImage.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch hotel images.');
    }
  }


}
