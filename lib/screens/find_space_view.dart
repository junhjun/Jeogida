import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/providers/find_space_provider.dart';
import 'package:parking_spot_frontend/screens/webview_zoom_view.dart';
import 'package:parking_spot_frontend/widgets/bookmark_space_dropdown.dart';
import 'package:parking_spot_frontend/widgets/space_info_widget.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../providers/user_provider.dart';
import '../widgets/web_view_widget.dart';

class FindSpace extends StatefulWidget {
  const FindSpace({Key? key}) : super(key: key);

  @override
  State<FindSpace> createState() => _MyAppState();
}

class _MyAppState extends State<FindSpace> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));
  final controller = Completer<WebViewController>(); // WebView Controller
  final _infoTextStyle = const TextStyle(fontSize: 11, color: Colors.black, fontFamily: 'GmarketSans');

  @override
  void initState() {
    super.initState();
    context
        .read<FindSpaceProvider>()
        .setBookMarkSpaceList(context.read<UserProvider>().user!.id);
  }

  @override
  Widget build(BuildContext context) {
    var selectedIdx = context.watch<FindSpaceProvider>().selectedIdx;
    var spaceInfo = context.watch<FindSpaceProvider>().spaceInfo;
    var map = (selectedIdx != null && spaceInfo != null)
        ? spaceInfo.spaces[selectedIdx].mapId
        : null;

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Container(
        margin: const EdgeInsets.fromLTRB(25, 35, 25, 35),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.fromLTRB(23, 30, 23, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DropDownButton
            const BookMarkSpaceWidget(),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.175,
                child: const SpaceInfoWidget()),
            // Divider
            Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                child: const Divider(thickness: 0.3, color: Colors.grey)),
            // Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(children: [
                  const Icon(Icons.square, size: 9, color: Color(0xffe3e3e3)),
                  Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 13, 0),
                      child: Text('주차 가능', style: _infoTextStyle)),
                  const Icon(Icons.square,
                      size: 9, color: Color(0xffa2a1a1)), // 주차 위치 아이콘
                  Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 13, 0),
                      child: Text('장애인 구역', style: _infoTextStyle)),
                  const Icon(Icons.square,
                      size: 9, color: Color(0xffee162e)), // 주차 위치 아이콘
                  Container(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('주차 불가', style: _infoTextStyle)),
                  WebViewControls(
                      controller: controller, mapId: map, key: UniqueKey()),
                ]),
              ],
            ),
            // WebView
            Flexible(
                fit: FlexFit.tight,
                child: WebViewStack(controller: controller)),
            // Zoom text button
            Center(
                child: TextButton(
                  style: TextButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewZoomView(mapId: map)));
                    },
                  child: const Text("여기를 클릭하면 확대해서 볼 수 있습니다.",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w200,
                          fontFamily: 'GmarketSans'
                      )
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
