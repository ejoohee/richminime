// 금리뉴스 tv
// 환율 지구본
import 'package:flutter/material.dart';
import 'package:richminime/constants/default_setting.dart';
import 'package:simple_shadow/simple_shadow.dart';

class ExchangeRate extends StatefulWidget {
  const ExchangeRate({super.key});

  @override
  State<ExchangeRate> createState() => _ExchangeRateState();
}

class _ExchangeRateState extends State<ExchangeRate> {
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
                    scale: 0.8,
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
              height: 150,
              child: const Center(
                child: Text(
                  "오늘의 환율",
                  style: TextStyle(
                      fontFamily: "StarDust",
                      fontSize: 20,
                      color: Colors.black87),
                ),
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
