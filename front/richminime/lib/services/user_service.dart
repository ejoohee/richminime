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

class UserService {
  static const String baseUrl = Api.BASE_URL;
  static const storage = FlutterSecureStorage();

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
      final String? nickname = responseData['nickname'];
      final String balance =
          responseData['balance'].toString(); // value에 int가 들어갈 수 없음.
      if (token != null) {
        await storage.write(key: "accessToken", value: token);
        await storage.write(key: "nickname", value: nickname);
        await storage.write(key: "balance", value: balance);
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

    print(response.body.toString());
    if (response.statusCode == 201) {
      final uuid = jsonDecode(response.body)['uuid'];
      return "uuid $uuid";
    } else {
      return response.body.toString();
    }
  }

  Future<String> sendCheckEmail(String email) async {
    final url = Uri.parse("$baseUrl/user/check-login-email");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {"email": email},
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
      body: {
        "email": email,
        "code": code,
      },
    );

    if (response.statusCode == 200) {
      return "true";
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
