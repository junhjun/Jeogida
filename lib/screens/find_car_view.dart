import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/models/book_mark_car.dart';
import 'package:parking_spot_frontend/screens/webview_zoom_view.dart';
import 'package:parking_spot_frontend/widgets/car_info_widget.dart';
import 'package:parking_spot_frontend/widgets/web_view_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../main.dart';
import '../widgets/book_mark_car_dropdown.dart';

BookMarkCar? selectedCar = null;

class FindCar extends StatefulWidget {
  const FindCar({Key? key}) : super(key: key);

  @override
  State<FindCar> createState() => _MyAppState();
}

class _MyAppState extends State<FindCar> {
  final controller = Completer<WebViewController>(); // WebViewController
  final _infoTextStyle = const TextStyle(fontSize: 15, color: Colors.grey);
  final _currentAreaTextStyle = const TextStyle(
      fontSize: 20, color: Colors.cyan, fontWeight: FontWeight.bold);

  Widget _chooseWidget() {
    if (selectedCar != null) {
      return const CarInfoWidget();
    } else {
      return Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text("차량을 선택하세요", style: _currentAreaTextStyle), // 주차 구역
                padding: const EdgeInsets.only(bottom: 10),
              ),
              Text("위치 : ", style: _infoTextStyle), // 주차장 위치
              Text("주차시간 : ", style: _infoTextStyle) // 주차 시간
            ],
          ));
    }
  }

  void update(BookMarkCar value) {
    setState(() {
      selectedCar = value;
      logger.i("selectedCar : ${selectedCar!.number}");
    });
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
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(4, 8))
            ],
            borderRadius: const BorderRadius.all(Radius.circular(8.0))),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DropDownButton
            Container(child: BookMarkCarWidget(update: update)),
            // 주차장 관련 정보
            _chooseWidget(),
            // Divider
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: const Divider(height: 10, color: Colors.grey),
            ),
            // Icons
            Container(
                child: Row(
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
                          child: Text('현재 위치', style: _infoTextStyle),
                          padding: const EdgeInsets.only(left: 5)),
                      const SizedBox(width: 10),
                      const Icon(Icons.rectangle,
                          size: 12,
                          color: Colors.deepOrangeAccent), // 주차 위치 아이콘
                      Container(
                          child: Text('주차 위치', style: _infoTextStyle),
                          padding: const EdgeInsets.only(left: 5)),
                      Container(child: WebViewControls(controller: controller)),
                    ],
                  ),
                ),
              ],
            )),
            // WebView
            Flexible(
              fit: FlexFit.tight,
              child: WebViewStack(controller: controller),
            ),
            // Zoom info text
            Center(
              child: TextButton(
                style: TextButton.styleFrom(primary: Colors.grey),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebViewZoomView()),
                  );
                },
                child: const Text("여기를 클릭하면 확대해서 볼 수 있습니다."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
