import 'dart:ffi';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:richminime/miniroom/mini_room.dart';
import 'package:richminime/models/clothing_model.dart';
import 'package:richminime/models/user_clothing_model.dart';
import 'package:richminime/services/clothig_service.dart';
import 'package:richminime/services/miniroom_service.dart';

class Closet extends StatefulWidget {
  const Closet({super.key});

  @override
  State<Closet> createState() => _ClosetState();
}

class _ClosetState extends State<Closet> {
  final ClothingService clothingService = ClothingService();
  final MiniroomService miniroomService = MiniroomService();
  final List<String> categories = ["전체", "일상", "직업", "동물잠옷", "코스프레"];
  int selectedCategoryIndex = 0; // 선택된 카테고리 인덱스

  List<UserClothingModel> myClothingList = [];
  List<UserClothingModel> sortedClothingList = [];

// 옷들 모두 가져오기
  @override
  void initState() {
    super.initState();
    loadClothingData(); // 데이터 로딩
  }

  Future<void> loadClothingData() async {
    String selectedCategory = '';
    try {
      final loadedClothingList =
          await clothingService.getMyAllClothings(selectedCategory);
      if (mounted) {
        setState(() {});
      }
      myClothingList = loadedClothingList;
      sortedClothingList = myClothingList;
    } catch (e) {
      // 에러 처리
      print("Error loading clothing data: $e");
    }
  }

  // 옷 드래그앤드롭하면 바로 입혀볼 옷. 디폴트는 맨몸(b4)
  String b4appliedImg = 'assets/images/minime/default.png';
  String appliedImg = '';
  bool isClothingApplied = false;
  int selectedClothingIndex = 3000000;
  String clothName = '';
  String clothInfo = '';

