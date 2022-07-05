import 'package:flutter/material.dart';

class MyList extends StatelessWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.white, // 전체 배경 색상
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: TabBar(
                tabs: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Tab(text: '차량')
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Tab(text: '주차장')),
                ],
                // 디자인 관련 속성들
                indicatorWeight: 8,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.cyan,
                labelStyle: TextStyle(fontSize: 18),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54

              ),
            ),
            body: TabBarView(
              children: [
                Container(
                  child: ListView(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        ListTile(
                          contentPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                          leading: Icon(Icons.check_circle),
                          title: Text('전체선택'),
                          trailing: Text('선택삭제', style: TextStyle(color: Colors.grey)), // 버튼으로 구현 필요
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
                      ]).toList()
                  )
                ),
                Container(
                    child: ListView(
                        children: ListTile.divideTiles(
                            context: context,
                            tiles: [
                              ListTile(
                                contentPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                leading: Icon(Icons.check_circle),
                                title: Text('전체선택'),
                                trailing: Text('선택삭제', style: TextStyle(color: Colors.grey)), // 버튼으로 구현 필요
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
                            ]).toList()
                    )
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 77,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xffE7E7E8), width: 3))
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xffF1F0F0),
                iconSize: 30,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.explore),
                      label: '내 차 찾기',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: '주차공간 찾기'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.star_outline),
                      label: '즐겨찾기'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: '마이페이지'
                  )
                ]
              ),
            )
          ),
        ),
    );
  }
}
