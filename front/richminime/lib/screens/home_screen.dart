import 'package:flutter/material.dart';
import 'package:richminime/icons/my_flutter_app_icons.dart';
import 'package:richminime/miniroom/mini_room.dart';
import 'package:richminime/screens/analysis.dart';
import 'package:richminime/screens/bankbook.dart';
import 'package:richminime/screens/closet.dart';
import 'package:richminime/screens/clothing_store.dart';
import 'package:richminime/screens/gpt.dart';
import 'package:richminime/screens/interior.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:richminime/screens/interior_store.dart';
import 'package:richminime/widgets/appbar_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 1;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.onlyShowSelected;

  final List<Widget> _widgetOptions = <Widget>[
    const Closet(),
    const MiniRoom(),
    const Interior(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHomeScreen(
        currentPageIndex: currentPageIndex,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: _widgetOptions.elementAt(currentPageIndex),
            ),
            // NavigationBar
            NavigationBar(
              backgroundColor: Colors.transparent,
              indicatorColor: Theme.of(context).cardColor,
              animationDuration: const Duration(milliseconds: 500),
              labelBehavior: labelBehavior,
              selectedIndex: currentPageIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              destinations: <Widget>[
                const NavigationDestination(
                  icon: Icon(Icons.checkroom),
                  label: '옷장',
                ),
                currentPageIndex != 1
                    ? const NavigationDestination(
                        icon: Icon(Icons.home),
                        label: '홈',
                      )
                    : const NavigationDestination(
                        icon: Icon(
                          Icons.circle,
                          color: Colors.transparent,
                        ),
                        label: '',
                      ),
                const NavigationDestination(
                  selectedIcon: Icon(Icons.chair),
                  icon: Icon(Icons.chair_outlined),
                  label: '가구 보관함',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: currentPageIndex == 1, // currentPageIndex가 1일 때 노출
        child: CircularMenu(
          curve: Curves.elasticInOut,
          reverseCurve: Curves.elasticInOut,
          animationDuration: const Duration(milliseconds: 1000),
          radius: 125,
          alignment: Alignment.bottomCenter,
          toggleButtonSize: 60,
          toggleButtonColor: const Color(0xFF6d9d88),
          items: [
            CircularMenuItem(
              icon: Icons.face_retouching_natural_sharp,
              onTap: () {
                // Home 아이콘을 클릭할 때 수행할 작업
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ClothingStore()), // 옷장 페이지로 이동
                );
              },
              color: const Color(0xFFA6BB8D),
              iconSize: 50,
            ),
            CircularMenuItem(
              icon: Icons.monetization_on,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BankBook()), // 옷장 페이지로 이동
                );
              },
              color: const Color(0xFF61876E),
              iconSize: 50,
            ),
            CircularMenuItem(
              icon: Icons.pie_chart,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Analysis()), // 옷장 페이지로 이동
                );
              },
              color: const Color(0xFF3C6255),
              iconSize: 50,
            ),
            CircularMenuItem(
              icon: MyFlutterApp.gpt,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Gpt()), // 옷장 페이지로 이동
                );
              },
              color: const Color(0xFF61876E),
              iconSize: 50,
            ),
            CircularMenuItem(
              icon: Icons.construction_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const InteriorStore()), // 옷장 페이지로 이동
                );
              },
              color: const Color(0xFFA6BB8D),
              iconSize: 50,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
