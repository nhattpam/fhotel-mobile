abstract class CreateReservationView {

  void showValidationError(String field,String message);

  void onCreateSuccess();

  void onCreateTotalAmountSuccess(double totalAmount);

  void onCreateAvailableRoomSuccess(int availableRoom);

  void onCreateError(String error);
}
