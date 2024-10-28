import 'package:fhotel_1/data/models/order.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class OrderRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';
  final customerId = SessionManager().getUserId();

  Future<Order> create(Order order) async {
    final url = Uri.parse('$_baseUrl/orders');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(order.toJson()),
      );

      print('Response Body: ${response.body}');

      // Check if the request was successful
      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);

        // Parse the created reservation from the response
        Order createdOrder = Order.fromJson(jsonResponse);
        // Return the newly created reservation
        return createdOrder;
      } else {
        print('Failed to create order: ${response.statusCode}');
        throw Exception('Failed to create order');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error creating order');
    }
  }

  Future<List<Order>> getOrderByCustomerlId() async {

    final url = Uri.parse('$_baseUrl/users/$customerId/orders');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Mapping the list of dynamic to List<RoomImage>
      return responseData.map((data) => Order.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch order by customer id.');
    }
  }

}
