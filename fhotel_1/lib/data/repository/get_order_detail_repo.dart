import 'package:fhotel_1/data/models/order_detail.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class GetOrderDetailRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<OrderDetail> getOrderDetailByOrderId(String orderId) async {

    final url = Uri.parse('$_baseUrl/orders/$orderId/order-details');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      return OrderDetail.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch order detail by order id.');
    }
  }

}
