import 'package:fhotel_1/data/models/refund_policy.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class RefundPolicyRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<List<RefundPolicy>> getRefundPolicies() async {

    final url = Uri.parse('$_baseUrl/refund-policies');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData
          .map((policy) => RefundPolicy.fromJson(policy))
          .toList();
    } else {
      throw Exception('Failed to fetch policy.');
    }
  }
}
