import 'package:fhotel_1/data/repository/user_profile_repo.dart';

import '../views/user_profile/user_profile_view.dart';

class UserProfilePresenter {
  final UserProfileView _view;
  final UserProfile _repository = UserProfile(); // Initialize the network model

  UserProfilePresenter(this._view);

  // Function to get customer data by ID
  Future<void> getCustomerById() async {
    _view.showLoading(); // Show loading before fetching data
    try {
      // Call the network method to get the customer by ID
      final customer = await _repository.getUserByCustomerId();
      // Notify the view about success
      _view.onGetCustomerSuccess(customer);
    } catch (error) {
      // Notify the view about failure
      _view.onGetCustomerError('Error fetching customer: $error');
    } finally{
      _view.hideLoading(); // Hide loading after the process
    }
  }
}
