import 'package:flutter/material.dart';
import 'package:richminime/screens/login.dart';
import 'package:richminime/services/clothig_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:richminime/services/user_service.dart';

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
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: FutureBuilder<String?>(
        future: storage.read(key: "nickname"),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("로딩 중...");
          } else if (snapshot.hasError) {
            return const Text("에러 발생");
          } else {
            return Text(
              '환영합니다. ${snapshot.data}님',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        },
      ),
      centerTitle: true,
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
