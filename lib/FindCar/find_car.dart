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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(appBar: AppBar(), title: "내 차 찾기"),
      bottomNavigationBar: MyMenu(selectedIndex: 0),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(20, 30, 20, 70),
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffe3e2e2)),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 차량번호 드롭다운 버튼
            Container(
                width: 160,
                height: 25,
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffd2d0d0)),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: DropdownButton(
                    value: _selectedValue,
                    items: _valueList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text('차량번호 | ' + value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                    underline: Container(), // 밑 줄 제거
                    style: TextStyle(fontSize: 13, color: Colors.black),
                    icon: Padding(
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.arrow_drop_down, size: 23),
                    ),
                    iconEnabledColor: Colors.grey)),

            // 주차 정보
            Container(
              // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 90,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('B1층 A구역 30번',
                        style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    Column(
                      children: [
                        Text('위치 : 개봉 현대아파트',
                            style: TextStyle(color: Colors.grey, fontSize: 13)),
                        Text('주차시간 : 3시간 30분',
                            style: TextStyle(color: Colors.grey, fontSize: 13))
                      ],
                    )
                  ]),
            ),

            // 아이콘 정보
            Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xffe3e2e2)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          Icon(Icons.circle,
                              size: 7, color: Colors.deepOrangeAccent),
                          Text('현재 위치',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          Icon(Icons.rectangle,
                              size: 12, color: Colors.deepOrangeAccent),
                          Text('주차 위치',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12))
                        ],
                      ),
                    )
                  ],
                )),

            // 웹뷰
            Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffe3e2e2))),
                      width: 350,
                      height: 250,
                      child: WebView(
                        initialUrl:
                            "http://3.37.217.255:8080/swagger-ui/index.html#/",
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _controller = webViewController;
                        },
                      ),
                    ),
                    Text('지도를 클릭하면 확대해서 볼 수 있습니다',
                        style: TextStyle(color: Colors.grey, fontSize: 12))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
