import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/screens/home_screen.dart';
import 'package:richminime/screens/sign_up.dart';
import 'package:richminime/services/user_service.dart';
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
  onLoginTap() async {
    String email = emailController.text;
    String password = passwordController.text;
    if (_formKey.currentState!.validate()) {
      final isloggedin = await UserService().login(email, password);
      if (isloggedin) {
        if (!context.mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }
  }

  static const storage = FlutterSecureStorage(); //flutter_secure_storage
  // 이메일 유효성 검사를 위한 정규식
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  void initState() {
    super.initState();
    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    String? token = await storage.read(key: "accessToken");
    // print(token);

    if (!context.mounted) return;
    //token의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (token != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("로그인이 필요합니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("확인"),
                ),
              ],
            );
          });
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                            onTap: onLoginTap,
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
