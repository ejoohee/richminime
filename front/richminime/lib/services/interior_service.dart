import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:richminime/models/interior_theme_model.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
const String baseUrl = Api.BASE_URL;

class HttpInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final token = await storage.read(key: "accessToken");
    if (token != null) {
      data.headers["Authorization"] = "Bearer $token";
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401 || data.statusCode == 500) {
      String? accessToken = await storage.read(key: "accessToken");
      String? refreshToken = await storage.read(key: "refreshToken");
      print(accessToken);
      print(refreshToken);
      final url = Uri.parse('$baseUrl/user/reissue-token');
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          "Refresh-Token": "$refreshToken",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        String? newAccessToken = responseBody['accessToken'];
        String? newRefreshToken = responseBody['refreshToken'];

        await storage.write(key: "accessToken", value: newAccessToken);
        await storage.write(key: "refreshToken", value: newRefreshToken);

        final originalRequestData = data.request;
        originalRequestData?.headers["Authorization"] =
            "Bearer $newAccessToken";
      }
    }
    return data;
  }
}

class InteriorService {
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  // 전체 테마 불러오기(테마 상점)
  Future<List<InteriorThemeModel>> getAllItems() async {
    List<InteriorThemeModel> interiorInstances = [];

    final url = Uri.parse('$baseUrl/item');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    print('아이템받으러 간다잇');
    final response = await client.get(
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
    } else if (response.statusCode == 401) {
      return getAllItems();
    }

    return interiorInstances;
  }

  // // 카테고리별 아이템 불러오기
  // Future<dynamic> getAllItemsByCategory(String itemType) async {
  //   List<InteriorThemeModel> interiorInstances = [];

  //   final url = Uri.parse('$baseUrl/item?itemType=$itemType');
  //   final token = await storage.read(key: "accessToken");
  //   final headers = {
  //     'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
  //   };

  //   print('아이템받으러 간다잇');
  //   final response = await http.get(
  //     url,
  //     headers: headers,
  //   );
  //   print('바디 : ${response.body}');
  //   print(response.statusCode);

  //   if (response.statusCode == 200) {
  //     final List<dynamic> themes = jsonDecode(response.body);
  //     for (var theme in themes) {
  //       interiorInstances.add(InteriorThemeModel.fromJson(theme));
  //     }

  //     return interiorInstances;
  //   } else if (response.statusCode == 401 || response.statusCode == 500) {
  //     return getAllItemsByCategory(itemType);
  //   }
  //   return null;
  // }

  // 소유한 전체 테마 불러오기-my
  Future<List<InteriorThemeModel>> getMyAllItems() async {
    List<InteriorThemeModel> myInteriorInstances = [];

    final url = Uri.parse('$baseUrl/item/my');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    // 토큰!!
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> themes = jsonDecode(response.body);
      for (var theme in themes) {
        myInteriorInstances.add(InteriorThemeModel.fromJson(theme));
      }

      return myInteriorInstances;
    } else if (response.statusCode == 401) {
      return getMyAllItems();
    }

    return myInteriorInstances;
  }

  // 테마 적용
  Future applyTheme(int itemId) async {
    final url = Uri.parse('$baseUrl/item/my$itemId');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    final response = await http.put(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      return applyTheme(itemId);
    }
    throw Error();
  }

  // 아이템 판매(삭제)
  Future<String> sellItem(int itemId) async {
    final url = Uri.parse('$baseUrl/item/my/$itemId');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    final response = await http.delete(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      int sellPrice = responseData['sellPrice'];
      int balance = responseData['balance'];
      await storage.write(key: 'balance', value: balance.toString());

      return '$sellPrice 코인에 판매되었습니다.\n잔액 : $balance 코인';
    } else if (response.statusCode == 401) {
      return sellItem(itemId);
    } else if (response.statusCode == 403) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String msg = responseData['msg'];
      return msg;
    }
    return '띠용- 판매 실패!';
  }

  // 아이템 구매
  Future<String> buyItem(int itemId) async {
    final url = Uri.parse('$baseUrl/item/my/$itemId');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };
    print(token);
    final response = await http.post(
      url,
      headers: headers,
    );
    print(url);
    print(response.statusCode);
    print('응답은요 ${response.body}');
    if (response.statusCode == 201) {
      Map<String, dynamic> responseData = json.decode(response.body);
      int balance = responseData['balance'];
      // 스토리지 업데이트
      await storage.write(key: 'balance', value: balance.toString());

      return '구매확정!\n잔액 : $balance 코인';
    } else if (response.statusCode == 401) {
      return buyItem(itemId);
    } else if (response.statusCode == 403) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String msg = responseData['msg'];

      return msg;
    }
    //에러 핸들
    return '띠용- 구매 실패!';
  }
}
