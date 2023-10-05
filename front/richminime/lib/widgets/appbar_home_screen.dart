import 'package:flutter/material.dart';
import 'package:richminime/screens/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/services/user_service.dart';
import 'package:marquee/marquee.dart';

class AppBarHomeScreen extends StatelessWidget implements PreferredSizeWidget {
  final int? currentPageIndex;
  const AppBarHomeScreen({required this.currentPageIndex, Key? key})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  onlogoutTap(BuildContext context) async {
    final userService = UserService();
    final response = await userService.logout();
    if (response) {
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    final userService = UserService();
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SafeArea(
            child: Container(
              padding:
                  const EdgeInsets.only(left: 60), // IconButton의 크기와 비슷한 값으로 설정
              alignment: Alignment.center,
              child: FutureBuilder<String?>(
                future: storage.read(key: "nickname"),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("로딩 중...");
                  } else if (snapshot.hasError) {
                    return const Text("에러 발생");
                  } else {
                    if (currentPageIndex == 1) {
                      return Container(
                        margin: const EdgeInsets.only(right: 50),
                        child: Marquee(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          text: '${snapshot.data}님의 미니룸',
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color(0xFF1a1a1a),
                            fontWeight: FontWeight.bold,
                          ),
                          scrollAxis: Axis.horizontal,
                          blankSpace: 50,
                          velocity: 30,
                          pauseAfterRound: const Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          decelerationDuration:
                              const Duration(milliseconds: 500),
                        ),
                      );
                    } else if (currentPageIndex == 0) {
                      return Container(
                        margin: const EdgeInsets.only(right: 50),
                        child: Marquee(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          text: '${snapshot.data}님의 옷장',
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color(0xFF1a1a1a),
                            fontWeight: FontWeight.bold,
                          ),
                          scrollAxis: Axis.horizontal,
                          blankSpace: 50,
                          velocity: 30,
                          pauseAfterRound: const Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          decelerationDuration:
                              const Duration(milliseconds: 500),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(right: 50),
                        child: Marquee(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          text: '${snapshot.data}님의 가구 보관함',
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color(0xFF1a1a1a),
                            fontWeight: FontWeight.bold,
                          ),
                          scrollAxis: Axis.horizontal,
                          blankSpace: 50,
                          velocity: 30,
                          pauseAfterRound: const Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          decelerationDuration:
                              const Duration(milliseconds: 500),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            onlogoutTap(context);
          },
          icon: const Icon(Icons.logout_outlined),
          color: Colors.black,
        ),
      ],
    );
  }
}
