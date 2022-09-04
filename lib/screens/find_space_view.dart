import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/models/book_mark_space.dart';
import 'package:parking_spot_frontend/screens/webview_zoom_view.dart';
import 'package:parking_spot_frontend/widgets/book_mark_space_dropdown.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../main.dart';
import '../widgets/web_view_widget.dart';

late BookMarkSpace? selectedSpace;

class FindSpace extends StatefulWidget {
  @override
  State<FindSpace> createState() => _MyAppState();
}

class _MyAppState extends State<FindSpace> {
  final controller = Completer<WebViewController>(); // WebView Controller

  final _valueList = ['개봉현대아파트', '스타필드코엑스몰', '아파트2', '아파트3'];
  var _selectedValue = '개봉현대아파트';


  final _infoTextStyle = TextStyle(color: Colors.grey, fontSize: 13);
  final _disabledButtonStyle = ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      primary: Colors.grey[300],
      onSurface: Colors.black);
  final _disabledTextStyle = TextStyle(
      color: Colors.grey[600], fontSize: 15, fontWeight: FontWeight.bold);
  final _activeButtonStyle = ElevatedButton.styleFrom(
      shape: const CircleBorder(), primary: Colors.cyan);
  final _activeTextStyle =
      TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold);
  List<bool> selected = List.generate(3, (index) => false);
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      backgroundColor: Color(0xffededed),
      body: Container(
        margin: const EdgeInsets.fromLTRB(25, 35, 25, 35),
        decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.fromLTRB(23, 30, 23, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DropDownButton
            const BookMarkSpaceWidget(),

            // Parking lot Elevated Button
            Container(
              padding: EdgeInsets.only(bottom: 15),
              child: ToggleButtons(
                borderColor: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {},
                      style: _disabledButtonStyle,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Text("B1", style: _disabledTextStyle),
                            Text("14석", style: _disabledTextStyle)
                          ],
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      style: _disabledButtonStyle,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Text("B2", style: _disabledTextStyle),
                            Text("30석", style: _disabledTextStyle)
                          ],
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      style: _disabledButtonStyle,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: <Widget>[
                            Text("B3", style: _disabledTextStyle),
                            Text("50석", style: _disabledTextStyle)
                          ],
                        ),
                      )),
                ],
                onPressed: (int index) {
                  setState(() {
                    selected[index] = !selected[index];
                    if (index == 0 && selected[index]) {}
                  });
                },
                isSelected: selected,
              ),
            ), // TODO - OnPressed Method


            // Divider
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: const Divider(thickness: 0.3, color: Colors.grey)),



            // Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    children: [
                      const Icon(Icons.square,
                          size: 9,
                          color: Color(0xffe3e3e3)),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 13, 0),
                        child: Text('주차 가능', style: _infoTextStyle)),
                      const Icon(Icons.square,
                          size: 9,
                          color: Color(0xffafaeae)), // 주차 위치 아이콘
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 13, 0),
                        child: Text('장애인 구역', style: _infoTextStyle)),
                      const Icon(Icons.square,
                          size: 9,
                          color: Color(0xffee162e)), // 주차 위치 아이콘
                      Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                          child: Text('주차 불가', style: _infoTextStyle)),
                      WebViewControls(controller: controller),
                    ]
                  ),
                ),
              ],
            ),
            // WebView
            Flexible(
                fit: FlexFit.tight,
                child: WebViewStack(controller: controller)),
            // Zoom
            Center(
              child: TextButton(
                style: TextButton.styleFrom(primary: Colors.grey),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewZoomView(
                              mapId: 5,
                            )),
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
