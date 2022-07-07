import 'package:flutter/material.dart';

class MyMenu extends StatefulWidget {
  MyMenu({Key? key, required this.selectedIndex}) : super(key: key);
  int selectedIndex;

  @override
  State<MyMenu> createState() => _MyMenuState(selectedIndex);
}

class _MyMenuState extends State<MyMenu> {
  _MyMenuState(this._selectedIndex);

  int _selectedIndex;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 2) {
        Navigator.pushReplacementNamed(context, "/BookMarkView");
      }
      if (_selectedIndex == 3) {
        Navigator.pushReplacementNamed(context, "/MyPageView");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: const Color(0xff75BCC6),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: "내 차 찾기",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "주차공간 찾기",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star_border),
          label: "즐겨찾기",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "마이페이지",
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
