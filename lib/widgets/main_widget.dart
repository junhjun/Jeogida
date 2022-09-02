import 'package:flutter/material.dart';

import '../screens/bookmark_view.dart';
import '../screens/find_car_view.dart';
import '../screens/find_space_view.dart';
import '../screens/mypage_view.dart';
import 'custom_app_bar_widget.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final items = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.explore_outlined), label: "내 차 찾기"),
    BottomNavigationBarItem(
        icon: Icon(Icons.search_outlined), label: "주차공간 찾기"),
    BottomNavigationBarItem(
        icon: Icon(Icons.star_outline_rounded), label: "즐겨찾기"),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_rounded), label: "마이페이지")
  ];

  final bodyList = [
    const FindCar(),
    FindSpace(),
    const BookMarkView(),
    const MyPageView()
  ]; // Page Lists

  final titles = ["내 차 찾기", "주차공간 찾기", "즐겨찾기", "마이페이지"]; // AppBar titles

  var currentIndex;
  var customAppBar;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
      if (index == 2) {
        customAppBar = null;
      } else {
        customAppBar = CustomAppBar(title: titles[currentIndex]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    customAppBar = CustomAppBar(title: titles[currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.cyan,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: bodyList,
        ),
      ),
    );
  }
}
