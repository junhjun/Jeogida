// 즐겨찾기 페이지 수정함
// -> 아래 내용을 mylist.dart 내용으로 수정해야 함

import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/menu.dart';

class BookMarkView extends StatelessWidget {
  static const String routeName = "/BookMarkView";

  const BookMarkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "즐겨찾기",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: '차량'),
              Tab(text: '주차장'),
            ],
            indicatorWeight: 6,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Color(0xff75BCC6),
            labelStyle: TextStyle(fontSize: 18),
            labelColor: Colors.black,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: TabBarView(
          children: [
            Container(
                child: ListView(
                    children: ListTile.divideTiles(context: context, tiles: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                leading: Icon(Icons.check_circle),
                title: Text('전체선택'),
                trailing: Text('선택삭제',
                    style: TextStyle(color: Colors.grey)), // 버튼으로 구현 필요
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                leading: Icon(Icons.check_circle),
                title: Text('개봉현대아파트'),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                leading: Icon(Icons.add_circle),
                title: Text('추가'),
              )
            ]).toList())),
            Container(
                child: ListView(
                    children: ListTile.divideTiles(context: context, tiles: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                leading: Icon(Icons.check_circle),
                title: Text('전체선택'),
                trailing: Text('선택삭제',
                    style: TextStyle(color: Colors.grey)), // 버튼으로 구현 필요
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                leading: Icon(Icons.check_circle),
                title: Text('제네시스'),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                leading: Icon(Icons.check_circle),
                title: Text('아반떼'),
              ),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                leading: Icon(Icons.add_circle),
                title: Text('추가'),
              )
            ]).toList())),
          ],
        ),
        bottomNavigationBar: MyMenu(selectedIndex: 2),
      ),
    );
  }
}
