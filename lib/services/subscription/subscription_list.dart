import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneymanager/models/subscription_model.dart';

class SubscriptionListService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    return token;
  }

  Future<List<SubscriptionModel>?> fetchListSubscription() async {
    final url = 'http://185.170.198.166:8080/api/v1/user/subscriptions';

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
          List<SubscriptionModel> subcriptions = [];
          for (var category in responseData['data']) {
            subcriptions.add(SubscriptionModel.fromJson(category));
          }
          return subcriptions;
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
