import 'package:fhotel_1/data/models/room_types.dart';

import '../models/hotel_amenity.dart';

import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class ListRoomTypeRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<List<RoomType>> fetchRoomTypesByHotelId(String hotelId) async {
    final response = await http.get(Uri.parse('$_baseUrl/hotels/$hotelId/room-types'));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((data) => RoomType.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load amenities');
    }
  }

}
