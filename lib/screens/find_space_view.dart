import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/utility/menu.dart';
import 'package:parking_spot_frontend/widgets/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/web_view_widget.dart';

class FindSpace extends StatefulWidget {
  static const String routeName = "/FindSpace";

  @override
  State<FindSpace> createState() => _MyAppState();
}

class _MyAppState extends State<FindSpace> {
  final controller = Completer<WebViewController>(); // WebView Controller
  final _valueList = ['개봉현대아파트', '스타필드코엑스몰', '아파트2', '아파트3'];
  var _selectedValue = '개봉현대아파트';
  final _iconTextStye = TextStyle(color: Colors.grey, fontSize: 12);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(appBar: AppBar(), title: "주차공간 찾기"),
      bottomNavigationBar: MyMenu(selectedIndex: 1),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DropDownButton
              Container(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                    child: DropdownButton(
                        value: _selectedValue,
                        items: _valueList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                        style: TextStyle(fontSize: 13, color: Colors.black),
                        icon: Icon(Icons.arrow_drop_down, size: 30),
                        iconEnabledColor: Colors.grey)),
              ),
              // Parking lot Elevated Button
              Container(
                padding: EdgeInsets.only(bottom: 20),
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
                  padding: EdgeInsets.only(bottom: 20),
                  child: Divider(color: Colors.grey, height: 5)),
              // Icons
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        TextButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.rectangle,
                              size: 14, color: Colors.green),
                          label: Text("주차 가능", style: _iconTextStye),
                        ),
                        TextButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.rectangle,
                              size: 14, color: Colors.yellow),
                          label: Text("장애인 구역", style: _iconTextStye),
                        ),
                        TextButton.icon(
                          onPressed: null,
                          icon: Icon(Icons.rectangle,
                              size: 14, color: Colors.grey),
                          label: Text("주차 불가", style: _iconTextStye),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              // WebView
              Flexible(
                  fit: FlexFit.tight,
                  child: WebViewStack(controller: controller)),
              // Zoom info text
              Center(
                child: Text('지도를 클릭하면 확대해서 볼 수 있습니다',
                    style: TextStyle(color: Colors.grey)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
