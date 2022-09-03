import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
    const textStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);
    var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Image(image: AssetImage("assets/logo.png"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      logger.i("Login API Called");
                      context.read<UserProvider>().handleLogIn();
                    },
                    icon: const Image(
                        image: AssetImage("assets/google.png"),
                        width: 20,
                        height: 20),
                    label: const Text("구글로 계속하기", style: textStyle),
                    style: buttonStyle,
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
