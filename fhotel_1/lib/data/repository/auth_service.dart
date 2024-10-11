import 'package:http/http.dart' as http;

import '../../core/app_export.dart';
import '../models/user.dart';

class AuthService {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<User> authenticate(String email, String password) async {
    final url = Uri.parse('$_baseUrl/authentications/login');
    final loginData = {
      "email": email,
      "password": password,
    };
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginData),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      // Access the JWT token from the response
      final jwtToken = responseData['data'];

      Map<String, dynamic> payload = Jwt.parseJwt(jwtToken);
      // Print the payload
      print("This is payload " + payload.toString());
      // Print one of its property(example: email):
      final userId = payload['Id'].toString();
      final userRole = payload['role'].toString();
      await SessionManager().init();
      // Set the userId in session
      print("This is userId "+ userId.toString());
      if(userRole.toString() == 'Customer')
        {
          SessionManager().setUserId(userId);
          print(SessionManager().getUserId());
          return User.fromJson(responseData);
        }
      else{
        throw Exception('You are not allowed to login.');
      }
    } else {
      throw Exception('Failed to authenticate user.');
    }
  }
}