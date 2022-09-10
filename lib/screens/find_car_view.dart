import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/providers/find_car_provider.dart';
import 'package:parking_spot_frontend/screens/webview_zoom_view.dart';
import 'package:parking_spot_frontend/widgets/car_info_widget.dart';
import 'package:parking_spot_frontend/widgets/web_view_widget.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/book_mark_car_dropdown.dart';

class FindCar extends StatefulWidget {
  const FindCar({Key? key}) : super(key: key);

  @override
  State<FindCar> createState() => _MyAppState();
}

class _MyAppState extends State<FindCar> {
  final controller = Completer<WebViewController>(); // WebViewController
  final _infoTextStyle = const TextStyle(fontSize: 14, color: Colors.black);
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mapId = context.watch<FindCarProvider>().carInfo?.mapId;
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
            const BookMarkCarWidget(),
            // Car Info Text Widget
            const CarInfoWidget(),
            // Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(Icons.circle,
                        size: 8, color: Colors.cyan), // 현재 위치 아이콘
                    Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                        child: Text('현재 위치', style: _infoTextStyle)),
                    const Icon(Icons.square,
                        size: 10, color: Colors.cyan), // 주차 위치 아이콘
                    Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                        child: Text('주차 위치', style: _infoTextStyle)),
                    WebViewControls(
                        controller: controller, mapId: mapId, key: UniqueKey()),
                  ],
                ),
              ],
            ),
            // WebView
            Flexible(
                fit: FlexFit.tight,
                child: WebViewStack(controller: controller)),
            // Zoom info text
            Center(
                child: TextButton(
              style: TextButton.styleFrom(primary: Colors.grey),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewZoomView(mapId: mapId)));
              },
              child: const Text("여기를 클릭하면 확대해서 볼 수 있습니다."),
            )),
          ],
        ),
      ),
    );
  }
}
