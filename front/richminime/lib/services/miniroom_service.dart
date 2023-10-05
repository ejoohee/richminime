import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:richminime/models/clothing_model.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/interceptor/interceptor.dart';

const storage = FlutterSecureStorage();
const String baseUrl = Api.BASE_URL;

class MiniroomService {
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<String> requestFeedback() async {
    final url = Uri.parse('$baseUrl/feedback');
    final token = await storage.read(key: "accessToken");
    final response = await client.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String feedback = responseData['content'];
      return feedback;
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      requestFeedback();
      return 'false';
    }
    throw Error();
  }

  // 입은 거 불러오기
  Future<String> getCharacter() async {
    final url = Uri.parse('$baseUrl/character');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };
    final response = await http.get(
      url,
      headers: headers,
    );

    print('캐릭터를 불러왔는데염  ${response.body}');
    print('상태코드 : ${response.statusCode}');
    if (response.statusCode == 200) {
      // final Map<String, dynamic> responseData = jsonDecode(response.body);
      // final String feedback = responseData['content'];
      // return feedback;
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return getCharacter();
    } else if (response.statusCode == 400) {
      // 아무것도 안 입었음
      return '';
    }
    return '';
  }

  // 적용하기
  Future<String> applyCharacter(int clothingId) async {
    final url = Uri.parse('$baseUrl/character');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    // 요청 본문에 보낼 데이터를 맵(Map) 형태로 구성합니다.
    Map<String, dynamic> requestBody = {
      "clothingId": clothingId, // 옷
    };

    // 데이터를 JSON 문자열로 변환합니다.
    String requestBodyJson = json.encode(requestBody);
    final response = await client.put(
      url,
      headers: headers,
      body: requestBodyJson,
    );

    print('캐릭터를 고친 것에 대한 응답  ${response.body}');
    print('상태코드 : ${response.statusCode}');
    if (response.statusCode == 200) {
      return '적용되었습니다.미니룸에서 확인해주세요!';
    } else if (response.statusCode == 401) {
      return applyCharacter(clothingId);
    }
    return '다시 시도해주세요.';
  }
}
