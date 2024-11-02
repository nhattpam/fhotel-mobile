import 'package:fhotel_1/data/models/feedback.dart';
import 'package:fhotel_1/data/models/hotel.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';
import '../models/hotel_amenity.dart';

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

  Future<List<HotelAmenity>> fetchAmenitiesByHotelId(String hotelId) async {
    final response = await http.get(Uri.parse('$_baseUrl/hotels/$hotelId/hotel-amenities'));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((data) => HotelAmenity.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load amenities');
    }
  }
  Future<List<Feedbacks>> fetchFeedbacksByHotelId(String hotelId) async {
    final response = await http.get(Uri.parse('$_baseUrl/hotels/$hotelId/feedbacks'));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((data) => Feedbacks.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load feedback');
    }
  }


}
