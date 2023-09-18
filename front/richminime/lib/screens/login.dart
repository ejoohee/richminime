import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:richminime/screens/signup.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

onSignUpButtonTap() async {
  final url = Uri.parse("https://google.com");
  await launchUrl(url);
}

class _LoginState extends State<Login> {
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
                    const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: '이메일',
                        fillColor: Color(0xFFFFFDFD),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      obscureText: true, // 비밀번호 숨기기 옵션
                      decoration: InputDecoration(
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
                          onTap: onSignUpButtonTap,
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
