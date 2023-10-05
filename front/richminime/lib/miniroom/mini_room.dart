import 'dart:async';
import 'dart:ffi';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/constants/default_setting.dart';
import 'package:richminime/models/room_item_model.dart';
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

  // TV더블탭 >> 기준금리 등 뉴스 받기
  late List<financeInfoModel> economyNews;

  getIR() async {
    final List<financeInfoModel> en = await OuterService.getEconomyNews();

    try {
      List<financeInfoModel> financeData = en;
      // 데이터를 사용할 수 있음
      economyNews = financeData;
      // 이제 데이터를 사용할 수 있다.
    } catch (e) {
      // 오류 처리
      print('Error: $e');
    }
  }

  // 미니미 캐릭터 받아오기
  String minime = '';
  bool changed = false;
  //잔액도 보여주기
  var balance;

  loadMinime() async {
    balance = await storage.read(key: "balance");
    String tmpMinime = await miniroomService.getCharacter();
    if (tmpMinime != '') {
      minime = tmpMinime;
      changed = true;
    }
    if (mounted) {
      setState(() {
        // 상태 업데이트 코드
      });
    }
  }

  // 룸 불러오기
  String roomBackground = '';
  String roomRug = '';
  // String roomFurniture = '';
  loadMiniroom() async {
    final List<RoomItemModel> tmpMiniroom = await miniroomService.getRoom();

    for (var item in tmpMiniroom) {
      if (item.itemType == '벽지장판') {
        if (item.itemId != 100000) {
          roomBackground = item.itemImg!;
        }
      } else if (item.itemType == '가구') {
        if (item.itemId == 100001) {
          //디폴트 가구세팅 아직 없지만 혹시몰라서...
        }
      } else if (item.itemType == '러그') {
        if (item.itemId != 100002) {
          roomRug = item.itemImg!;
        }
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadMinime();
    loadMiniroom();
  }

// balance 볼래말래
  bool isVisible = false;
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
//  roomBackground == ''
//                   ? AssetImage(
//                       DefaultSetting.emptyRoom,
//                     )
//                   :
    return Stack(
      children: [
        roomBackground == ''
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        DefaultSetting.emptyRoom,
                      )),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(roomBackground),
                  ),
                ),
              ),
        if (roomRug != '')
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(roomRug),
                  ),
                ),
              ),
              const SizedBox(
                height: 300,
              )
            ],
          ),
        Positioned(
          left: closetWidth,
          top: closetHeight,
          child: GestureDetector(
            onDoubleTap: () {
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
              child: changed
                  ? Image.network(
                      minime,
                      width: 100,
                      height: 100,
                    )
                  : Image.asset(
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
