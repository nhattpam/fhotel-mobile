import 'package:fhotel_1/data/models/refund_policy.dart';
import 'package:fhotel_1/data/repository/refund_policy_repo.dart';
import 'package:fhotel_1/views/hotel_detail/refund_policy_view.dart';

class RefundPolicyPresenter {
  final RefundPolicyView _view;
  final RefundPolicyRepo _policyRepo;

  RefundPolicyPresenter(this._view, this._policyRepo);

  // Method to get the list of policies
  Future<void> getRefundPolicies() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<RefundPolicy> policies = await _policyRepo.getRefundPolicies();
      _view.onGetRefundPoliciesSuccess(policies); // Pass the data to the view on success
    } catch (error) {
      _view.onGetRefundPoliciesError(error.toString()); // Pass the error to the view on failure
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }
}
