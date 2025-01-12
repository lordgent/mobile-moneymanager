import 'dart:convert';
import 'package:intl/intl.dart'; 
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneymanager/models/income_exepense_model.dart';

class TotalExpenseOrIncomeService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    return token;
  }
  
  Future<IncomeOrExpense?> fetchTotalExpenseOrIncomeService({
    String? startDate,
    String? endDate,
    String? actionName
  }) async {
    const url = 'http://108.136.230.98:8080/api/v1/user/income-or-expense';

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    DateTime currentDate = DateTime.now();

    startDate ??= dateFormat.format(DateTime(currentDate.year, currentDate.month, 1));
    endDate ??= dateFormat.format(currentDate);

    final Map<String, dynamic> body = {
      'actionId': actionName,
      'startDate': startDate,
      'endDate': endDate,
    };



    print('Request body Income Expense: $body');

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
          IncomeOrExpense data = IncomeOrExpense.fromJson(responseData);
          return data;
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
