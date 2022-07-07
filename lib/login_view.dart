import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/custom_app_bar.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "/LoginView";

  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "로그인"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "로그인",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ), // 로그인 text
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "아이디",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "비밀번호",
                    ),
                  ),
                ),
              ],
            ), // 아이디, 비밀번호 입력
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {},
                    child: Text("로그인"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff75BCC6),
                    ),
                  )),
                ],
              ),
            ), // 로그인 버튼
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("회원가입"),
                  Text("비밀번호 재설정"),
                ],
              ),
            ), // 회원가입, 비밀번호 재설정
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    thickness: 2,
                  )),
                  Text("간편 로그인"),
                  Expanded(
                      child: Divider(
                    thickness: 2,
                  )),
                ],
              ),
            ), // 간편 로그인
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("네이버 아이디로 로그인"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff03C75A),
                    ),
                  ),
                ),
              ],
            ) // 네이버 아이디로 로그인
          ],
        ),
      ),
    );
  }
}
