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

  Future<Feedbacks> getFeedbackByReservationId(String reservationId) async {
    final url = Uri.parse('$_baseUrl/reservations/$reservationId/feedbacks');
    print('Requesting URL: $url');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.isNotEmpty) {
        final feedback = Feedbacks.fromJson(responseData[0]);
        print((responseData[0]));
        print(feedback.comment);
        return feedback;
      } else {
        throw Exception('No feedback found for the provided reservation ID.');
      }
    } else {
      throw Exception('Failed to fetch feedback. Status code: ${response.statusCode}');
    }
  }

  Future<bool> updateFeedbacks(Feedbacks feedback) async {

    final url = Uri.parse('$_baseUrl/feedbacks/${feedback.feedbackId}');
    print(url);
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add any authentication headers here
        },
        body: jsonEncode(feedback.toJson()),
      );
      print(jsonEncode(feedback.toJson()));

      if (response.statusCode == 200) {
        return true; // Update successful
      } else {
        print('Failed to update feedback. Status code: ${response.statusCode}');
        return false; // Update failed
      }
    } catch (e) {
      throw Exception('Failed to update feedback');
    }
  }

}