abstract class VnPayView {
  // Method to handle successful payment
  void onPaymentSuccess(String link);

  // Method to handle payment errors
  void onPaymentError(String error);
}
