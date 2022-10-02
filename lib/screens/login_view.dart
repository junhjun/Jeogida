import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
    const textStyle = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15);

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
              const Text("저기다",
                  style: TextStyle(
                      color: Color(0xFF23CCD3),
                      fontWeight: FontWeight.bold,
                      fontSize: 50)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
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
