import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moneymanager/models/category_report_model.dart';

class ReportCategoryService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    return token;
  }

  Future<ReportCategoryModel?> fetchCategoryReport() async {
    const url = 'http://108.136.230.98:8080/api/v1/user/financial/reports';

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
          return ReportCategoryModel.fromJson(responseData);
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
