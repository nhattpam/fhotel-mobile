import 'dart:convert';

import 'package:fhotel_1/data/models/service_type.dart';
import 'package:http/http.dart' as http;

class ServiceTypeRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<List<ServiceType>> getServiceTypes() async {

    final url = Uri.parse('$_baseUrl/service-types');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((hotelJson) => ServiceType.fromJson(hotelJson))
          .toList();
    } else {
      throw Exception('Failed to fetch service type.');
    }
  }
}
