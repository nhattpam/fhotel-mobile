import 'dart:convert';
import 'package:fhotel_1/data/models/service.dart';
import 'package:http/http.dart' as http;

class ListServiceRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<List<Services>> getServices() async {

    final url = Uri.parse('$_baseUrl/services');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((hotelJson) => Services.fromJson(hotelJson))
          .toList();
    } else {
      throw Exception('Failed to fetch services.');
    }
  }
}
