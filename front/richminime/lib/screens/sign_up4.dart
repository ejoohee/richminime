import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:richminime/screens/login.dart';
import 'package:richminime/screens/sign_up.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:richminime/services/user_service.dart';

class SignUp4 extends StatefulWidget {
  final String organization;
  final String cardNumber;
  final String uuid;
  const SignUp4(
      {required this.organization,
      required this.cardNumber,
      required this.uuid,
      Key? key})
      : super(key: key);
  @override
  State<SignUp4> createState() => _SignUp4State();
}

class _SignUp4State extends State<SignUp4> with SingleTickerProviderStateMixin {
  bool isEmailVerified = false;
  final _formKey = GlobalKey<FormState>(); // Form 위젯에 키를 할당하여 유효성 검사에 사용
  late AnimationController _controller;
  late Animation<double> _animation;
  double percent = 0.75;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1), // 애니메이션의 지속시간
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.75, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          percent = _animation.value;
        });
      });
    _controller.forward();
  }

  // 이메일 유효성 검사를 위한 정규식
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController cardEmailController = TextEditingController();
  TextEditingController cardPasswordController = TextEditingController();
  TextEditingController cardNickNameController = TextEditingController();
  TextEditingController verificationController = TextEditingController();
  final userService = UserService();
  String enteredCode = "";

  onCheckCodeTap() async {
    enteredCode = verificationController.text;
    final email = cardEmailController.text;
    final response = await userService.checkCode(email, enteredCode);
    if (response == "true") {
      setState(() {
        isEmailVerified = true; // 인증 성공 시 변수를 true로 설정
      });
    } else {
      AlertDialog(
        title: Text(response),
      );
    }
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  showVerificationDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('이메일 인증'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('이메일로 발송된 인증번호를 입력하세요.'),
              TextFormField(
                controller: verificationController,
                decoration: const InputDecoration(
                  labelText: '인증번호',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // 인증번호 검증 로직
                // 대화상자 닫기
              },
              child: const Text('확인'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // 대화상자 닫기
              },
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }

  onVarificationButtonTap() async {
    String email = cardEmailController.text;
    if (emailRegex.hasMatch(email)) {
      final response = await userService.sendCheckEmail(email);
      if (response == "true") {
        await showVerificationDialog();
      } else {
        AlertDialog(
          title: Text(response),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('알림'),
            content: const Text('유효한 이메일을 입력하세요.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  onSignUpButtonTap() async {
    String email = cardEmailController.text;
    String password = cardPasswordController.text;
    String nickname = cardNickNameController.text;
    String organization = widget.organization;
    String cardNumber = widget.cardNumber;
    String uuid = widget.uuid;

    if (_formKey.currentState!.validate()) {
      final response = await userService.signUp(
          email, password, nickname, organization, cardNumber, uuid);
      if (response == "true") {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      } else {
        AlertDialog(
          title: Text(response),
        );
      }
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
            const SizedBox(height: 50),
            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: MediaQuery.of(context).size.width,
              animation: false,
              animationDuration: 1200,
              lineHeight: 30,
              percent: percent,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormField(
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
                          ),
                          GestureDetector(
                            onTap: onVarificationButtonTap,
                            child: Container(
                              alignment: Alignment.center,
                              width: 80,
                              height: 60,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFBEBE),
                                ),
                                child: const Text(
                                  "인증",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                            onTap: onSignUpButtonTap,
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
