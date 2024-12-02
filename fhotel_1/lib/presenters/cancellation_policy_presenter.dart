import 'package:fhotel_1/data/models/cancellation_policy.dart';
import 'package:fhotel_1/data/repository/cancellation_policy_repo.dart';
import 'package:fhotel_1/views/hotel_detail/cancellation_policy_view.dart';

class CancellationPolicyPresenter {
  final CancellationPolicyView _view;
  final CancellationPolicyRepo _repository = CancellationPolicyRepo(); // Initialize the network model

  CancellationPolicyPresenter(this._view);

  // Function to get customer data by ID
  Future<void> getCancellationPolicyByHotelId(String hotelId) async {
    _view.showLoading();
    try {
      final cancellationPolicy = await _repository.getCancellationPolicyByHotelId(hotelId);
      print(cancellationPolicy.toString() + "This is presenter");
      _view.onGetCancellationPolicySuccess(cancellationPolicy);
    } catch (error) {
      _view.onGetCancellationPolicyError(error.toString());
    } finally {
      _view.hideLoading();
    }
  }

}
