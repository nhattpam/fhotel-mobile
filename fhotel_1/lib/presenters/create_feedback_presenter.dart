import 'package:fhotel_1/data/models/feedback.dart';
import 'package:fhotel_1/data/repository/create_feedback_repo.dart';
import 'package:fhotel_1/views/write_review/create_feedback_view.dart';

class CreateFeedbackPresenter {
  final CreateFeedbackView _view; // This is the interface for the view (e.g., LoginScreen)

  final CreateFeedbackRepo _repository = CreateFeedbackRepo(); // Create an instance of the network class

  CreateFeedbackPresenter(this._view); // Initialize with the view


  // This method will call the authenticate API and handle the result
  Future<Feedbacks> createFeedbacks(String reservationId,
      String comment,
      int hotelRating,
      String createdDate) async {
    try {
      // Create the final reservation with the calculated total amount
      Feedbacks feedbacks = Feedbacks(
        reservationId: reservationId,
        comment: comment,
        hotelRating: hotelRating,
        createdDate: createdDate,
      );
      // Call the repository to persist the reservation
      Feedbacks createdFeedback = await _repository.create(feedbacks);
      // Return the created reservation
      return createdFeedback;
    } catch (error) {
      // Throw an error if reservation creation fails
      throw Exception("Failed to create feedbacks");
    }
  }
  void getFeedbacks(String reservationId) async {
    try {
      final feedback = await _repository.getFeedbackByReservationId(reservationId);
      _view.onGetFeedbackSuccess(feedback);
    } catch (e) {
      // _view.showError('Failed to load amenities');
    }
  }

  Future<void> updateFeedback(
      String feedbackId,
      String reservationId,
      String comment,
      int hotelRating,
      String createdDate,
      ) async {

    Feedbacks feedback = Feedbacks(feedbackId: feedbackId,reservationId: reservationId, comment: comment, hotelRating: hotelRating, createdDate: createdDate);

    bool success = await _repository.updateFeedbacks(feedback);

  }
}