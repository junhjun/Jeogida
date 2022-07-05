import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.appBar,
    required this.title,
  }) : super(key: key);

  final AppBar appBar;
  final String title;
  final TextStyle titleStyle = const TextStyle(color: Colors.black);
  final appBarBorder =
      const Border(bottom: BorderSide(color: Color(0xffF3F3F3), width: 10));

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: titleStyle),
        backgroundColor: Colors.white,
        shape: appBarBorder);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
