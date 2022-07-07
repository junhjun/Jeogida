import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/custom_app_bar.dart';

class AddSpaceView extends StatefulWidget {
  const AddSpaceView({Key? key}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<AddSpaceView> {
  final _valueList = ['개봉동 현대아파트', '아파트2', '아파트3', '아파트4'];
  var _selectedValue = '개봉동 현대아파트';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: "주차장 추가"),
      body: Container(
        height: 250,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 200), // 아래쪽 마진
        padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
        decoration: BoxDecoration(
            // 위쪽만 테두리 설정
            border:
                Border(top: BorderSide(color: Color(0xffEFEFEF), width: 8.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('주차장 선택',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Center(
              child: Container(
                // 너비 조절을 위해 컨테이너로 감쌈
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffAFAFAF)),
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                width: 450,
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                    isExpanded: true,
                    underline: Container(), // 밑 줄 제거
                    style: TextStyle(fontSize: 16, color: Color(0xffAFAFAF)),
                    icon: Padding(
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.arrow_drop_down, size: 40),
                    ),
                    iconEnabledColor: Colors.grey),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 28, 0, 0),
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text('주차장 추가',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.cyan, minimumSize: Size(450, 50))),
            ),
          ],
        ),
      ),
    );
  }
}
