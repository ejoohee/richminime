import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class Closet extends StatefulWidget {
  const Closet({super.key});

  @override
  State<Closet> createState() => _ClosetState();
}

class _ClosetState extends State<Closet> {
  final List<String> categories = ["전체", "상의", "하의", "드레스", "악세서리", "신발"];
  int selectedCategoryIndex = 0; // 선택된 카테고리 인덱스

  // 옷 클릭하면 바로 입혀볼 옷. 디폴트는 맨몸
  String appliedImg = 'assets/images/minime/default.png';
  bool isClothingApplied = false;
  int selectedClothingIndex = 3000000;
  String clothName = '아야아야';
  String clothInfo = '';

  // 입는다
  putOn() {
    //selectedClothingIndex 써라
  }

  int sellingIndex = 3000000;
  wannaSell(int index) {
    setState(() {});
    sellingIndex = index;
  }

  // 팔기
  sellCloting(int index) {}

  @override
  Widget build(BuildContext context) {
    // applied Img 갈아껴주기 위해 디폴트 값 설정.

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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return LongPressDraggable<int>(
                          data: index,
                          feedback: Text('옷 넣을곳 $index'),
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
                            // child: Center(
                            //   child: Text('옷 넣을곳 $index'),
                            // ),
                          ),
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
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        offset: const Offset(3, 3),
                                        color: Colors.black.withOpacity(0.3),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Text('옷 넣을곳 $index'),
                                  ),
                                ),
                                if (index == sellingIndex)
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: const ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)))),
                                        ),
                                        onPressed: () => sellCloting(index),
                                        child: const Text(
                                          '판매하기',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      IconButton(
                                        iconSize: 20,
                                        onPressed: () {
                                          setState(() {
                                            sellingIndex = 3000000;
                                          });
                                        },
                                        icon: const Icon(Icons.close_rounded),
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
        if (data == selectedClothingIndex) {
          isClothingApplied = false;
          // 우리가 만들 수 없는 옷 숫자로 설정
          selectedClothingIndex = 3000000;
          //옷벗기기
        } else {
          selectedClothingIndex = data;
          isClothingApplied = true;
          // 옷 갈아입히기
          clothName = '<$data번 옷>';
          clothInfo =
              '$data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data $data ';
        }
      },
    );
  }

  Widget _draggedHere() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Image.asset(appliedImg),
            isClothingApplied
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isClothingApplied = false;
                      });
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  )
                : Container(),
          ],
        ),
        isClothingApplied
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        clothName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
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
                                clothInfo,
                                overflow: TextOverflow
                                    .clip, // Overflow 발생 시 글 내용을 자르지 않고 표시
                                style: const TextStyle(
                                  fontSize: 17,
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              child: Text(
                                "너로 정했다",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(
                width: 1,
              ),
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
              });
            },
          ),
        ),
      );
    }

    return buttons;
  }
}