  // 입는다(적용한다.)
  putOn() async {
    int clothingId = sortedClothingList[selectedClothingIndex].clothingId!;

    final response = await miniroomService.applyCharacter(clothingId);

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            response,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 그냥 탭하면 ~ 팔지말지? 가 나온다.
  int sellingIndex = 3000000;
  wannaSell(int index) {
    setState(() {});
    sellingIndex = index;
  }

  // 팔기
  onSellTap() {
    UserClothingModel cloth = sortedClothingList[sellingIndex];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('<${cloth.clothingName}>'),
          content: const Text(
            '중고로 판매하시겠습니까?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                getSellResponse(cloth.userClothingId!);
              },
              child: const Text('넹'),
            ),
          ],
        );
      },
    );
  }

  // 판매 확인 메세지창
  getSellResponse(int userClothingId) async {
    final response = await clothingService.sellClothing(userClothingId);

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            response,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: _buildDragTarget(),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      //아래 속성들을 조절하여 원하는 값을 얻을 수 있다.
                      begin: Alignment.topCenter,
                      end: Alignment.topRight,
                      colors: [Colors.white, Colors.white.withOpacity(0.08)],
                      stops: const [0.9, 1],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // 수평 스크롤 가능
                      child: Row(
                        children: makeButtons(categories),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      //아래 속성들을 조절하여 원하는 값을 얻을 수 있다.
                      begin: Alignment.center,
                      end: Alignment.topCenter,
                      colors: [Colors.white, Colors.white.withOpacity(0.02)],
                      stops: const [0.9, 1],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: sortedClothingList.isEmpty
                      ? const Center(
                          child: Text('얼른 사줘잉'),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: sortedClothingList.length,
                            itemBuilder: (context, index) {
                              return LongPressDraggable<int>(
                                data: index,
                                // 여기 feedback에 이미지.
                                feedback: Image.network(
                                  sortedClothingList[index].clothingImg!,
                                  width: 200,
                                ),
                                // 빈 네모
                                childWhenDragging: Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(3, 3),
                                        color: Colors.black.withOpacity(0.3),
                                      )
                                    ],
                                  ),
                                ),
                                // 진짜 차일드... 데이터 들어갈 곳
                                child: GestureDetector(
                                  onTap: () => wannaSell(index),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: index == sellingIndex
                                              ? Colors.black.withOpacity(0.2)
                                              : Theme.of(context).cardColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 3,
                                              offset: const Offset(3, 3),
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            )
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.network(
                                              sortedClothingList[index]
                                                  .clothingImg!),
                                        ),
                                      ),
                                      if (index == sellingIndex)
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3), // borderRadius를 3으로 설정합니다.
                                                ),
                                                elevation: 5,
                                              ),
                                              onPressed: onSellTap,
                                              child: const Text(
                                                '판매하기',
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ),
                                            IconButton(
                                              iconSize: 20,
                                              onPressed: () {
                                                setState(() {
                                                  sellingIndex = 3000000;
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.close_rounded),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragTarget() {
    return DragTarget<int>(
      builder: (BuildContext context, List<int?> data, List<dynamic> rejects) {
        return _draggedHere();
      },
      onAccept: (int data) {
        setState(() {});
        //입고있는 걸 또 하면이라는 뜻
        if (data == selectedClothingIndex) {
          isClothingApplied = false;
          // 우리가 만들 수 없는 옷 숫자로 설정
          selectedClothingIndex = 3000000;
          //옷벗기기
        } else {
          selectedClothingIndex = data;
          isClothingApplied = true;
          // 옷 갈아입히기
          clothName = '<${sortedClothingList[data].clothingName}>';
          clothInfo = '${sortedClothingList[data].clothingInfo}';
          appliedImg = '${sortedClothingList[data].clothingApplyImg}';
        }
      },
    );
  }

  Widget _draggedHere() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            isClothingApplied
                ? Image.network(
                    appliedImg,
                    width: 170,
                    height: 250,
                    fit: BoxFit.fitWidth,
                  )
                : Image.asset(
                    b4appliedImg,
                    width: 170,
                  ),
            if (isClothingApplied)
              IconButton(
                // iconSize: 40,
                onPressed: () {
                  setState(() {
                    isClothingApplied = false;
                  });
                },
                icon: const Icon(
                  Icons.close_rounded,
                  fill: 0.2,
                ),
              )
          ],
        ),
        Visibility(
          visible: isClothingApplied,
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    // !!! 옷 이름!!!!!
                    clothName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          //아래 속성들을 조절하여 원하는 값을 얻을 수 있다.
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.02)
                          ],
                          stops: const [0.8, 1],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          child: Text(
                            // !!! 옷 설명!!!!!
                            clothInfo,
                            overflow: TextOverflow
                                .clip, // Overflow 발생 시 글 내용을 자르지 않고 표시
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Material(
                    elevation: 3,
                    color: Theme.of(context).cardColor,
                    shadowColor: Colors.black54,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                        splashColor: Colors.white54,
                        onTap: putOn,
                        borderRadius: BorderRadius.circular(5),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                          child: Text(
                            "너로 정했다!",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> makeButtons(List<String> categories) {
    List<Widget> buttons = [];

    for (int index = 0; index < categories.length; index++) {
      buttons.add(
        Container(
          margin: const EdgeInsets.all(8), // 버튼 간격 조정
          child: AnimatedButton(
            textAlignment: Alignment.center,
            height: 70,
            width: 70,
            text: categories[index],
            isReverse: false,
            isSelected: selectedCategoryIndex == index ? true : false,
            selectedBackgroundColor: Theme.of(context).cardColor,
            selectedTextColor: Colors.black,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            textStyle: const TextStyle(
                color: Colors.black54,
                fontFamily: 'StarDustS',
                fontWeight: FontWeight.w700,
                fontSize: 18),
            backgroundColor: const Color(0xFFFFBEBE).withOpacity(0.2),
            borderColor: Colors.white38,
            borderRadius: 5,
            borderWidth: 2,
            onPress: () {
              setState(() {
                selectedCategoryIndex = index; // 카테고리 선택 시 인덱스 업데이트
                // 인덱스는 초기화 혀
                sellingIndex = 3000000;
                selectedClothingIndex = 3000000;
                if (selectedCategoryIndex == 0) {
                  sortedClothingList = myClothingList;
                } else {
                  sortedClothingList = myClothingList
                      .where((clothing) =>
                          clothing.clothingType ==
                          categories[selectedCategoryIndex])
                      .toList(); // 카테고리 선택 시 인덱스 업데이트
                }
              });
            },
          ),
        ),
      );
    }

    return buttons;
  }
}
