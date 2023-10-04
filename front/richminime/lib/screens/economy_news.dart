// 환율 지구본
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:richminime/constants/default_setting.dart';
import 'package:richminime/services/outer_service.dart';
import 'package:simple_shadow/simple_shadow.dart';

class EconomyNews extends StatefulWidget {
  final List<financeInfoModel> economyNews;
  const EconomyNews({
    required this.economyNews,
    Key? key,
  }) : super(key: key);
  @override
  State<EconomyNews> createState() => _EconomyNewsState();
}

class _EconomyNewsState extends State<EconomyNews> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.topRight,
          decoration: const BoxDecoration(
            color: Colors.black87,
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
                tag: 'TV',
                child: SimpleShadow(
                  opacity: 1,
                  sigma: 30,
                  offset: const Offset(0, 0),
                  color: Colors.white,
                  child: Image.asset(
                    DefaultSetting.tv,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        child: Column(
                          children: [
                            const Text(
                              '오늘의 늬우스',
                              style: TextStyle(
                                  fontFamily: "StarDust",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 27,
                                  color: Colors.black87),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '-${widget.economyNews[currentIndex].name}-',
                              style: const TextStyle(
                                  fontFamily: "StarDust",
                                  fontSize: 15,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      // 다음 버튼 추가
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Visibility(
                          visible: currentIndex < widget.economyNews.length - 1,
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
                        '${widget.economyNews[currentIndex].index} : \n${widget.economyNews[currentIndex].value} (${widget.economyNews[currentIndex].unit}) ',
                        textStyle: const TextStyle(
                            fontFamily: "StarDust",
                            fontWeight: FontWeight.w700,
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
                    '기준 시점 : ${widget.economyNews[currentIndex].date!}',
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
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
