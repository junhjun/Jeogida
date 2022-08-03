import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/utility/menu.dart';
import 'package:parking_spot_frontend/widgets/custom_app_bar.dart';

class ChangePasswordView extends StatelessWidget {
  static const String routeName = "/changepw";

  const ChangePasswordView({Key? key}) : super(key: key);

  final textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "비밀번호 변경"),
      bottomNavigationBar: MyMenu(selectedIndex: 3),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   child: Text("현재 비밀번호 입력", style: textStyle),
            //   padding: EdgeInsets.only(bottom: 5),
            // ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "비밀번호 입력"),
              ),
            ),
            // Container(
            //   child: Text("새 비밀번호 입력", style: textStyle),
            //   padding: EdgeInsets.only(bottom: 5),
            // ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "비밀번호(영문+숫자 6~16자)"),
              ),
            ),
            // Container(
            //   child: Text("새 비밀번호 확인", style: textStyle),
            //   padding: EdgeInsets.only(bottom: 5),
            // ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "비밀번호 재입력"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("비밀번호 변경", style: TextStyle(fontSize: 15)),
                    style: ElevatedButton.styleFrom(primary: Color(0xff75BCC6)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
