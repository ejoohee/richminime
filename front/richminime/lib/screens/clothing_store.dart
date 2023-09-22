import 'package:flutter/material.dart';
import 'package:richminime/screens/clothing_store_selected.dart';

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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Row(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 100, horizontal: 150),
                    child: Text(
                      '여기 미니미',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ),
              isSelected
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: toTheList,
                          icon: const Icon(Icons.navigate_before_rounded),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // 수평 스크롤 가능
                        child: Row(
                          children: makeButtons(categories),
                        ),
                      ),
                    ),
              Expanded(
                child: isSelected
                    ? const ClothingStoreSelected()
                    : GridView.count(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 4,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(100, (index) {
                          return GestureDetector(
                            onTap: onSelect,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '옷 사진들 $index',
                              ),
                            ),
                          );
                        }),
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
