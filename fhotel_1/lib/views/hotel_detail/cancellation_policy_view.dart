import 'package:fhotel_1/data/models/cancellation_policy.dart';

abstract class CancellationPolicyView {
  void showLoading();

  void hideLoading();

  void onGetCancellationPolicySuccess(CancellationPolicy cancellation);

  void onGetCancellationPolicyError(String error);
}
