import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddExpenseService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    final token = await _storage.read(key: 'token');
    print('Fetched Token: $token');
    return token;
  }

  Future<bool> AddExpense(String amount, String categoryId, String imagePath,
      String title, String description, String categoryAction) async {
    const url = 'http://185.170.198.166:8080/api/v1/user/transaction/history';

    try {
      String? imageBase64;

      if (imagePath.isNotEmpty) {
        imageBase64 = await _encodeImage(imagePath);
      }

      print(json.encode({
        'amount': formatAmountWithoutDot(amount),
        'categoryId': categoryId,
        'categoryAction': categoryAction,
        'image': imagePath.isNotEmpty ? imageBase64 : '',
        'ext': imagePath.isNotEmpty ? getFileExtension(imagePath) : '',
        'name': imagePath.isNotEmpty ? getFileName(imagePath) : '',
        'description': description,
        'title': title,
      }));

      final token = await _getToken();
      if (token == null) {
        print('No token found');
        return false;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'amount': formatAmountWithoutDot(amount),
          'categoryId': categoryId,
          'categoryAction': categoryAction,
          'image': imagePath.isNotEmpty ? imageBase64 : '',
          'ext': imagePath.isNotEmpty ? getFileExtension(imagePath) : '',
          'name': imagePath.isNotEmpty ? getFileName(imagePath) : '',
          'description': description,
          'title': title,
        }),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData != null && responseData['data'] != null) {
          return true;
        } else {
          print('Invalid response data');
          return false;
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }

  String getFileName(String imagePath) {
    return imagePath.split('/').last;
  }

  String getFileExtension(String imagePath) {
    return imagePath.split('.').last;
  }

  String formatAmountWithoutDot(String amount) {
    return amount.replaceAll('.', '');
  }

  Future<String?> _encodeImage(String imagePath) async {
    print(imagePath);
    try {
      final file = File(imagePath);
      final bytes = await file.readAsBytes();

      String base64Image = base64Encode(bytes);

      // Remove base64 prefix if it exists
      if (base64Image.startsWith('data:image/')) {
        final index = base64Image.indexOf(';base64,');
        if (index != -1) {
          base64Image =
              base64Image.substring(index + 8); // Strip the data URL prefix
        }
      }
      return base64Image;
    } catch (e) {
      print('Error encoding image: $e');
      return null;
    }
  }
}
