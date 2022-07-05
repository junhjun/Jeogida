import 'package:flutter/material.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({Key? key}) : super(key: key);

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey,
      selectedItemColor: const Color(0xff75BCC6),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
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
