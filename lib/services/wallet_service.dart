import 'dart:convert';

import 'auth_service.dart';
import 'package:http/http.dart' as http;

class WalletService {
  final String baseUrl = 'https://bwabank.tech/api';

  Future<void> updatePin(String oldPin, String newPin) async {
    try {
      final String token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse('$baseUrl/wallets'),
        body: {
          'previous_pin': oldPin,
          'new_pin': newPin,
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print(res.body);

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
