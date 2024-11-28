import 'package:fhotel_1/data/models/reservation.dart';
import 'package:fhotel_1/data/models/transaction.dart';
import 'package:http/http.dart' as http;

import '../../core/app_export.dart';

class ListTransactionRepo {
  final String _baseUrl = 'https://fhotelapi.azurewebsites.net/api';

  Future<List<Transaction>> getListTransactionByWalletId(String walletId) async {
    final url = Uri.parse('$_baseUrl/wallets/$walletId/transactions');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      // Mapping the list of dynamic to List<RoomImage>
      return responseData.map((data) => Transaction.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch list transaction.');
    }
  }
}
