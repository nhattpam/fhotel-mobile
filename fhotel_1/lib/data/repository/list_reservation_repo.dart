import 'package:fhotel_1/data/models/reservation.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';
import '../models/user.dart';

class ListReservationRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';
  final customerId = SessionManager().getUserId();

  Future<List<Reservation>> getListReservationByCustomerId() async {
    final url = Uri.parse('$_baseUrl/users/$customerId/reservations');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Mapping the list of dynamic to List<RoomImage>
      return responseData.map((data) => Reservation.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch list reservation.');
    }
  }

}
