import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    print('Fetched Token: $token');
    return token;
  }


  Future<bool> register(String email, String password,String fullName,String phoneNumber) async {
    const url = 'http://108.136.230.98:8080/api/v1/auth/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'email': email,
          'password': password,
        }),
      );

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

  
  Future<bool> verificationOtp(String code) async {
    const url = 'http://108.136.230.98:8080/api/v1/auth/verification-account';
      final token = await _getToken();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'code': code,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData != null && responseData['data'] != null) {
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


}
