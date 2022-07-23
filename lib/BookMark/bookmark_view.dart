import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/menu.dart';


class BookMarkView extends StatefulWidget {
  static const String routeName = "/BookMarkView";

  const BookMarkView({Key? key}) : super(key: key);

  @override
  State<BookMarkView> createState() => _BookMarkViewState();
}

class _BookMarkViewState extends State<BookMarkView> {
  // 차량 추가 팝업에 쓰이는 변수 및 함수
  var car_list = ['아반떼', '제네시스', '카니발'];
  var num_list = ['00가 0000', '00나 0000', '00다 0000'];
  addCar(input){
    setState(() {
      car_list.add(input);
    });
  }
  addNum(input){
    setState(() {
      num_list.add(input);
    });
  }
  // 체크박스에 쓰이는 변수 및 함수
  var _ischecked_list1 = [false, false, false];
  addCheck1(){
    setState(() {
      _ischecked_list1.add(false);
    });
  }

  // 주차장 추가 팝업에 쓰이는 변수 및 함수
  var spot_list = ['개봉현대아파트', '스타필드코엑스몰'];
  addSpot(input){
    setState(() {
      spot_list.add(input);
    });
  }
  // 체크박스에 쓰이는 변수 및 함수
  var _ischecked_list2 = [false, false];
  addCheck2(){
    setState(() {
      _ischecked_list2.add(false);
    });
  }

  // 전체선택에 쓰이는 변수
  bool _allchecked1 = false;
  bool _allchecked2 = false;



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, // 0 : 차량 탭 먼저, 1 : 주차장 탭 먼저
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
            iconTheme: IconThemeData(color: Colors.black),
          ),


          body: Container(
            child: TabBarView(
                children: [
                  // 페이지 1 : 차량
                  SingleChildScrollView( // 스크롤링 가능하게
                    child: Column(
                        children: [
                          Container( // 전체선택 버튼
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE1E1E1)))),

                            child: CheckboxListTile(
                              title: Text('전체선택', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                              selected: _allchecked1,
                              value: _allchecked1,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool? value) {
                                setState(() {
                                  _allchecked1 = value!;
                                  _ischecked_list1.fillRange(0, _ischecked_list1.length, value); // 모든 원소들을 value로 변경
                                  // _ischecked_list = [value, value, value];
                                });
                              },
                              checkboxShape: CircleBorder(),
                              // trailing: Text('선택삭제'),
                            ),
                          ),

                          ListView.builder( // 차량 리스트
                            shrinkWrap: true,
                            itemCount: car_list.length, // 리스트의 길이만큼 ListTile 개수 설정
                            itemBuilder: (context, i) { // 필수 파라미터 2개
                              return Container(
                                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE1E1E1)))),
                                child: CheckboxListTile(
                                  title: Text(car_list[i], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                                  subtitle: Text(num_list[i], style: TextStyle(fontSize: 14,),),
                                  selected: _ischecked_list1[i],
                                  value: _ischecked_list1[i],
                                  controlAffinity: ListTileControlAffinity.leading,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _ischecked_list1[i] = value!;
                                    });
                                  },
                                  checkboxShape: CircleBorder(),
                                ),
                              );
                            },
                          ),

                          Container( // 추가 버튼
                            child: ListTile(
                              leading: Icon(Icons.add),
                              title: Text('추가', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return DialogCar(addCar : addCar, addNum: addNum, addCheck1: addCheck1);
                                    });
                              },
                            ),
                          )
                        ]
                    ),
                  ),


                  // 페이지 2 : 주차장
                  SingleChildScrollView( // 스크롤링 가능하게
                    child: Column(
                        children: [
                          Container( // 전체선택 버튼
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE1E1E1)))),

                            child: CheckboxListTile(
                              title: Text('전체선택', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                              selected: _allchecked2,
                              value: _allchecked2,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool? value) {
                                setState(() {
                                  _allchecked2 = value!;
                                  _ischecked_list2.fillRange(0, _ischecked_list2.length, value);
                                });
                              },
                              checkboxShape: CircleBorder(),
                              // trailing: Text('선택삭제'),
                            ),
                          ),

                          ListView.builder( // 주차장 리스트
                            shrinkWrap: true,
                            itemCount: spot_list.length, // 리스트의 길이만큼 ListTile 개수 설정
                            itemBuilder: (context, i) { // 필수 파라미터 2개
                              return Container(
                                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE1E1E1)))),
                                child: CheckboxListTile(
                                  title: Text(spot_list[i], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                                  selected: _ischecked_list2[i],
                                  value: _ischecked_list2[i],
                                  controlAffinity: ListTileControlAffinity.leading,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _ischecked_list2[i] = value!;
                                    });
                                  },
                                  checkboxShape: CircleBorder(),
                                ),
                              );
                            },
                          ),

                          Container( // 추가 버튼
                            child: ListTile(
                              leading: Icon(Icons.add),
                              title: Text('추가', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return DialogSpot(addSpot: addSpot, addCheck2: addCheck2);
                                    });
                              },
                            ),
                          )
                        ]
                    ),
                  ),
                ]
            ),
          ),
        bottomNavigationBar: MyMenu(selectedIndex: 2)
      ),
    );
  }
}







// 커스텀 위젯 1 - 차량 추가 팝업
class DialogCar extends StatelessWidget {
  DialogCar({Key? key, this.addCar, this.addNum, this.addCheck1}) : super(key: key);
  final addCar;
  final addNum;
  final addCheck1;
  var inputData1 = TextEditingController();
  var inputData2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: Text('차량 추가', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
            ),
            TextField(
              controller: inputData1,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  hintText: '자동차 이름'
              ),
            ),
            TextField(
              controller: inputData2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  hintText: '차량 번호'
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
          alignment: Alignment.center,
          child: ElevatedButton(
              style: TextButton.styleFrom(
                  minimumSize: Size(232, 50),
                  primary: Colors.white, // 버튼 내부 글자색
                  textStyle: TextStyle(fontSize: 15),
                  backgroundColor: Colors.cyan
              ),
              onPressed: () {
                addCar(inputData1.text);
                addNum(inputData2.text);
                addCheck1();
                Navigator.pop(context);
              },
              child: Text('차량 추가')),
        )
      ],
    );
  }
}


// 커스텀 위젯 2 - 주차장 추가 팝업
class DialogSpot extends StatelessWidget {
  DialogSpot({Key? key, this.addSpot, this.addCheck2}) : super(key: key);
  final addSpot;
  final addCheck2;
  var inputData3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      content: Container(
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: Text('주차장 추가', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
            ),
            TextField(
              controller: inputData3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  hintText: '주차장 이름'
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
          alignment: Alignment.center,
          child: ElevatedButton(
              style: TextButton.styleFrom(
                  minimumSize: Size(232, 50),
                  primary: Colors.white, // 버튼 내부 글자색
                  textStyle: TextStyle(fontSize: 15),
                  backgroundColor: Colors.cyan
              ),
              onPressed: () {
                addSpot(inputData3.text);
                addCheck2();
                Navigator.pop(context);
              },
              child: Text('주차장 추가')),
        )
      ],
    );
  }
}