import 'package:flutter/material.dart';
import 'package:richminime/screens/sign_up4.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:richminime/services/user_service.dart';

class SignUp3 extends StatefulWidget {
  final String code;
  const SignUp3({required this.code, Key? key}) : super(key: key);

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> with SingleTickerProviderStateMixin {
  TextEditingController cardEmailController = TextEditingController();
  TextEditingController cardPasswordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _animation;
  double percent = 0.5;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1), // 애니메이션의 지속시간
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.5, end: 0.75).animate(_controller)
      ..addListener(() {
        setState(() {
          percent = _animation.value;
        });
      });

    _controller.forward();
  }

  Future<void> _showDialog(String message) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('알림'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // AlertDialog를 닫습니다.
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  Future onNextButtonTap() async {
    setState(() {
      isLoading = true; // 로딩 시작
    });
    String id = cardEmailController.text;
    String password = cardPasswordController.text;
    String organization = widget.code;
    print(id);
    print(password);
    print(organization);
    final userService = UserService();
    final response =
        await userService.getConnectedId(id, password, organization);
    print(response);
    setState(() {
      isLoading = false; // 로딩 완료
    });
    if (response.split(" ")[0] == "uuid") {
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUp4(
            uuid: response.split(" ")[1],
            organization: widget.code,
          ),
        ),
      );
    } else {
      _showDialog("카드사 정보를 확인해주세요."); // 다이얼로그로 메시지 표시
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 50),
                LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  width: MediaQuery.of(context).size.width,
                  animation: false,
                  animationDuration: 1200,
                  lineHeight: 30,
                  percent: percent,
                  center: const Text('3/4'),
                  barRadius: const Radius.circular(16),
                  progressColor: Colors.red[200],
                ),
                const SizedBox(height: 100),
                Text(
                  '카드사 정보를 입력해주세요',
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            labelText: '아이디',
                            fillColor: Color(0xFFFFFDFD),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: cardPasswordController,
                          obscureText: true,
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
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
