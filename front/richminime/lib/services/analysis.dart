import "package:richminime/models/bankbook_model.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/interceptor/interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart'; // 추가
import 'package:richminime/models/analysis_model.dart';

class AnalysisService {
  static const String baseUrl = Api.BASE_URL;
  final storage = const FlutterSecureStorage();
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<SpendingData> getSpendingData() async {
    final url = Uri.parse('$baseUrl/spending/month');
    final accessToken = await storage.read(key: "accessToken");
    final response = await client.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      return SpendingData.fromJson(decodedData);
    } else {
      getSpendingData();
      throw Exception('Failed to load spending data');
    }
  }
}
