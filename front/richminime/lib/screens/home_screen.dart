import 'package:flutter/material.dart';
import 'package:richminime/miniroom/mini_room.dart';
import 'package:richminime/miniroom/mini_room_widget.dart';
import 'package:richminime/screens/closet.dart';
import 'package:richminime/screens/interior.dart';

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
        // title: const Text('Home Screen'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.question_mark_rounded),
              onPressed: () {
                // 가진 코인 숫자 보여주기
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: _widgetOptions.elementAt(currentPageIndex),
      bottomNavigationBar: NavigationBar(
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
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: '옷장',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: '호옴',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: '테마',
          ),
        ],
      ),
    );
  }
}
