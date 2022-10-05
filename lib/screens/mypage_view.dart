import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/providers/find_car_provider.dart';
import 'package:parking_spot_frontend/providers/find_space_provider.dart';
import 'package:parking_spot_frontend/providers/location_provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  final nameTextStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, fontFamily: 'GmarketSans');
  final iconColor = const Color(0xff75BCC6);
  final buttonStyle = TextButton.styleFrom(
    primary: Colors.black,
    padding: const EdgeInsets.all(0.0),
    textStyle: const TextStyle(fontSize: 23, fontFamily: 'GmarketSans'),
  );
  final infoTextStyle = const TextStyle(fontSize: 18, fontFamily: 'GmarketSans');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Container(
        margin: const EdgeInsets.fromLTRB(25, 35, 25, 35),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.1,
                    backgroundImage: NetworkImage(
                        context.watch<UserProvider>().user!.photoUrl!),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text(context.watch<UserProvider>().user!.displayName!,
                      style: nameTextStyle),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
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
                          context.read<LocationProvider>().clear();
                          context.read<UserProvider>().logOut();
                          context.read<UserProvider>().clear();
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
        )
      ),
    );
  }
}
