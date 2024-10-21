abstract class CreateReservationView {

  void showValidationError(String field,String message);

  void onCreateSuccess();

  void onCreateTotalAmountSuccess(double totalAmount);

  void onCreateError(String error);
}
