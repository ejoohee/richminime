import 'package:flutter/material.dart';
import 'package:richminime/widgets/clothing_store_selected.dart';

class ClothingStore extends StatefulWidget {
  const ClothingStore({super.key});

  @override
  State<ClothingStore> createState() => _ClothingStoreState();
}

class _ClothingStoreState extends State<ClothingStore> {
  final List<String> categories = ["전체", "상의", "하의", "드레스", "악세서리", "신발"];
  bool isSelected = false;

  onSelect() {
    setState(() {
      isSelected = true;
    });
  }

  toTheList() {
    setState(() {
      isSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "앱빠",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      '여기 미니미',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: isSelected
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: toTheList,
                            icon: const Icon(Icons.navigate_before_rounded),
                          ),
                        ],
                      )
                    : ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            //아래 속성들을 조절하여 원하는 값을 얻을 수 있다.
                            begin: Alignment.topCenter,
                            end: Alignment.topRight,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.02)
                            ],
                            stops: const [0.9, 1],
                            tileMode: TileMode.mirror,
                          ).createShader(bounds);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
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
                child: isSelected
                    ? const ClothingStoreSelected()
                    : ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            //아래 속성들을 조절하여 원하는 값을 얻을 수 있다.
                            begin: Alignment.center,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.02)
                            ],
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
                              crossAxisCount: 4,
                            ),
                            itemCount: 30,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text('옷 사진들 $index'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> makeButtons(List<String> categories) {
    List<Widget> buttons = [];

    for (String category in categories) {
      buttons.add(
        Container(
          margin: const EdgeInsets.all(8), // 버튼 간격 조정
          child: ElevatedButton(
            onPressed: () {
              // 버튼을 눌렀을 때 실행될 코드
            },
            child: Text(category), // 각 버튼에 카테고리 텍스트 표시
          ),
        ),
      );
    }

    return buttons;
  }
}
