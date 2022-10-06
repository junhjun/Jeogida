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
        icon: SizedBox(
          height: 40,
            child: Icon(Icons.drive_eta, size: 35)), label: "내 차 찾기"),
    BottomNavigationBarItem(
        icon: SizedBox(
          height: 40,
            child: Icon(Icons.local_parking_outlined, size: 35)), label: "주차공간 찾기"),
    BottomNavigationBarItem(
        icon: SizedBox(
          height: 40,
            child: Icon(Icons.star_border_rounded, size: 35)), label: "즐겨찾기"),
    BottomNavigationBarItem(
        icon: SizedBox(
          height: 40,
            child: Icon(Icons.person_outline_rounded, size: 35)), label: "마이페이지"),
  ];

  final bodyList = [
    const FindCar(),
    const FindSpace(),
    const BookMarkView(),
    const MyPageView()
  ]; // Page Lists

  final titles = ["내 차 찾기", "주차공간 찾기", "즐겨찾기", "마이페이지"]; // AppBar titles

  late PreferredSizeWidget? customAppBar;
  late int currentIndex;

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
        unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'GmarketSans'),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12, fontFamily: 'GmarketSans'),
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
