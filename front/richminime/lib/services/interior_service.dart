import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:richminime/models/interior_theme_model.dart';

const storage = FlutterSecureStorage();
const String baseUrl = Api.BASE_URL;

class InteriorService {
  // 전체 테마 불러오기(테마 상점)
  Future<dynamic> getAllItems() async {
    List<InteriorThemeModel> interiorInstances = [];

    final url = Uri.parse('$baseUrl/item');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    try {
      print('아이템받으러 간다잇');
      final response = await http.get(
        url,
        headers: headers,
      );
      print('바디 : ${response.body}');
      print('아이템받기 : ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> themes = jsonDecode(response.body);
        for (var theme in themes) {
          interiorInstances.add(InteriorThemeModel.fromJson(theme));
        }

        return interiorInstances;
      }
    } catch (e) {
      print('에러는 말이죵 : $e');
    }
    return null;
  }

  // 카테고리별 아이템 불러오기
  Future<dynamic> getAllItemsByCategory(String itemType) async {
    List<InteriorThemeModel> interiorInstances = [];

    final url = Uri.parse('$baseUrl/item?itemType=$itemType');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    try {
      print('아이템받으러 간다잇');
      final response = await http.get(
        url,
        headers: headers,
      );
      print('바디 : ${response.body}');
      print(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> themes = jsonDecode(response.body);
        for (var theme in themes) {
          interiorInstances.add(InteriorThemeModel.fromJson(theme));
        }

        return interiorInstances;
      }
    } catch (e) {
      print('에러는 말이죵 : $e');
    }
    return null;
  }

  // 소유한 전체 테마 불러오기-my
  Future<List<InteriorThemeModel>> getMyAllItems() async {
    List<InteriorThemeModel> myInteriorInstances = [];

    final url = Uri.parse('$baseUrl/item/my');

    // 토큰!!
    final response = await http.get(url, headers: {});

    if (response.statusCode == 200) {
      final List<dynamic> themes = jsonDecode(response.body);
      for (var theme in themes) {
        myInteriorInstances.add(InteriorThemeModel.fromJson(theme));
      }

      return myInteriorInstances;
    }
    throw Error();
  }

  // 테마 적용
  Future applyTheme(int itemId) async {
    final url = Uri.parse('$baseUrl/item/my$itemId');

    final response = await http.put(url, headers: {});
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    }
    throw Error();
  }

  // 테마 판매(삭제)
  Future sellTheme(int itemId) async {
    final url = Uri.parse('$baseUrl/item/my$itemId');

    final response = await http.delete(url, headers: {});
    if (response.statusCode == 201) {
      print(jsonDecode(response.body));
    }
    throw Error();
  }

  // 테마 구매
  Future buyTheme(int itemId) async {
    final url = Uri.parse('$baseUrl/item/my$itemId');

    final response = await http.post(url, headers: {});
    if (response.statusCode == 201) {
      print(jsonDecode(response.body));
    }
    throw Error();
  }
}
