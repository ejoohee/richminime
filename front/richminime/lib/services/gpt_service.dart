import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:richminime/models/clothing_model.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/models/user_clothing_model.dart';
import 'package:richminime/interceptor/interceptor.dart';

const storage = FlutterSecureStorage();
const String baseUrl = Api.BASE_URL;

class GptService {
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<String> getGpt(String? string) async {
    String answer;
    final token = await storage.read(key: "accessToken");
    final url = Uri.parse('$baseUrl/prompt');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"request": string}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      answer = jsonDecode(response.body)['response'];
      return answer;
    } else {
      return "서버 오류";
    }
  }
}
