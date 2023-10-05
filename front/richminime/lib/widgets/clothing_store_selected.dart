import 'package:flutter/material.dart';
import 'package:richminime/services/clothig_service.dart';

class ClothingStoreSelected extends StatefulWidget {
  final int clothingId;
  final String clothingImg;
  final String clothingApplyImg;
  final String clothingInfo;
  final String clothingName;
  final int price;
  final Function(String) onImageChange;

  const ClothingStoreSelected(
      {required this.clothingId,
      required this.clothingImg,
      required this.clothingApplyImg,
      required this.clothingInfo,
      required this.clothingName,
      required this.price,
      required this.onImageChange,
      Key? key})
      : super(key: key);

  @override
  State<ClothingStoreSelected> createState() => _ClothingStoreSelectedState();
}

class _ClothingStoreSelectedState extends State<ClothingStoreSelected> {
  final ClothingService clothingService = ClothingService();

  onBuyTap() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${widget.price}코인!'),
          content: const Text(
            '구매하시겠습니까?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                getBuyResponse();
              },
              child: const Text('넹'),
            ),
          ],
        );
      },
    );
  }

  getBuyResponse() async {
    final response = await clothingService.buyClothing(widget.clothingId);

    if (!mounted) return;

    await showDialog(
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   color: Colors.black.withOpacity(0.1),
              //   borderRadius: BorderRadius.circular(10),
              // ),
              child: Center(
                child: Image.network(widget.clothingImg),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '<${widget.clothingName}>',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.price} 코인',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
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
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.clothingInfo,
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
                          onTap: () {
                            widget.onImageChange(widget.clothingApplyImg);
                          },
                          borderRadius: BorderRadius.circular(5),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 7,
                            ),
                            child: Text(
                              "입어보기",
                              style: TextStyle(
                                fontSize: 13,
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
                          onTap: onBuyTap,
                          borderRadius: BorderRadius.circular(5),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 7,
                            ),
                            child: Text(
                              "구매하기",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
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
      ),
    );
  }
}
