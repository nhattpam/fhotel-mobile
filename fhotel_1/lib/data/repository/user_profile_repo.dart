import 'package:http/http.dart' as http;

import '../../core/app_export.dart';
import '../models/user.dart';
import '../models/wallet.dart';

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

  Future<Wallet> getWalletByCustomerId() async {

    final url = Uri.parse('$_baseUrl/users/$customerId/wallets');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return Wallet.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch wallet.');
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

  Future<bool> updateWallet(Wallet wallet) async {

    final url = Uri.parse('$_baseUrl/wallets/${wallet.walletId}');
    print(url);
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any authentication headers here
        },
        body: jsonEncode(wallet.toJson()),
      );
      print(jsonEncode(wallet.toJson()));

      if (response.statusCode == 200) {
        return true; // Update successful
      } else {
        print('Failed to update wallet. Status code: ${response.statusCode}');
        return false; // Update failed
      }
    } catch (e) {
      throw Exception('Failed to update wallet');
    }
  }
}
