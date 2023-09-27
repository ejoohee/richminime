import "package:richminime/models/bankbook_model.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BankbookService {
  static const String baseUrl = Api.BASE_URL;
  final storage = const FlutterSecureStorage();

  Future<List<BankbookModel>> getAllTransactions() async {
    List<BankbookModel> bankbookInstance = [];

    final url = Uri.parse('$baseUrl/bankbook');
    final accessToken = await storage.read(key: "accessToken");
    final response = await http.get(url, headers: {
      "Authorization": "Bearer $accessToken",
    });
    // print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> transactions = jsonDecode(response.body);
      for (var transaction in transactions) {
        bankbookInstance.add(BankbookModel.fromJson(transaction));
      }
      return bankbookInstance;
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}
