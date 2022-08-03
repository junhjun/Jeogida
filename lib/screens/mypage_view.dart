import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/utility/menu.dart';
import 'package:parking_spot_frontend/widgets/custom_app_bar.dart';

import 'change_password_view.dart';

class MyPageView extends StatefulWidget {
  static const String routeName = "/MyPageView";

  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final nameTextStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final iconColor = const Color(0xff75BCC6);
  final buttonStyle = TextButton.styleFrom(
    primary: Colors.black,
    padding: const EdgeInsets.all(0.0),
    textStyle: const TextStyle(fontSize: 20),
  );

  String name = "한이음님";
  String email = "hanium@naver.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "마이 페이지"),
      bottomNavigationBar: MyMenu(
        selectedIndex: 3,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(name, style: nameTextStyle),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.email, color: iconColor),
              label: Text(email),
              style: buttonStyle,
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, ChangePasswordView.routeName);
              },
              icon: Icon(Icons.settings, color: iconColor),
              label: const Text("비밀번호 변경"),
              style: buttonStyle,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.logout, color: iconColor),
              label: const Text("로그아웃"),
              style: buttonStyle,
            ),
          ],
        ),
      ),
    );
  }
}
