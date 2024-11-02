import 'package:fhotel_1/data/models/feedback.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class CreateFeedbackRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<Feedbacks> create(Feedbacks feedback) async {
    final url = Uri.parse('$_baseUrl/feedbacks');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(feedback.toJson()),
      );
      print(json.encode(feedback.toJson()));
      print('Response Body: ${response.body}');


      // Check if the request was successful
      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);

        // Parse the created reservation from the response
        Feedbacks createdReservation = Feedbacks.fromJson(jsonResponse);
        // Return the newly created reservation
        return createdReservation;
      } else {
        print('Failed to create feedback: ${response.statusCode}');
        throw Exception('Failed to create feedback');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error creating feedback');
    }
  }
}