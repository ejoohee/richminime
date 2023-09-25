import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:richminime/screens/home_screen.dart';
import 'package:richminime/screens/sign_up.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>(); // Form 위젯에 키를 할당하여 유효성 검사에 사용

  // 이메일 유효성 검사를 위한 정규식
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> onLoginButtonTap() async {
    final url = Uri.parse("http://10.0.2.2:8080/api/user/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "email": emailController.text,
          "password": passwordController.text,
        },
      ),
    );

    if (response.statusCode == 200) {
      if (!context.mounted) return;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      AlertDialog(
        title: Text(response.body.toString()),
      );
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '이메일을 입력하세요.';
                          } else if (!emailRegex.hasMatch(value)) {
                            return '유효한 이메일을 입력하세요.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          labelText: '이메일',
                          fillColor: Color(0xFFFFFDFD),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true, // 비밀번호 숨기기 옵션
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호를 입력하세요.';
                          } else if (value.length < 8 || value.length > 16) {
                            return '비밀번호는 8~16자리 사이여야 합니다.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
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
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await onLoginButtonTap();
                              }
                            },
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
          ),
        ],
      ),
    );
  }
}
