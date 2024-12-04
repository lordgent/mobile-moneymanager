import 'dart:convert';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneymanager/models/transaction_model.dart';

class TransactionService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    return token;
  }

  Future<List<TransactionModel>?> fetchTransactionService({
    required int offset,
    required int limit,
    String? startDate,
    String? endDate,
  }) async {
    const url = 'http://108.136.230.98:8080/api/v1/user/transactions';

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    DateTime currentDate = DateTime.now();

    startDate ??=
        dateFormat.format(DateTime(currentDate.year, currentDate.month, 1));

    endDate ??= dateFormat.format(currentDate);

    final Map<String, dynamic> body = {
      'offset': offset,
      'limit': limit,
      'startDate': startDate,
      'endDate': endDate,
    };

    print('Request body: $body');

    try {
      final token = await _getToken();
      if (token == null) {
        return null;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData != null && responseData['data'] != null) {
          List<TransactionModel> transactions = [];
          for (var transactionData in responseData['data']['data']) {
            transactions.add(TransactionModel.fromJson(transactionData));
          }
          return transactions;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
