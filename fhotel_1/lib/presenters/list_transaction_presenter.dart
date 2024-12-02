import 'package:fhotel_1/data/models/transaction.dart';
import 'package:fhotel_1/data/repository/list_transaction_repo.dart';
import 'package:fhotel_1/views/my_transaction_history/my_transaction_view.dart';
class ListTransactionPresenter {
  final MyTransactionView _view;
  final ListTransactionRepo _reservationRepo;

  ListTransactionPresenter(this._view, this._reservationRepo);

  // Method to get the list of hotels
  Future<void> getListTransactionByWalletId(String walletId) async {
    _view.showLoading(); // Show loading before fetching data
    try {
      List<Transaction> transactions = await _reservationRepo.getListTransactionByWalletId(walletId);
      // Reservation? reservation = await _reservationRepo.getFirstCheckInReservationByCustomerId();
      _view.onGetTransactionsSuccess(transactions); // Pass the data to the view on success
      // print(reservation);
      // showPaymentNotification(reservation!);

    } catch (error) {
      _view.onGetTransactionsError(error.toString()); // Pass the error to the view on failure
    } finally {
      _view.hideLoading(); // Hide loading after the process
    }
  }

}
