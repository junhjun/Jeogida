import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/screens/bookmark_view.dart';
import 'package:parking_spot_frontend/screens/find_car_view.dart';
import 'package:parking_spot_frontend/screens/find_space_view.dart';
import 'package:parking_spot_frontend/screens/mypage_view.dart';
import 'package:parking_spot_frontend/widgets/custom_app_bar_widget.dart';

import 'utility/register_web_webview_stub.dart'
    if (dart.library.html) 'utility/register_web_webview.dart';

void main() {
  registerWebViewWebImplementation();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final items = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.explore), label: "내 차 찾기"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "주차공간 찾기"),
    BottomNavigationBarItem(icon: Icon(Icons.star_border), label: "즐겨찾기"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이페이지")
  ];
  final bodyList = [
    FindCar(),
    FindSpace(),
    BookMarkView(),
    MyPageView()
  ]; // Page Lists
  final titles = ["내 차 찾기", "주차공간 찾기", "즐겨찾기", "마이페이지"]; // AppBar titles
  var currentIndex;
  var customAppBar;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
      if (index == 2)
        customAppBar = null;
      else
        customAppBar = CustomAppBar(title: titles[currentIndex]);
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
    return MaterialApp(
      home: Scaffold(
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
        body: IndexedStack(
          index: currentIndex,
          children: bodyList,
        ),
      ),
    );
  }
}
