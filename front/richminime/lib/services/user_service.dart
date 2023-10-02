import "package:richminime/models/bankbook_model.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:richminime/constants/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:richminime/screens/home_screen.dart';
import 'package:richminime/screens/login.dart';
import 'package:richminime/screens/sign_up.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:cookie_jar/cookie_jar.dart';

const String baseUrl = Api.BASE_URL;
const storage = FlutterSecureStorage();

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
    if (data.statusCode == 401) {
      String? accessToken = await storage.read(key: "accessToken");
      var cj = CookieJar();
      List<Cookie> cookies = await cj.loadForRequest(Uri.parse(baseUrl));
      String? refreshToken;
      for (var cookie in cookies) {
        if (cookie.name == 'refresh_token') {
          refreshToken = cookie.value;
          break;
        }
      }
      final url = Uri.parse('$baseUrl/user/reissue-token');
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          "Refresh-Token": "$refreshToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        String? newAccessToken =
            responseBody['accessToken']; // Adjust this according to your API

        // Update the stored access token
        await storage.write(key: "accessToken", value: newAccessToken);

        // Retry the original request with the new access token
        data.headers?["Authorization"] = "Bearer $newAccessToken";
        // Here you should re-execute the original request.
        // This part depends on your HTTP client's implementation.
      }
    }
    return data;
  }
}

class UserService {
  final client = InterceptedClient.build(interceptors: [HttpInterceptor()]);

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/user/login');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String? token = responseData['accessToken'];
      final String? refreshToken = responseData['refreshToken'];
      final String? nickname = responseData['nickname'];
      final String balance =
          responseData['balance'].toString(); // value에 int가 들어갈 수 없음.
      if (token != null) {
        await storage.write(key: "accessToken", value: token);
        await storage.write(key: "nickname", value: nickname);
        await storage.write(key: "balance", value: balance);
        await storage.write(key: "refreshToken", value: refreshToken);
        return true;
      }
    }
    return false;
  }

  Future<String> getConnectedId(String id, String password, String organization,
      String cardNumber) async {
    final url = Uri.parse('$baseUrl/user/connected-id');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "id": id,
          "password": password,
          "organization": organization,
          "cardNumber": cardNumber,
        },
      ),
    );

    if (response.statusCode == 201) {
      final uuid = jsonDecode(response.body)['uuid'];
      return "uuid $uuid";
    } else {
      return response.body.toString();
    }
  }

  Future<String> checkEmail(String email) async {
    final url = Uri.parse("$baseUrl/user/check-login-email?email=$email");

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (responseBody['success'] == true) {
        return "true";
      } else {
        return "false";
      }
    } else {
      return response.body.toString();
    }
  }

  Future<String> sendCheckEmailCode(String email) async {
    final url = Uri.parse("$baseUrl/user/send-email-code?email=$email");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );

    if (response.statusCode == 200) {
      return "true";
    } else {
      return response.body.toString();
    }
  }

  Future<String> checkCode(String email, String code) async {
    final url = Uri.parse("$baseUrl/user/check-email-code");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "code": code,
      }),
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (responseBody['success'] == true) {
        return "true";
      } else {
        return "false";
      }
    } else {
      return response.body.toString();
    }
  }

  Future<String> signUp(String email, String password, String nickname,
      String organization, String cardNumber, String uuid) async {
    final url = Uri.parse("$baseUrl/user");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "email": email,
          "password": password,
          "nickname": nickname,
          "organization": organization,
          "cardNumber": cardNumber,
          "uuid": uuid,
        },
      ),
    );
    if (response.statusCode == 201) {
      return "true";
    } else {
      return response.body.toString();
    }
  }
}
