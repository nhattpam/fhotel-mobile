import 'package:fhotel_1/data/models/room_facility.dart';
import 'package:fhotel_1/data/models/room_image.dart';
import 'package:fhotel_1/data/models/room_types.dart';
import 'package:fhotel_1/data/models/type.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class ListRoomTypeRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<List<RoomType>> fetchRoomTypesByHotelId(String hotelId) async {
    final response = await http.get(Uri.parse('$_baseUrl/hotels/$hotelId/room-types'));
    print("This is" + response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((data) => RoomType.fromJson(data))
          .where((roomType) => roomType.isActive == true) // Filter active RoomTypes
          .toList();
    } else {
      throw Exception('Failed to load list room types');
    }
  }

  Future<List<RoomImage>> getRoomImageByRoomTypeId(String roomTypeId) async {
    final url = Uri.parse('$_baseUrl/room-types/$roomTypeId/room-images');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
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

  Future<double> getRoomPriceByRoomId(String roomTypeId) async {

    final url = Uri.parse('$_baseUrl/room-types/$roomTypeId/today-price');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return responseData;
    } else {
      throw Exception('Failed to fetch room price.');
    }
  }

  Future<List<RoomType>> getRoomTypes() async {

    final url = Uri.parse('$_baseUrl/room-types');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((roomTypeJson) => RoomType.fromJson(roomTypeJson))
          .where((roomType) => roomType.isActive == true) // Filter active hotels
          .toList();
    } else {
      throw Exception('Failed to fetch room types.');
    }
  }

  Future<List<Types>> getTypes() async {

    final url = Uri.parse('$_baseUrl/types');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((typeJson) => Types.fromJson(typeJson))
          .toList();
    } else {
      throw Exception('Failed to fetch types.');
    }
  }


  Future<List<RoomFacility>> getFacilityByRoomTypeId(String roomTypeId) async {

    final url = Uri.parse('$_baseUrl/room-types/$roomTypeId/room-facilities');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((typeJson) => RoomFacility.fromJson(typeJson))
          .toList();
    } else {
      throw Exception('Failed to fetch room facility.');
    }
  }
  Future<RoomImage> getSingleRoomImageByRoomTypeId(String roomTypeId) async {
    final url = Uri.parse('$_baseUrl/room-types/$roomTypeId/room-images');
    print(url);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.isNotEmpty) {
        final roomImage = RoomImage.fromJson(responseData[0]);
        print((responseData[0]));
        return roomImage;
      } else {
        throw Exception('No image found for the provided room ID.');
      }
    } else {
      throw Exception('Failed to fetch room image. Status code: ${response.statusCode}');
    }
  }

}
