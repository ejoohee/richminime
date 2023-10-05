import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:richminime/models/clothing_model.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/models/room_item_model.dart';

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

class MiniroomService {
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<String> requestFeedback() async {
    final url = Uri.parse('$baseUrl/feedback');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String feedback = responseData['content'];
      return feedback;
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return requestFeedback();
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

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['clothingId'] == 100000) {
        return '';
      }
      final String character = responseData['clothingApplyImg'];
      return character;
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return getCharacter();
    } else if (response.statusCode == 400) {
      // 아무것도 안 입었음?
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
    String requestBodyJson = jsonEncode(requestBody);
    final response = await client.put(
      url,
      headers: headers,
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      return '적용되었습니다.미니룸에서 확인해주세요!';
    } else if (response.statusCode == 401) {
      return applyCharacter(clothingId);
    }
    return '다시 시도해주세요.';
  }

  // 룸 불러오기
  Future<List<RoomItemModel>> getRoom() async {
    final List<RoomItemModel> roomItemInstances = [];
    final url = Uri.parse('$baseUrl/room');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      for (var item in responseData) {
        roomItemInstances.add(RoomItemModel.fromJson(item));
      }
      // return roomItemInstances;
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return getRoom();
    }
    return roomItemInstances;
  }

  Future<String> applyRoomItem(int itemId) async {
    final url = Uri.parse('$baseUrl/room');
    final token = await storage.read(key: "accessToken");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // accessToken을 헤더에 추가
    };

    // 요청 본문에 보낼 데이터를 맵(Map) 형태로 구성합니다.
    Map<String, dynamic> requestBody = {
      "itemId": itemId, // 옷
    };

    // 데이터를 JSON 문자열로 변환합니다.
    String requestBodyJson = jsonEncode(requestBody);
    final response = await client.put(
      url,
      headers: headers,
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['itemId'] == 100000 ||
          responseData['itemId'] == 100001 ||
          responseData['itemId'] == 100002) {
        return '이미 적용된 아이템이라 그냥 벗겼습니다.\n억울하면 다시 선택해주세용~';
      }
      return '적용되었습니다.\n 미니룸에서 확인해주세요 >3<';
    } else if (response.statusCode == 401) {
      return applyRoomItem(itemId);
    }
    return '다시 시도해주세요.';
  }
}
