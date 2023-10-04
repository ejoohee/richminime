import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:richminime/models/clothing_model.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/models/user_clothing_model.dart';

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

class ClothingService {
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  // 전체 옷 조회(카테고리 별) - 옷가게
  Future<List<ClothingModel>> getAllClothings(String? clothingType) async {
    List<ClothingModel> clothingInstances = [];

    final url = Uri.parse('$baseUrl/clothing?clothingType=$clothingType');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    final response = await client.get(
      url,
      headers: headers, // 헤더 추가
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> clothings = jsonDecode(response.body);
      print(clothings);
      for (var clothing in clothings) {
        clothingInstances.add(ClothingModel.fromJson(clothing));
      }

      return clothingInstances;
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return getAllClothings(clothingType);
    }
    return clothingInstances;
  }

  // 옷 구매
  Future<String> buyClothing(int clothingId) async {
    final url = Uri.parse('$baseUrl/clothing/my?clothingId=$clothingId');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    final response = await client.post(
      url,
      headers: headers,
    );
    // Map<String, dynamic> requestBody = {
    //   "clothingId": clothingId,
    // };

    // // 데이터를 JSON 문자열로 변환
    // String requestBodyJson = jsonEncode(requestBody);

    print(response.statusCode);
    print('응답은요 ${response.body}');
    if (response.statusCode == 201) {
      Map<String, dynamic> responseData = json.decode(response.body);
      int balance = responseData['balance'];
      // 스토리지 업데이트
      await storage.write(key: 'balance', value: balance.toString());
      return '구매확정!\n잔액 : $balance 코인';
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return buyClothing(clothingId);
    } else if (response.statusCode == 403) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String msg = responseData['msg'];

      return msg;
    }
    //에러 핸들
    return '구매 실패';
  }

  // 옷 팔기(삭제)
  Future sellClothing(int clothingId) async {
    final url = Uri.parse('$baseUrl/clothing/my/$clothingId');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };
    final response = await client.delete(
      url,
      headers: headers,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      //삭제된 옷장 재 렌더링(response로 보내줌)
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return sellClothing(clothingId);
    }
    throw Error();
  }

  // 내가 소유한 옷 전체 불러오기-my
  Future<List<UserClothingModel>> getMyAllClothings(
      String? clothingType) async {
    List<UserClothingModel> myClothingInstances = [];

    final url = Uri.parse('$baseUrl/clothing/my?clothingType=$clothingType');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    final response = await client.get(
      url,
      headers: headers,
    );
    print('내옷장불러오기 : ${response.statusCode}');
    print('응답은요 : ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> clothings = jsonDecode(response.body);
      for (var clothing in clothings) {
        myClothingInstances.add(UserClothingModel.fromJson(clothing));
      }

      return myClothingInstances;
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return getMyAllClothings(clothingType);
    }
    return myClothingInstances;
  }
}
