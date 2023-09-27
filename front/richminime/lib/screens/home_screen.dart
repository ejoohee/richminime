import 'package:flutter/material.dart';
import 'package:richminime/miniroom/mini_room_widget.dart';
import 'package:richminime/screens/closet.dart';
import 'package:richminime/screens/interior.dart';
import 'package:circular_menu/circular_menu.dart';

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
    const MiniRoomWidget(),
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
          alignment: Alignment.bottomCenter,
          toggleButtonSize: 48,
          toggleButtonColor: Colors.pink,
          items: [
            CircularMenuItem(
              icon: Icons.home,
              onTap: () {
                // Home 아이콘을 클릭할 때 수행할 작업
              },
              color: Colors.blue,
            ),
            CircularMenuItem(
              icon: Icons.search,
              onTap: () {
                // Search 아이콘을 클릭할 때 수행할 작업
              },
              color: Colors.orange,
            ),
            CircularMenuItem(
              icon: Icons.settings,
              onTap: () {
                // Settings 아이콘을 클릭할 때 수행할 작업
              },
              color: Colors.deepPurple,
            ),
            CircularMenuItem(
              icon: Icons.star,
              onTap: () {
                // Star 아이콘을 클릭할 때 수행할 작업
              },
              color: Colors.yellow,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
