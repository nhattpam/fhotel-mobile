import 'package:fhotel_1/data/models/room_image.dart';
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
      throw Exception('Failed to load list room types');
    }
  }

  Future<List<RoomImage>> getRoomImageByRoomTypeId(String roomTypeId) async {
    final url = Uri.parse('$_baseUrl/room-types/$roomTypeId/room-images');
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
      return responseData.map((data) => RoomImage.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch room images.');
    }
  }

  Future<RoomType> getRoomTypesByRoomId(String roomTypeId) async {

    final url = Uri.parse('$_baseUrl/room-types/$roomTypeId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return RoomType.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch room type.');
    }
  }

}
