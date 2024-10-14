import 'package:http/http.dart' as http;
import '../../core/app_export.dart';
import '../models/user.dart';

class UserProfile {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';
  final customerId = SessionManager().getUserId();

  Future<User> getUserByCustomerId() async {

    final url = Uri.parse('$_baseUrl/users/$customerId');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return User.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch customer.');
    }
  }

  Future<bool> updateCustomer(User user) async {

    final url = Uri.parse('$_baseUrl/users/$customerId');
    print(url);
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any authentication headers here
        },
        body: jsonEncode(user.toJson()),
      );
      print(jsonEncode(user.toJson()));

      if (response.statusCode == 200) {
        return true; // Update successful
      } else {
        print('Failed to profile. Status code: ${response.statusCode}');
        return false; // Update failed
      }
    } catch (e) {
      throw Exception('Failed to update user');
    }
  }
}
