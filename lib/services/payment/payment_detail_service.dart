import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneymanager/models/payment_detail_model.dart';

class PaymentDetailService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    print('Fetched Token: $token');
    return token;
  }

  Future<PaymentData?> fetchPaymentDetailInfo() async {
    const url = 'http://108.136.230.98:8080/api/v1/user/payment-detail';
    try {
      final token = await _getToken();
      if (token == null) {
        print('Token is null, cannot proceed with request.');
        return null;
      }

      print('Using Token: $token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print('API Response: $responseData');

        if (responseData != null && responseData['data'] != null) {
          return PaymentData.fromJson(responseData['data']);
        } else {
          print('No data found in API response');
          return null;
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}
