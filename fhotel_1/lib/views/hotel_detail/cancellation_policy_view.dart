import 'package:fhotel_1/data/models/cancellation_policy.dart';
import 'package:fhotel_1/data/models/feedback.dart';

import '../../data/models/hotel.dart';
import '../../data/models/hotel_amenity.dart';

abstract class CancellationPolicyView {
  void showLoading();

  void hideLoading();

  void onGetCancellationPolicySuccess(CancellationPolicy cancellation);

  void onGetCancellationPolicyError(String error);
}
