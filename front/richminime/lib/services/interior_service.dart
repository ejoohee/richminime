import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:richminime/models/interior_theme_model.dart';

class InteriorService {
  static const String baseUrl = Api.BASE_URL;

  // 전체 테마 불러오기(테마 상점)
  Future<List<InteriorThemeModel>> getAllThemes() async {
    List<InteriorThemeModel> interiorInstances = [];

    final url = Uri.parse('$baseUrl/item');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> themes = jsonDecode(response.body);
      for (var theme in themes) {
        interiorInstances.add(InteriorThemeModel.fromJson(theme));
      }

      return interiorInstances;
    }
    throw Error();
  }

  // 소유한 전체 테마 불러오기-my
  Future<List<InteriorThemeModel>> getMyAllThemes() async {
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
