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
  final _infoTextStyle = const TextStyle(fontSize: 15, color: Colors.grey);
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 5.0, offset: Offset(4, 8))
            ],
            borderRadius: const BorderRadius.all(Radius.circular(8.0))),
        padding: const EdgeInsets.all(20),
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
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      const Icon(Icons.circle,
                          size: 12,
                          color: Colors.deepOrangeAccent), // 현재 위치 아이콘
                      Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text('현재 위치', style: _infoTextStyle)),
                      const SizedBox(width: 10),
                      const Icon(Icons.rectangle,
                          size: 12,
                          color: Colors.deepOrangeAccent), // 주차 위치 아이콘
                      Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text('주차 위치', style: _infoTextStyle)),
                      WebViewControls(controller: controller),
                    ],
                  ),
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
                int? map = context.read<FindCarProvider>().carInfo?.mapId;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewZoomView(mapId: map)));
              },
              child: const Text("여기를 클릭하면 확대해서 볼 수 있습니다."),
            )),
            // 주차 시간
          ],
        ),
      ),
    );
  }
}
