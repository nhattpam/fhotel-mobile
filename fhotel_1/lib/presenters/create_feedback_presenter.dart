import 'package:fhotel_1/data/models/feedback.dart';
import 'package:fhotel_1/data/repository/create_feedback_repo.dart';
import 'package:fhotel_1/views/choose_room_detail/create_reservation_view.dart';

class CreateFeedbackPresenter {
  final CreateReservationView _view; // This is the interface for the view (e.g., LoginScreen)

  final CreateFeedbackRepo _repository = CreateFeedbackRepo(); // Create an instance of the network class

  CreateFeedbackPresenter(this._view); // Initialize with the view


  // This method will call the authenticate API and handle the result
  Future<Feedbacks> createFeedbacks(String reservationId,
      String comment,
      int hotelRating) async {
    try {
      // Create the final reservation with the calculated total amount
      Feedbacks feedbacks = Feedbacks(
        reservationId: reservationId,
        comment: comment,
        hotelRating: hotelRating,
      );
      // Call the repository to persist the reservation
      Feedbacks createdFeedback = await _repository.create(feedbacks);

      // Notify the view of success
      _view.onCreateSuccess();

      // Return the created reservation
      return createdFeedback;
    } catch (error) {
      // If there's an error, notify the view of the failure
      _view.onCreateError("Failed to create feedbacks");

      // Throw an error if reservation creation fails
      throw Exception("Failed to create feedbacks");
    }
  }
}