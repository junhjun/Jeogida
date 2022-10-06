import 'package:flutter/material.dart';
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
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15, fontFamily: 'GmarketSans');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Image(
                image: AssetImage("assets/logo.png"),
              )),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: const Text("저기다",
                    style: TextStyle(
                        color: Color(0xFF23CCD3),
                        fontWeight: FontWeight.bold,
                        fontSize: 55,
                        fontFamily: 'GmarketSans')),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.055,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<UserProvider>().logIn();
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
        ),
      ),
    );
  }
}
