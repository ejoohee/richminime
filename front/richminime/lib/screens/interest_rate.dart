// 환율 지구본
import 'package:flutter/material.dart';
import 'package:richminime/constants/default_setting.dart';
import 'package:simple_shadow/simple_shadow.dart';

class InterestRate extends StatefulWidget {
  const InterestRate({super.key});

  @override
  State<InterestRate> createState() => _InterestRateState();
}

class _InterestRateState extends State<InterestRate> {
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
                    scale: 0.7,
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
              height: 150,
              child: const Center(
                child: Text(
                  "오늘의 금리",
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
