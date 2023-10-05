import "package:richminime/models/bankbook_model.dart";
import 'dart:convert';
import 'package:richminime/constants/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/interceptor/interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart'; // 추가

class BankbookService {
  static const String baseUrl = Api.BASE_URL;
  final storage = const FlutterSecureStorage();
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<List<BankbookModel>> getAllBankBookList() async {
    List<BankbookModel> bankbookInstance = [];

    final url = Uri.parse('$baseUrl/bankbook');
    final accessToken = await storage.read(key: "accessToken");
    final response = await client.get(url, headers: {
      "Authorization": "Bearer $accessToken",
    });

    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = jsonDecode(response.body);
      for (var bankbook in decodedData) {
        bankbookInstance.add(BankbookModel.fromJson(bankbook));
      }
      return bankbookInstance;
    } else {
      getAllBankBookList();
      throw Exception('Failed to load bankbook data');
    }
  }
}
