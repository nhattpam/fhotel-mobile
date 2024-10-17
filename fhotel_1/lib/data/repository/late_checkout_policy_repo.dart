import 'package:fhotel_1/data/models/late_checkout_policy.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class LateCheckoutPolicyRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<List<LateCheckOutPolicy>> getLateCheckOutPolicies() async {

    final url = Uri.parse('$_baseUrl/late-check-out-policies');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((policy) => LateCheckOutPolicy.fromJson(policy))
          .toList();
    } else {
      throw Exception('Failed to fetch policy.');
    }
  }
}
