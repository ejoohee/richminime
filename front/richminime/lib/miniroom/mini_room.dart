import 'dart:async';
import 'dart:ffi';
import 'package:richminime/constants/default_setting.dart';
import 'package:richminime/screens/closet.dart';
import 'package:richminime/screens/exchange_rate.dart';
import 'package:richminime/screens/interest_rate.dart';
import 'package:richminime/services/outer_service.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:flutter/material.dart';

class MiniRoom extends StatefulWidget {
  const MiniRoom({super.key});

  @override
  State<MiniRoom> createState() => _MiniRoomState();
}

class _MiniRoomState extends State<MiniRoom> {
  double posX = 150;
  double posY = 400;

  bool isMinimeTapped = false;
  showFeedback() {
    setState(() {
      isMinimeTapped = !isMinimeTapped;
    });
  }

  //잔액 보여주기
  bool isVisible = false;

//환율 받기
  String? erName, erIndex, erValue, erDate, erUnit;
  getER() async {
    final Future<financeInfoModel?> er = OuterService.getExchangeRate();

    try {
      financeInfoModel? financeData = await er;
      // 데이터를 사용할 수 있음
      erName = financeData?.name;
      erIndex = financeData?.index;
      erValue = financeData?.value;
      erDate = financeData?.date;
      erUnit = financeData?.unit;
    } catch (e) {
      // 오류 처리
      print('Error: $e');
    }
  }

// 기준금리 받기
  String? irName, irIndex, irValue, irDate, irUnit;

  getIR() async {
    final Future<financeInfoModel?> ir = OuterService.getInterestRate();

    try {
      financeInfoModel? financeData = await ir;
      // 데이터를 사용할 수 있음
      irName = financeData?.name;
      irIndex = financeData?.index;
      irValue = financeData?.value;
      irDate = financeData?.date;
      irUnit = financeData?.unit;

      // 이제 데이터를 사용할 수 있습니다.
    } catch (e) {
      // 오류 처리
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 현재 디바이스의 화면 크기 구하기
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final globeHeight = screenHeight / 3.5;
    final globeWidth = screenWidth * 0.41;

    final closetHeight = globeHeight + 30;
    final closetWidth = globeWidth - 150;

    final tvHeight = globeHeight + 68;
    final tvWidth = globeWidth + 102;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                DefaultSetting.emptyRoom,
              ),
            ),
          ),
        ),
        Positioned(
          left: closetWidth,
          top: closetHeight,
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
          left: tvWidth,
          top: tvHeight,
          child: GestureDetector(
            onDoubleTap: () async {
              await getIR();
              print('티비 탭했다');
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InterestRate(
                    name: irName,
                    index: irIndex,
                    value: irValue,
                    date: irDate,
                    unit: irUnit,
                  ),
                ),
              );
            },
            child: Hero(
              transitionOnUserGestures: true,
              tag: 'TV',
              child: Image.asset(
                DefaultSetting.tv,
                scale: 5,
              ),
            ),
          ),
        ),
        Positioned(
          left: globeWidth,
          top: globeHeight,
          child: GestureDetector(
            onDoubleTap: () async {
              await getER();

              print('지구본 탭했다');
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExchangeRate(
                    name: erName,
                    index: erIndex,
                    value: erValue,
                    date: erDate,
                    unit: erUnit,
                  ),
                ),
              );
            },
            child: Hero(
              tag: 'globe',
              child: Image.asset(
                DefaultSetting.globe,
                scale: 6,
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
