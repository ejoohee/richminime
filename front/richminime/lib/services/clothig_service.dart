import 'dart:convert';
import 'package:richminime/constants/api.dart';
import 'package:richminime/models/clothing_model.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/models/user_clothing_model.dart';
import 'package:richminime/interceptor/interceptor.dart';

const storage = FlutterSecureStorage();
const String baseUrl = Api.BASE_URL;

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
    print('옷가게 전체 조회 ${response.body.length}개의 옷 정보 ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> clothings = jsonDecode(response.body);
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
    return '띠용- 구매 실패!';
  }

  // 옷 판매(삭제)
  Future sellClothing(int userClothingId) async {
    final url = Uri.parse('$baseUrl/clothing/my/$userClothingId');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };
    final response = await client.delete(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      int sellPrice = responseData['sellPrice'];
      int balance = responseData['balance'];
      await storage.write(key: 'balance', value: balance.toString());

      return '$sellPrice 코인에 판매되었습니다.\n잔액 : $balance 코인';
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return sellClothing(userClothingId);
    }
    return '띠용- 판매 실패!';
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
