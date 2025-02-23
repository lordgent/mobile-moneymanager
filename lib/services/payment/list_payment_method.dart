import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneymanager/models/PaymentResponse.dart'; // Ensure you have the correct path

class PaymentMethodService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Function to retrieve the token
  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    return token;
  }

  // Fetch list of payment methods
  Future<PaymentMethodsResponse?> fetchListPayment() async {
    final url = 'http://185.170.198.166:8080/api/v1/user/payment-method';

    try {
      final token = await _getToken();
      if (token == null) {
        return null;
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData != null && responseData['data'] != null) {
          var data = responseData['data'];
          PaymentMethodsResponse payments =
              PaymentMethodsResponse.fromJson(data);
          return payments;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      // Catch and print any errors
      print('Error: $e');
      return null;
    }
  }
}
