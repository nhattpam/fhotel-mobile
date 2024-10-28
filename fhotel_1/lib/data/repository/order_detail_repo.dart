import 'package:fhotel_1/data/models/order_detail.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class OrderDetailRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<OrderDetail> create(OrderDetail orderDetail) async {
    final url = Uri.parse('$_baseUrl/order-details');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(orderDetail.toJson()),
      );

      print('Response Body: ${response.body}');

      // Check if the request was successful
      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);

        // Parse the created reservation from the response
        OrderDetail createdOrderDetail = OrderDetail.fromJson(jsonResponse);
        // Return the newly created reservation
        return createdOrderDetail;
      } else {
        print('Failed to create order detail: ${response.statusCode}');
        throw Exception('Failed to create order detail');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error creating order detail');
    }
  }
}
