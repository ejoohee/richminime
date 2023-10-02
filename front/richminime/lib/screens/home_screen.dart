import 'package:flutter/material.dart';
import 'package:richminime/miniroom/mini_room.dart';
import 'package:richminime/models/bankbook_model.dart';
import 'package:richminime/screens/analysis.dart';
import 'package:richminime/screens/bankbook.dart';
import 'package:richminime/screens/closet.dart';
import 'package:richminime/screens/clothing_store.dart';
import 'package:richminime/screens/interior.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:richminime/screens/interior_store.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.question_mark_rounded),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
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
                  icon: Icon(Icons.explore),
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
                  selectedIcon: Icon(Icons.bookmark),
                  icon: Icon(Icons.bookmark_border),
                  label: '테마',
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
          toggleButtonColor: Colors.pink,
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
              color: Colors.blue,
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
              color: Colors.orange,
              iconSize: 50,
            ),
            CircularMenuItem(
              icon: Icons.person_search_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Analysis()), // 옷장 페이지로 이동
                );
              },
              color: Colors.green,
              iconSize: 50,
            ),
            CircularMenuItem(
              icon: Icons.message_rounded,
              onTap: () {
                // Star 아이콘을 클릭할 때 수행할 작업
              },
              color: Colors.purple,
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
              color: Colors.yellow,
              iconSize: 50,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
