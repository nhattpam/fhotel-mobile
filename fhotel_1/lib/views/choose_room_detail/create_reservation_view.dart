import 'package:fhotel_1/data/models/caculate.dart';

abstract class CreateReservationView {

  void showValidationError(String field,String message);

  void onCreateSuccess();

  void onCreateRefundSuccess(String message);

  void onCreateTotalAmountSuccess(double totalAmount);

  void onCalculateSuccess(PricingResult totalAmount);

  void onCreateAvailableRoomSuccess(int availableRoom);

  void onCreateError(String error);
}
