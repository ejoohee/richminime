// 금리뉴스 tv
// 환율 지구본
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:richminime/constants/default_setting.dart';
import 'package:richminime/services/outer_service.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ExchangeRate extends StatefulWidget {
  final List<financeInfoModel> fourER;

  const ExchangeRate({
    required this.fourER,
    Key? key,
  }) : super(key: key);
  @override
  State<ExchangeRate> createState() => _ExchangeRateState();
}

class _ExchangeRateState extends State<ExchangeRate> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.topRight,
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.2),
          ),
          child: IconButton.outlined(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white70,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Hero(
                tag: 'globe',
                child: SimpleShadow(
                  opacity: 1,
                  sigma: 30,
                  offset: const Offset(0, 0),
                  color: Colors.white,
                  child: Image.asset(
                    DefaultSetting.globe,
                    scale: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                // shape: ,
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                    width: 3,
                    style: BorderStyle.solid,
                    color: Colors.grey.shade400),
                // color: Theme.of(context).cardColor,
              ),
              width: double.maxFinite, //가로 꽉 차게 설정
              height: 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 이전 버튼 추가
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Visibility(
                          visible: currentIndex > 0,
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                currentIndex--;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            '${widget.fourER[currentIndex].name} ',
                            style: const TextStyle(
                                fontFamily: "StarDust",
                                fontSize: 27,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                      // 다음 버튼 추가
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Visibility(
                          visible: currentIndex < widget.fourER.length - 1,
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                currentIndex++;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  AnimatedTextKit(
                    key: ValueKey<int>(currentIndex), // currentIndex를 key로 사용

                    animatedTexts: [
                      TypewriterAnimatedText(
                        '${widget.fourER[currentIndex].index} : \n${widget.fourER[currentIndex].value} (${widget.fourER[currentIndex].unit}) ',
                        textStyle: const TextStyle(
                            fontFamily: "StarDust",
                            fontSize: 22,
                            color: Colors.black87),
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                  // Text(
                  //   '${widget.fourER[currentIndex].index} : \n${widget.fourER[currentIndex].value} (${widget.fourER[currentIndex].unit}) ',
                  //   style: const TextStyle(
                  //       fontFamily: "StarDust",
                  //       fontSize: 20,
                  //       color: Colors.black87),
                  //   textAlign: TextAlign.center,
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Text(
                    '기준시점 : ${widget.fourER[currentIndex].date!}',
                    style: const TextStyle(
                        fontFamily: "StarDust",
                        fontSize: 15,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ],
    );
  }
}
