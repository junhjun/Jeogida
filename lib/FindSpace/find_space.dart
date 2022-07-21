import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'register_web_webview_stub.dart'
  if (dart.library.html) 'register_web_webview.dart';


void main() {
  registerWebViewWebImplementation();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late WebViewController _controller;

  final _valueList = ['개봉현대아파트', '스타필드코엑스몰', '아파트2', '아파트3'];
  var _selectedValue = '개봉현대아파트';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindSpace',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar( // 상단바
            backgroundColor: Colors.white, // 상단바 색상
            title: Text('주차공간 찾기', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500))
        ),
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
              // 주차공간 드롭다운 버튼
              Container(
                width: 170,
                height: 25,
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffd2d0d0)),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                child: DropdownButton(
                    value: _selectedValue,
                    items: _valueList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text('위치 | ' + value),
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
                    iconEnabledColor: Colors.grey
                )
              ),

              // 주차공간 정보
              Container(
                width: 220,
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xff53bbcc),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('B1', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500)),
                          Text('14석', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xffe5e3e3),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('B2', style: TextStyle(color: Color(0xff7c7b7b), fontSize: 23, fontWeight: FontWeight.w500)),
                          Text('30석', style: TextStyle(color: Color(0xff7c7b7b), fontSize: 12, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xffe5e3e3),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('B3', style: TextStyle(color: Color(0xff7c7b7b), fontSize: 23, fontWeight: FontWeight.w500)),
                          Text('50석', style: TextStyle(color: Color(0xff7c7b7b), fontSize: 12, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 아이콘 정보
              Container(
                height: 60,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xffe3e2e2)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          Icon(Icons.rectangle, size: 14, color: Color(0xff62b946)),
                          Text('주차 가능', style: TextStyle(color: Colors.grey, fontSize: 12))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          Icon(Icons.rectangle, size: 14, color: Color(
                              0xfffada4f)),
                          Text('장애인 구역', style: TextStyle(color: Colors.grey, fontSize: 12))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          Icon(Icons.rectangle, size: 14, color: Color(
                              0xff2e4911)),
                          Text('주차 불가', style: TextStyle(color: Colors.grey, fontSize: 12))
                        ],
                      ),
                    ),
                  ],
                )
              ),

              // 웹뷰
              Container(
                alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        decoration: BoxDecoration(border: Border.all(color: Color(0xffe3e2e2))),
                        width: 350,
                        height: 250,
                          child: WebView(
                            initialUrl: "http://3.37.217.255:8080/swagger-ui/index.html#/",
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated: (WebViewController webViewController) {
                              _controller = webViewController;
                            },
                          ),
                      )
                      ,Text('지도를 클릭하면 확대해서 볼 수 있습니다', style: TextStyle(color: Colors.grey, fontSize: 12))
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}