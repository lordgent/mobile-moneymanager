import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneymanager/models/chart_income_expense.dart';

class ChartStickExpenseOrIncome {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    return token;
  }

  Future<List<ChartIncomeOrExpense>?> fetchChartStickExpenseOrIncome(
      {String? startDate, String? endDate, String? actionName}) async {
    const url = 'http://185.170.198.166:8080/api/v1/user/chart-expense';

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    DateTime currentDate = DateTime.now();

    startDate ??= dateFormat.format(currentDate.subtract(Duration(days: 6)));
    endDate ??= dateFormat.format(currentDate);

    final Map<String, dynamic> body = {
      'actionId': actionName,
      'startDate': startDate,
      'endDate': endDate,
    };

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
        print("$responseData");
        if (responseData != null && responseData['data'] != null) {
          List<ChartIncomeOrExpense> transactions = [];
          for (var transactionData in responseData['data']) {
            transactions.add(ChartIncomeOrExpense.fromJson(transactionData));
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
