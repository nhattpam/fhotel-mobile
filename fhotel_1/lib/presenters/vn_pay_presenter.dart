import 'package:fhotel_1/data/repository/vn_pay_repo.dart';
import 'package:fhotel_1/views/checkout/vn_pay_view.dart';


class VnPayPresenter {
  final VnPayView _view;// This is the interface for the view (e.g., LoginScreen)

  final VnPayRepo _repository = VnPayRepo(); // Create an instance of the network class

  VnPayPresenter(this._view); // Initialize with the view

  // This method will call the authenticate API and handle the result

  Future<void> PaymentMethodVNPAY(String reservationId) async {
    try {
      final user = await _repository.PaymentMethodVNPAY(reservationId);
      print("This is " + user);
      _view.onPaymentSuccess(user);
    } catch (error) {
      print(error);
    }
  }
}
