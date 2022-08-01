import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/custom_app_bar.dart';
import 'package:parking_spot_frontend/menu.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FindCar extends StatefulWidget {
  static const String routeName = "/FindCar";
  @override
  State<FindCar> createState() => _MyAppState();
}

class _MyAppState extends State<FindCar> {
  late WebViewController _controller;

  final _valueList = ['20누 0856', '11가 1234', '22나 2345', '33다 3456'];
  var _selectedValue = '20누 0856';
  final _dropdownTextStyle = TextStyle(fontSize: 13, color: Colors.black);
  final _dropdownIcon = Icon(Icons.arrow_drop_down, size: 30);
  var _currentArea = "B1층 A구역 30번";
  var _currentSpot = "개봉 현대아파트";
  var _parkingDuration = "3시간 30분";
  final _currentAreaTextStyle = const TextStyle(
      fontSize: 20, color: Colors.cyan, fontWeight: FontWeight.bold);
  final _dropDownItemTextStyle =
      const TextStyle(fontSize: 13, color: Colors.black);
  final _infoTextStyle = const TextStyle(fontSize: 15, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(appBar: AppBar(), title: "내 차 찾기"),
      bottomNavigationBar: MyMenu(selectedIndex: 0),
      body: Container(
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, blurRadius: 5, offset: Offset(4, 8))
              ],
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                    child: DropdownButton(
                        value: _selectedValue,
                        items: _valueList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text('차량번호 | ' + value,
                                style: _dropDownItemTextStyle),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                        underline: null,
                        style: _dropdownTextStyle,
                        icon: _dropdownIcon,
                        iconEnabledColor: Colors.grey)),
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(_currentArea,
                            style: _currentAreaTextStyle), // 주차 구역
                        padding: EdgeInsets.only(bottom: 10),
                      ),
                      Text("위치 : " + _currentSpot,
                          style: _infoTextStyle), // 주차장 위치
                      Text("주차시간 : " + _parkingDuration,
                          style: _infoTextStyle) // 주차 시간
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: const Divider(height: 10, color: Colors.grey),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Icon(Icons.circle,
                            size: 12,
                            color: Colors.deepOrangeAccent), // 현재 위치 아이콘
                        Container(
                            child: Text('현재 위치', style: _infoTextStyle),
                            padding: EdgeInsets.only(left: 5)),
                        SizedBox(width: 10),
                        Icon(Icons.rectangle,
                            size: 12,
                            color: Colors.deepOrangeAccent), // 주차 위치 아이콘
                        Container(
                            child: Text('주차 위치', style: _infoTextStyle),
                            padding: EdgeInsets.only(left: 5)),
                      ],
                    ),
                  ),
                ],
              )),
              Flexible(
                fit: FlexFit.tight,
                child: WebView(
                  initialUrl:
                      "http://3.37.217.255:8080/swagger-ui/index.html#/",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
