import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

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
            child: const Text(
              '여그 옷 사진',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              const Text(
                "제목",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "가격",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  )
                ],
              ),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      //아래 속성들을 조절하여 원하는 값을 얻을 수 있다.
                      begin: Alignment.center,
                      end: Alignment.topCenter,
                      colors: [Colors.white, Colors.white.withOpacity(0.02)],
                      stops: const [0.8, 1],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "제가 오늘 점심으로 김치찌개를 먹고 저녁은 호박된장국을 먹어서 부었습니다. 제가 오늘 점심으로 김치찌개를 먹고 저녁은 호박된장국을 먹어서 부었습니다.제가 오늘 점심으로 김치찌개를 먹고 저녁은 호박된장국을 먹어서 부었습니다. 제가 오늘 점심으로 김치찌개를 먹고 저녁은 호박된장국을 먹어서 부었습니다",
                        overflow:
                            TextOverflow.clip, // Overflow 발생 시 글 내용을 자르지 않고 표시
                        style: TextStyle(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    elevation: 5,
                    color: Theme.of(context).cardColor,
                    shadowColor: Colors.black54,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                        splashColor: Colors.white54,
                        onTap: () {},
                        borderRadius: BorderRadius.circular(5),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                          child: Text(
                            "입어보기",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ),
                  Material(
                    elevation: 5,
                    color: Theme.of(context).cardColor,
                    shadowColor: Colors.black54,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                        splashColor: Colors.white54,
                        onTap: () {},
                        borderRadius: BorderRadius.circular(5),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                          child: Text(
                            "구매하기",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
