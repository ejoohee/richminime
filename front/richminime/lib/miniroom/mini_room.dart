import 'dart:async';
import 'dart:ffi';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/constants/default_setting.dart';
import 'package:richminime/screens/closet.dart';
import 'package:richminime/screens/exchange_rate.dart';
import 'package:richminime/screens/economy_news.dart';
import 'package:richminime/services/miniroom_service.dart';
import 'package:richminime/services/outer_service.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:flutter/material.dart';

const storage = FlutterSecureStorage();

class MiniRoom extends StatefulWidget {
  const MiniRoom({super.key});

  @override
  State<MiniRoom> createState() => _MiniRoomState();
}

class _MiniRoomState extends State<MiniRoom> {
  final MiniroomService miniroomService = MiniroomService();
  double posX = 150;
  double posY = 400;

  // 미니미 더블탭 >> 어제 소비에 대한 피드백
  bool isMinimeTapped = false;
  showFeedback() {
    setState(() {
      isMinimeTapped = !isMinimeTapped;
    });
  }

  // 지구본 더블탭 >> 환율
  late List<financeInfoModel> fourER;
  getER() async {
    final List<financeInfoModel> er = await OuterService.getExchangeRate();

    try {
      List<financeInfoModel> financeData = er;
      // 데이터를 사용할 수 있음
      fourER = financeData;
    } catch (e) {
      // 오류 처리
      print('Error: $e');
    }
  }

  // TV더블탭 >> 기준금리 및 뉴스 받기
  late List<financeInfoModel> economyNews;

  getIR() async {
    final List<financeInfoModel> en = await OuterService.getEconomyNews();

    try {
      List<financeInfoModel> financeData = en;
      // 데이터를 사용할 수 있음
      economyNews = financeData;
      // 이제 데이터를 사용할 수 있습니다.
    } catch (e) {
      // 오류 처리
      print('Error: $e');
    }
  }

  // 미니미 캐릭터 받아오기
  String minime = DefaultSetting.minime;
  bool isLoaded = false;
  //잔액 보여주기
  var balance;

  loadMinime() async {
    balance = await storage.read(key: "balance");
    print('토큰 $balance');
    String tmpMinime = await miniroomService.getCharacter();
    print('캐릭터 옷? : $tmpMinime');
    if (tmpMinime == '') {
      return;
    } else {
      minime = tmpMinime;
      isLoaded = true;
    }
    setState(() {});
  }

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    loadMinime();
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
                  builder: (context) => EconomyNews(
                    economyNews: economyNews,
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
                  builder: (context) => ExchangeRate(fourER: fourER),
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
              child: isLoaded
                  ? Image.network(
                      minime,
                      width: 100,
                      height: 100,
                    )
                  : Image.asset(
                      minime,
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
                      Text(
                        balance,
                        style: const TextStyle(
                          fontSize: 20,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0, 0), // 그림자의 위치 (X, Y)
                              blurRadius: 10, // 그림자의 흐림 정도
                              color: Colors.white, // 그림자의 색상
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
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
