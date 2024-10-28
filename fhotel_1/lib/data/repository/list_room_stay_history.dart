import 'package:fhotel_1/data/models/room_stay_history.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class ListRoomStayHistory {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<List<RoomStayHistory>> getRoomStayHistoryByReservationId(String reservationId) async {

    final url = Uri.parse('$_baseUrl/reservations/$reservationId/room-stay-histories');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Mapping the list of dynamic to List<RoomImage>
      return responseData.map((data) => RoomStayHistory.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch room stay history.');
    }
  }


}
