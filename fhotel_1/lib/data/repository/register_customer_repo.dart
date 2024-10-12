import 'package:http/http.dart' as http;

import '../../core/app_export.dart';
import '../models/user.dart';

class RegisterCustomerRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<void> register(User user) async {

    final url = Uri.parse('$_baseUrl/authentications/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register user');
    }

  }
}
