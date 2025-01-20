import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneymanager/models/create_payment_response.dart';

class SubscriptionCreateService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    return token;
  }

  Future<CreatePaymentResponse?> createSubscription(
      String subscriptionID, String paymentMethod) async {
    final url = 'http://108.136.230.98:8080/api/v1/user/payment';

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
        body: json.encode({
          'subscriptionId': subscriptionID,
          'paymentMethod': paymentMethod,
        }),
      );

      print(response.body);

      print(json.encode({
        'email': subscriptionID,
        'password': paymentMethod,
      }));

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData != null && responseData['data'] != null) {
          CreatePaymentResponse paymentResponse =
              CreatePaymentResponse.fromJson(responseData);
          return paymentResponse;
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
