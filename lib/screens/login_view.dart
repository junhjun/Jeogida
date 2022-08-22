import 'package:flutter/material.dart';

import '../main.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle = ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
    final textStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);

    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image(image: AssetImage("assets/logo.png"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print("Login API Called");
                      handleLogIn();
                    },
                    icon: Image(
                        image: AssetImage("assets/google.png"),
                        width: 20,
                        height: 20),
                    label: Text("구글로 계속하기", style: textStyle),
                    style: ButtonStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
