import 'package:fhotel_1/data/models/late_checkout_policy.dart';
import 'package:fhotel_1/data/repository/late_checkout_policy_repo.dart';
import 'package:fhotel_1/views/hotel_detail/late_checkout_policy_view.dart';

class LateCheckoutPolicyPresenter {
  final LateCheckoutPolicyView _view;
  final LateCheckoutPolicyRepo _policyRepo;

  LateCheckoutPolicyPresenter(this._view, this._policyRepo);

  // Method to get the list of policies
  Future<void> getLateCheckOutPolicies() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<LateCheckOutPolicy> policies = await _policyRepo.getLateCheckOutPolicies();
      _view.onGetLateCheckOutPoliciesSuccess(policies); // Pass the data to the view on success
    } catch (error) {
      _view.onGetLateCheckOutPoliciesError(error.toString()); // Pass the error to the view on failure
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }
}
