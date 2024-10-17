import 'package:fhotel_1/data/models/refund_policy.dart';

abstract class RefundPolicyView {
  void showLoading();
  void hideLoading();
  void onGetRefundPoliciesSuccess(List<RefundPolicy> policies);
  void onGetRefundPoliciesError(String error);
}
