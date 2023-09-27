import 'dart:ffi';

import 'package:flutter/material.dart';

class MiniRoom extends StatefulWidget {
  const MiniRoom({super.key});

  @override
  State<MiniRoom> createState() => _MiniRoomState();
}

class _MiniRoomState extends State<MiniRoom> {
  double posX = 150;
  double posY = 300;
  bool isMinimeTapped = false;
  showFeedback() {
    setState(() {
      isMinimeTapped = !isMinimeTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/miniroom/default.png"),
            ),
          ),
          width: double.infinity, //가로 꽉 차게 설정
          height: double.infinity,
        ),
        Positioned(
          left: posX,
          top: posY,
          child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/minime/default.png"),
              )),
              child: GestureDetector(
                onDoubleTap: showFeedback,
                onScaleUpdate: (details) {
                  setState(() {
                    posX += details.focalPointDelta.dx;
                    posY += details.focalPointDelta.dy;
                  });
                },
              )),
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
          ],
        ),
      ],
    );
  }
}
