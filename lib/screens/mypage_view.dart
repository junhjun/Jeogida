import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/providers/find_car_provider.dart';
import 'package:parking_spot_frontend/providers/find_space_provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MyPageView extends StatefulWidget {
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
    textStyle: const TextStyle(fontSize: 25),
  );
  final infoTextStyle = const TextStyle(fontSize: 20);
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  Widget build(BuildContext context) {
    // logger.i(context.watch<UserProvider>().user);
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      // padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.1,
                backgroundImage:
                    NetworkImage(context.watch<UserProvider>().user!.photoUrl!),
              ),
            ),
            // const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(context.watch<UserProvider>().user!.displayName!,
                    style: nameTextStyle),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(35, 10, 20, 0),
              // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.email, color: iconColor),
                      Text(" ${context.watch<UserProvider>().user!.email!}",
                          style: infoTextStyle)
                    ],
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          context.read<FindSpaceProvider>().clear();
                          context.read<FindCarProvider>().clear();
                          context.read<UserProvider>().handleLogOut();
                          context.read<UserProvider>().clear();
                          logger.i("Logout API Called");
                        },
                        icon: Icon(Icons.logout, color: iconColor),
                        label: Text("로그아웃", style: infoTextStyle),
                        style: buttonStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
