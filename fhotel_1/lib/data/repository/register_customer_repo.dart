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
    print(json.encode(user.toJson()));
    print(response.statusCode);
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (response.statusCode != 201) {
      throw Exception('Failed to register user');
    }

  }

  Future<User> activeAccountByOTP(String phone, String otp) async {
    final url = Uri.parse('$_baseUrl/authentications/verify?phoneNumber=$phone&otpCode=$otp');
    print(url);
    try {
      // Encode the email to handle special characters

      // Ensure the base URL is correct with https
      // Send a GET request
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      // Check for the success status
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Assuming the API returns a User object in JSON format
        return User.fromJson(responseData);
      } else {
        // If the server returns an error, throw an exception with details
        throw Exception('Failed to activate account. Status code: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      // Catch any network or other errors and print them for debugging
      print('Error during account activation: $e');
      throw Exception('Failed to activate account due to: $e');
    }
  }
}
