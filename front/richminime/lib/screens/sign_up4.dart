import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:richminime/screens/login.dart';
import 'package:richminime/screens/sign_up.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SignUp4 extends StatefulWidget {
  final String organization;
  final String cardNumber;
  const SignUp4(
      {required this.organization, required this.cardNumber, Key? key})
      : super(key: key);
  @override
  State<SignUp4> createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4> {
  final _formKey = GlobalKey<FormState>(); // Form 위젯에 키를 할당하여 유효성 검사에 사용

  // 이메일 유효성 검사를 위한 정규식
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController cardEmailController = TextEditingController();
  TextEditingController cardPasswordController = TextEditingController();
  TextEditingController cardNickNameController = TextEditingController();
  Future<void> onNextButtonTap() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
    print("여기닷");
    print(widget.cardNumber);
    // final url = Uri.parse("http://10.0.2.2:8080/api/user");

    // final response = await http.post(
    //   url,
    //   headers: {"Content-Type": "application/json"},
    //   body: json.encode(
    //     {
    //       "id": cardEmailController.text,
    //       "password": cardPasswordController.text,
    //       "nickname": cardNickNameController.text,
    //       "organiztion": widget.organization,
    //       "cardNumber": widget.cardNumber,
    //     },
    //   ),
    // );

    // if (response.statusCode == 201) {
    //   if (!context.mounted) return;
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const Login(),
    //     ),
    //   );
    // } else {
    //   AlertDialog(
    //     title: Text(response.body.toString()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // grid 같은 레이아웃을 사용하기 위해 Scaffold 위젯 사용
      backgroundColor: Theme.of(context).colorScheme.background, // 배경색 지정
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // Column 위젯을 사용하여 위젯을 세로로 배치
          children: [
            const SizedBox(height: 20),
            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: MediaQuery.of(context).size.width,
              animation: true,
              animationDuration: 1200,
              lineHeight: 30,
              percent: 1.0,
              center: const Text('4/4'),
              barRadius: const Radius.circular(16),
              progressColor: Colors.red[200],
            ),
            const SizedBox(height: 100),
            Text(
              '회원가입',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 300,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: cardEmailController,
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
                        controller: cardPasswordController,
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
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: cardNickNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '닉네임을 입력하세요.';
                          } else if (value.length < 2 || value.length > 8) {
                            return '닉네임은 2~8자리 사이여야 합니다.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          labelText: '닉네임',
                          fillColor: Color(0xFFFFFDFD),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await onNextButtonTap();
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
                                "다음",
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
      ),
    );
  }
}
