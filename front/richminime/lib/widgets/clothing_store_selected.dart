import 'package:flutter/material.dart';

class ClothingStoreSelected extends StatefulWidget {
  const ClothingStoreSelected({super.key});

  @override
  State<ClothingStoreSelected> createState() => _ClothingStoreSelectedState();
}

class _ClothingStoreSelectedState extends State<ClothingStoreSelected> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              '여그 옷 사진',
              style: TextStyle(
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              const Text("제목"),
              const Text("가격"),
              const Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명",
                    overflow:
                        TextOverflow.clip, // Overflow 발생 시 글 내용을 자르지 않고 표시
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8), // 버튼 간격 조정
                    child: ElevatedButton(
                      onPressed: () {
                        // 입어보기
                      },
                      child: const Text("입"), // 각 버튼에 카테고리 텍스트 표시
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8), // 버튼 간격 조정
                    child: ElevatedButton(
                      onPressed: () {
                        // 구매하기
                      },
                      child: const Text("구"), // 각 버튼에 카테고리 텍스트 표시
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
