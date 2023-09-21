import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:richminime/screens/login.dart';
import 'package:richminime/screens/sign_up.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  TextEditingController cardEmailController = TextEditingController();
  TextEditingController cardPasswordController = TextEditingController();
  TextEditingController cardNickNameController = TextEditingController();
  Future<void> onNextButtonTap() async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const SignUp(),
    //   ),
    // );
    print("여기닷");
    final url = Uri.parse("http://10.0.2.2:8080/api/user");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          "id": cardEmailController.text,
          "password": cardPasswordController.text,
          "nickname": cardNickNameController.text,
          "organiztion": widget.organization,
          "cardNumber": widget.cardNumber,
        },
      ),
    );

    if (response.statusCode == 201) {
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // Column 위젯을 사용하여 위젯을 세로로 배치
          children: [
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
                child: Column(
                  children: [
                    TextField(
                      controller: cardEmailController,
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
                      controller: cardPasswordController,
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
                    const SizedBox(height: 10),
                    TextField(
                      controller: cardNickNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          onTap: onNextButtonTap,
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
          ],
        ),
      ),
    );
  }
}
