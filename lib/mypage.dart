import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/customAppBar.dart';
import 'package:parking_spot_frontend/menu.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final TextStyle infoTextStyle = TextStyle(fontSize: 20);
  final TextStyle nameTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Page",
      home: Scaffold(
        appBar: CustomAppBar(appBar: AppBar(), title: "마이 페이지"),
        bottomNavigationBar: MyMenu(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text("한이음님", style: nameTextStyle),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Color(0xff75BCC6),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "hanium@naver.com",
                    style: infoTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    color: Color(0xff75BCC6),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "비밀번호 변경",
                    style: infoTextStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: Color(0xff75BCC6),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "로그아웃",
                    style: infoTextStyle,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
