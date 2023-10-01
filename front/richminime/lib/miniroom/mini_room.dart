import 'dart:ffi';
import 'package:richminime/constants/default_setting.dart';
import 'package:richminime/screens/closet.dart';
import 'package:richminime/screens/exchange_rate.dart';
import 'package:richminime/screens/interest_rate.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:flutter/material.dart';

class MiniRoom extends StatefulWidget {
  const MiniRoom({super.key});

  @override
  State<MiniRoom> createState() => _MiniRoomState();
}

class _MiniRoomState extends State<MiniRoom> {
  double posX = 150;
  double posY = 300;

  bool isMinimeTapped = false;
  showFeedback() {
    setState(() {
      isMinimeTapped = !isMinimeTapped;
    });
  }

  //잔액 보여주기
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                DefaultSetting.emptyRoom,
              ),
            ),
          ),
          width: double.infinity, //가로 꽉 차게 설정
          height: double.infinity,
        ),
        Positioned(
          left: 20,
          top: 175,
          child: GestureDetector(
            onDoubleTap: () {
              print('옷장 탭했다');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Closet(),
                ),
              );
            },
            child: Image.asset(
              DefaultSetting.closet,
              scale: 1.2,
            ),
          ),
        ),
        Positioned(
          left: 280,
          top: 215,
          child: GestureDetector(
            onDoubleTap: () {
              print('티비 탭했다');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InterestRate(),
                ),
              );
            },
            child: Hero(
              tag: 'TV',
              child: Image.asset(
                DefaultSetting.tv,
                scale: 1.5,
              ),
            ),
          ),
        ),
        Positioned(
          left: 178,
          top: 145,
          child: GestureDetector(
            onDoubleTap: () {
              print('지구본 탭했다');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExchangeRate(),
                ),
              );
            },
            child: Hero(
              tag: 'globe',
              child: Image.asset(
                DefaultSetting.globe,
                scale: 1.8,
              ),
            ),
          ),
        ),
        Positioned(
          left: posX,
          top: posY,
          child: GestureDetector(
            onDoubleTap: showFeedback,
            onScaleUpdate: (details) {
              setState(() {
                posX += details.focalPointDelta.dx;
                posY += details.focalPointDelta.dy;
              });
            },
            child: SimpleShadow(
              opacity: 1,
              sigma: 10,
              offset: const Offset(0, 0),
              color: Colors.white,
              child: Image.asset(
                DefaultSetting.minime,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 15,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: isVisible
                ? Row(
                    children: [
                      SimpleShadow(
                        opacity: 1,
                        sigma: 5,
                        offset: const Offset(0, 0),
                        color: Colors.white,
                        child: Image.asset(
                          'assets/images/miniroom/coin.png',
                          scale: 5,
                        ),
                      ),
                    ],
                  )
                : SimpleShadow(
                    child: Image.asset(
                      'assets/images/miniroom/handholdingmoneybag.png',
                      scale: 5,
                    ),
                  ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isMinimeTapped
                ? Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                          width: 8,
                          style: BorderStyle.solid,
                          color: Colors.black),
                      // color: Theme.of(context).cardColor,
                    ),
                    width: double.maxFinite, //가로 꽉 차게 설정
                    height: 100,
                    child: const Center(
                      child: Text(
                        "나는 거지지롱~~",
                        style: TextStyle(
                          fontFamily: "StarDust",
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ],
    );
  }
}
