import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    const url = 'http://185.170.198.166:8080/api/v1/auth/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      print(json.encode({
        'email': email,
        'password': password,
      }));
      print(response.body);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData != null && responseData['data'] != null) {
          await _storage.write(
              key: 'token', value: responseData['data']['token']);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> isAuthenticated() async {
    String? token = await _storage.read(key: 'token');
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
}
