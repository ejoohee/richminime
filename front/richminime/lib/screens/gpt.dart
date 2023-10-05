import 'package:flutter/material.dart';
import 'package:richminime/services/gpt_service.dart';
import 'package:richminime/widgets/appbar_back_home.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:convert';

class Gpt extends StatefulWidget {
  const Gpt({super.key});

  @override
  State<Gpt> createState() => _GptState();
}

class _GptState extends State<Gpt> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _imageSize = 50;
  Alignment _alignment = Alignment.topCenter;
  bool hasAnswer = false; // 답변을 받았는지 확인하는 변수
  String answer = ""; // 서버로부터 받은 답변을 저장할 변수
  TextEditingController questionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animateImageSizeAndAlignment();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateImageSizeAndAlignment() async {
    await Future.delayed(const Duration(seconds: 0));
    setState(() {
      _imageSize = 500;
      _alignment = Alignment.topCenter;
    });
  }

  void getAnswerFromGpt() async {
    GptService gptService = GptService();
    final response = await gptService.getGpt(questionController.text);
    if (response != '서버 오류') {
      // JSON 응답을 파싱합니다.
      Map<String, dynamic> parsedResponse = jsonDecode(response);

      // 원하는 필드를 추출합니다.
      String actualAnswer = parsedResponse['choices'][0]['message']['content'];

      setState(() {
        hasAnswer = true;
        answer = actualAnswer; // 추출한 답변을 저장합니다.
      });
    } else {
      setState(() {
        hasAnswer = true;
        answer = '서버 오류';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBackHome(title: '지니 봇'),
      backgroundColor: Colors.grey[600],
      body: Stack(
        children: [
          AnimatedAlign(
            alignment: _alignment,
            duration: const Duration(seconds: 2),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: _imageSize,
                  height: _imageSize,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: const [Colors.white, Colors.transparent],
                      stops: [0.5, 0.5 + 0.5 * _controller.value],
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/minime/gpt.png",
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.maxFinite,
                height: 300,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                      width: 3,
                      style: BorderStyle.solid,
                      color: Colors.grey.shade400),
                ),
                child: Column(
                  children: [
                    if (!hasAnswer) // 답변을 받지 않았다면
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            '무엇을 도와드릴까요?',
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            speed: const Duration(milliseconds: 70),
                          ),
                        ],
                        totalRepeatCount: 1,
                        displayFullTextOnTap: true,
                      ),
                    if (!hasAnswer) // 답변을 받지 않았다면
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: questionController,
                          decoration: const InputDecoration(
                            hintText: ' 여기에 질문을 입력하세요.',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    if (!hasAnswer)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: getAnswerFromGpt,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue[600],
                              ),
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(10),
                              child: const Text(
                                '질문하기',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (hasAnswer) // 답변을 받았다면
                      Column(
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                answer,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                speed: const Duration(milliseconds: 70),
                              ),
                            ],
                            totalRepeatCount: 1,
                            displayFullTextOnTap: true,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hasAnswer = false; // 다시 질문을 할 수 있도록 설정
                                    questionController.text = " ";
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text(
                                    '계속 질문하기',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text(
                                    '그만하기',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
