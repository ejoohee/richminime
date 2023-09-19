import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:richminime/screens/sign_up.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> onLoginButtonTap() async {
    final url = Uri.parse("http://localhost:8080/api/user/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "email": emailController.text,
        "password": passwordController.text,
      }),
    );
    // print(emailController.text);
    // print(passwordController.text);
    if (response.statusCode == 201) {
    } else {
      // 로그인 실패 or 서버 오류
      // 오류 메시지를 표시하거나 다른 적절한 처리를 수행하세요.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // grid 같은 레이아웃을 사용하기 위해 Scaffold 위젯 사용
      backgroundColor: Theme.of(context).colorScheme.background, // 배경색 지정
      body: Column(
        // Column 위젯을 사용하여 위젯을 세로로 배치
        children: [
          Flexible(
            // Flexible 위젯을 사용하여 위젯의 크기를 유동적으로 지정
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                '로그인하기',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: '이메일',
                        fillColor: Color(0xFFFFFDFD),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true, // 비밀번호 숨기기 옵션
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: '비밀번호',
                        fillColor: Color(0xFFFFFDFD),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: onLoginButtonTap,
                          child: Container(
                            alignment: Alignment.center,
                            width: 110,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFBEBE),
                            ),
                            child: const Text(
                              "로그인",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 110,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFBEBE),
                              borderRadius: BorderRadius.zero,
                            ),
                            child: const Text(
                              "회원가입",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
