import 'package:flutter/material.dart';

class AddCar extends StatelessWidget {
  const AddCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.white, // 전체 배경 색상
        home: Scaffold(
          appBar: AppBar( // 상단바
              backgroundColor: Colors.white, // 상단바 색상
              title: Text('차량 추가', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500))
          ),

          body: Container(
            height: 300,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 200), // 아래쪽 마진
            padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
            decoration: BoxDecoration( // 위쪽만 테두리 설정
                border: Border(top: BorderSide(color: Color(0xffEFEFEF), width: 8.0))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('자동차 이름', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration( // 박스 내부 디자인
                        hintText: '자동차 이름',
                        hintStyle: TextStyle(color: Color(0xffCECECE)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7.0))),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        )
                    )
                ),
                Text('차량 번호', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        hintText: '차량 번호',
                        hintStyle: TextStyle(color: Color(0xffCECECE)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(7.0))),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        )
                    )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 28, 0, 0),
                  alignment: Alignment.center,
                  child: ElevatedButton(onPressed: (){},
                      child: Text('차량 추가', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.cyan, minimumSize: Size(450, 60))
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}