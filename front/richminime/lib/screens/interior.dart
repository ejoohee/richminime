import 'package:flutter/material.dart';

class Interior extends StatefulWidget {
  const Interior({super.key});

  @override
  State<Interior> createState() => _InteriorState();
}

class _InteriorState extends State<Interior> {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                            child: Text(
                          '전',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                            child: Text(
                          '후',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),

              // 테마+아이템이 들어갈 시 주어질 버튼
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal, // 수평 스크롤 가능
              //     child: Row(
              //       children: makeButtons(categories),
              //     ),
              //   ),
              // ),
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      //아래 속성들을 조절하여 원하는 값을 얻을 수 있다.
                      begin: Alignment.topCenter,
                      end: Alignment.topRight,
                      colors: [Colors.white, Colors.white.withOpacity(0.02)],
                      stops: const [0.8, 1],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.all(3),
                            //임시값
                            width: 150,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  offset: const Offset(10, 3),
                                  color: Colors.black.withOpacity(0.3),
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Themes $index',
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 15),
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

  // 테마+아이템이 들어갈 시 주어질 버튼
  // List<Widget> makeButtons(List<String> categories) {
  //   List<Widget> buttons = [];

  //   for (String category in categories) {
  //     buttons.add(
  //       Container(
  //         margin: const EdgeInsets.all(8), // 버튼 간격 조정
  //         child: ElevatedButton(
  //           onPressed: () {
  //             // 버튼을 눌렀을 때 실행될 코드
  //           },
  //           child: Text(category), // 각 버튼에 카테고리 텍스트 표시
  //         ),
  //       ),
  //     );
  //   }

  //   return buttons;
  // }
}
