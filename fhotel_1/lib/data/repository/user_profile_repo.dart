import 'package:http/http.dart' as http;
import '../../core/app_export.dart';
import '../models/user.dart';

class UserProfile {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<User> getUserByCustomerId() async {
    final customerId = SessionManager().getUserId();

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
}
