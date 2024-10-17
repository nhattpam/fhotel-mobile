import 'package:fhotel_1/data/models/late_checkout_policy.dart';

abstract class LateCheckoutPolicyView {
  void showLoading();
  void hideLoading();
  void onGetLateCheckOutPoliciesSuccess(List<LateCheckOutPolicy> policies);
  void onGetLateCheckOutPoliciesError(String error);
}
