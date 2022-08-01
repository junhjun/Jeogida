import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/menu.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class BookMarkView extends StatefulWidget {
  static const String routeName = "/BookMarkView";
  const BookMarkView({Key? key}) : super(key: key);

  @override
  State<BookMarkView> createState() => _BookMarkViewState();
}

class _BookMarkViewState extends State<BookMarkView> {
  // 중요한 변수는 state에 저장
  static const haniumurl = 'http://3.37.217.255:8080';

  var data_car = []; // 차량 정보 JSON 데이터 담을 리스트
  var data_spot = []; // 주차공간 정보 JSON 데이터 담을 리스트


  var ischecked_list1 = []; // 체크 여부 리스트 (true : 체크O / false : 체크X)
  var ischecked_list2 = []; // 체크 여부 리스트

  bool allchecked1 = false; // 전체선택 디폴트 값 (false : 체크x)
  bool allchecked2 = false; // 전체선택 시, 모든 값을 true로 변경하도록 설계




  // 차량 탭
  // (1) 차량(이름, 번호) 추가 함수
  addCarNum(name, num){
    // POST (추가된 차량 정보를 서버에 등록)
    postDataCar('car', name, num, 7); // user_id == 7로 가정, 8부터는 POST가 안 됨 왜?

    // UI 용 데이터 업데이트
    setState(() {
      data_car.add(
          {
            "id": null, // 필요없지만 임의로 설정해둠
            "number": num,
            "name": name,
            "user_id": null, // 필요없지만 임의로 설정해둠
          }
      );
    });
  }
  // (2) 체크박스 함수
  addCheck1(){
    setState(() {
      ischecked_list1.add(false); // 차량 추가 시, false(체크x) 추가
    });
  }
  // (3) 차량 제거 함수
  delCar(){
    for(int i = 0; i < ischecked_list1.length; i ++) {
      if(ischecked_list1[i] == true) {

        // DELETE (서버의 차량 정보 삭제)
        deleteDataCar('car', data_car[i]["user_id"], data_car[i]["id"]);
        print('ID : ${data_car[i]["id"]}');
        print('USERID: ${data_car[i]["user_id"]}');

        // UI 용 데이터 업데이트
        setState(() {
          ischecked_list1.removeAt(i);
          data_car.removeAt(i);
          i = -1; // 중복 제거를 위해
        });
      }
    }
  }


  // 주차장 탭
  // (1) 주차장 추가 함수
  addSpot(name){
    // POST (추가된 주차장 정보를 서버에 등록)
    postDataSpot('location', name, 7); // total == 7로 가정
    setState(() {
      data_spot.add(
          {
            "id": null, // 임의로 설정
            "name": name,
            "total": null, // 임의로 설정
          }
      );
    });
  }
  // (2) 체크박스 함수
  addCheck2(){
    setState(() {
      ischecked_list2.add(false); // 주차장 추가 시, false(체크x) 추가
    });
  }
  // (3) 주차장 제거 함수
  delSpot(){
    for(int i = 0; i < ischecked_list2.length; i ++) {
      if(ischecked_list2[i] == true) {

        // DELETE (서버의 차량 정보 삭제)
        deleteDataSpot('location', data_spot[i]["id"]);
        print('ID : ${data_spot[i]["id"]}');

        // UI 용 데이터 업데이트
        setState(() {
          ischecked_list2.removeAt(i);
          data_spot.removeAt(i);
          i = -1; // 중복 제거를 위해
        });
      }
    }
  }

  // ====================================
  // 차량 POST / DELETE
  // POST /car   (데이터 등록하기)
  // choice : car(즐겨찾는 차량) / favorite-location(즐겨찾는 장소)
  Future<void> postDataCar(choice, name, num, user_id) async {
    final url = Uri.parse('$haniumurl/$choice');
    final headers = {"Content-type": "application/json"};
    final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(
            {
              // "id": , 얘는 자동으로 설정
              "number": num,
              "name": name,
              "user_id": user_id,
            }
        ));
    print('POST DATA FUNCTION - Body: ${response.body}');
  }

  // DELETE /car/{user_id}/{id}   (데이터 삭제)
  Future<void> deleteDataCar(choice, user_id, id) async {
    final url = Uri.parse('$haniumurl/$choice/$user_id/$id');
    final response = await http.delete(url);
    print('DELETE DATA FUNCTION - Body: ${response.body}');
  }
  // ====================================



  // ====================================
  // 주차장 POST / DELETE
  // POST /location   (데이터 등록하기)
  // choice : car(즐겨찾는 차량) / favorite-location(즐겨찾는 장소)
  Future<void> postDataSpot(choice, name, total) async {
    final url = Uri.parse('$haniumurl/$choice');
    final headers = {"Content-type": "application/json"};
    final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(
            {
              // "id": , 얘는 자동으로 설정
              "name": name,
              "total": total,
            }
        ));
    print('POST DATA FUNCTION - Body: ${response.body}');
  }

  // DELETE /car/{user_id}/{id}   (데이터 삭제)
  Future<void> deleteDataSpot(choice, id) async {
    final url = Uri.parse('$haniumurl/$choice/$id');
    final response = await http.delete(url);
    print('DELETE DATA FUNCTION - Body: ${response.body}');
  }
  // ====================================




  // PATCH /car/{id}   (데이터 수정)
  // 차량 정보 수정 -> user_id 바꿀 때만 사용할듯..?
  Future<void> patchData() async {
    final url = Uri.parse('$haniumurl/car/1');
    final headers = {"Content-type": "application/json"};
    final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(
            {
              "id": 1,
              "number": "11가 1111",
              "name": "name1",
              "user_id": 1,
            }
        )
    );
    print("patchData FUNCTION!");
    print('Body: ${response.body}');
  }

  // GET /car   (데이터 가져오기)
  // 리스트 업데이트
  getData() async {
    final url_car = '$haniumurl/car';
    final url_spot = '$haniumurl/location';

    var result_car = await http.get(Uri.parse(url_car));
    var result_spot = await http.get(Uri.parse(url_spot));

    if ((result_car.statusCode == 200) & (result_spot.statusCode == 200)){ // GET 정상 작동하면,
      setState(() { // state 변수 업데이트
        data_car = jsonDecode(utf8.decode(result_car.bodyBytes)); // 한글 깨짐 방지
        data_spot = jsonDecode(utf8.decode(result_spot.bodyBytes));
      });
    } else {
      throw Exception('Failed');
    }


    // 체크 리스트 업데이트
    for(int i = 0; i < data_car.length; i ++) {
      ischecked_list1.add(false); // 체크박스 false로 디폴트 값 설정
    }
    for(int i = 0; i < data_spot.length; i ++) {
      ischecked_list2.add(false); // 체크박스 false로 디폴트 값 설정
    }

    // 출력하여 확인
    print("GET FUNCTION");
    print("DATA_CAR : $data_car");
    print("DATA_SPOT : $data_spot");
    // print("CHECK_LIST_CAR : $ischecked_list1");
    // print("CHECK_LIST_SPOT : $ischecked_list2");
  }


  @override
  // 현재 파일(bookmark_view.dart)이 실행될 때마다 작동
  void initState() {
    super.initState();
    getData();
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, // 0 : 차량 탭 먼저 조회, 1 : 주차장 탭 먼저 조회
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
                // 디자인
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
                  // 탭 1 : 차량 탭
                  SingleChildScrollView( // 스크롤링 가능하게
                    controller: ScrollController(initialScrollOffset: 0),
                    primary: false,
                    child: Column(
                        children: [
                          // (1) 전체선택 버튼
                          Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE1E1E1)))),
                            child: CheckboxListTile(
                              title: Text('전체선택', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                              selected: allchecked1,
                              value: allchecked1,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool? value) { // 전체선택 버튼 클릭 시
                                setState(() {
                                  allchecked1 = value!;
                                  ischecked_list1.fillRange(0, ischecked_list1.length, value); // 체크 리스트의 모든 원소를 한 번에 변경
                                });
                              },
                              checkboxShape: CircleBorder(),
                            ),
                          ),

                          // (2) 차량 리스트뷰
                          CarListView(data_car : data_car, ischecked_list1 : ischecked_list1),
                        ]
                    )
                  ),

                  // 탭 2 : 주차장 탭
                  SingleChildScrollView( // 스크롤링 가능하게
                    controller: ScrollController(initialScrollOffset: 0),
                    primary: false,
                    child: Column(
                        children: [
                          // (1) 전체선택 버튼
                          Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE1E1E1)))),
                            child: CheckboxListTile(
                              title: Text('전체선택', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
                              selected: allchecked2,
                              value: allchecked2,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool? value) {
                                setState(() {
                                  allchecked2 = value!;
                                  ischecked_list2.fillRange(0, ischecked_list2.length, value);
                                });
                              },
                              checkboxShape: CircleBorder(),
                            ),
                          ),

                          // (2) 주차장 리스트뷰
                          SpotListView(data_spot : data_spot, ischecked_list2 : ischecked_list2),
                        ]
                    ),
                  ),
                ]
            ),
          ),

        bottomNavigationBar: MyMenu(selectedIndex: 2),

        floatingActionButton: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'btn1',
                backgroundColor: Colors.cyan,
                child: Icon(Icons.drive_eta),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return DialogaddCar(addCarNum : addCarNum, addCheck1: addCheck1);
                      });
                },
              ),
              FloatingActionButton(
                heroTag: 'btn2',
                backgroundColor: Colors.cyan,
                child: Icon(Icons.local_parking),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return DialogaddSpot(addSpot: addSpot, addCheck2: addCheck2);
                      });
                },
              ),
              FloatingActionButton(
                backgroundColor: Color(0xfff55e5e),
                heroTag: 'btn3',
                child: Icon(Icons.remove),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        return Dialogdel(delCar : delCar, delSpot : delSpot);
                      });
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
      ),
    );
  }
}






// 커스텀 위젯1 - 차량 리스트뷰
class CarListView extends StatefulWidget {
  const CarListView({Key? key, this.data_car, this.ischecked_list1}) : super(key: key);
  final data_car;
  final ischecked_list1;

  @override
  State<CarListView> createState() => _CarListViewState();
}
class _CarListViewState extends State<CarListView> {
  @override
  Widget build(BuildContext context) {
    if (widget.data_car.isNotEmpty) {
      return ListView.builder( // 차량 리스트
        physics: NeverScrollableScrollPhysics(), // 이거 없으면 ListTile을 터치하여 스크롤 하는 것이 안 됨
        shrinkWrap: true,
        itemCount: widget.data_car.length, // 리스트의 길이만큼 ListTile 개수 설정
        itemBuilder: (context, i) { // 필수 파라미터 2개
          return Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE1E1E1)))),
            child: CheckboxListTile(
              title: Text(widget.data_car[i]["name"], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              subtitle: Text(widget.data_car[i]["number"], style: TextStyle(fontSize: 14)),
              selected: widget.ischecked_list1[i],
              value: widget.ischecked_list1[i],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  widget.ischecked_list1[i] = value!;
                });
              },
              checkboxShape: CircleBorder(),
            ),
          );
        },
      );
    }
    else { // 아직 리스트에 데이터가 담기지 않았을 때 -> 로딩 표시
      return CircularProgressIndicator();
    }
  }
}


// 커스텀 위젯2 - 주차장 리스트뷰
class SpotListView extends StatefulWidget {
  const SpotListView({Key? key, this.data_spot, this.ischecked_list2}) : super(key: key);
  final data_spot;
  final ischecked_list2;

  @override
  State<SpotListView> createState() => _SpotListViewState();
}
class _SpotListViewState extends State<SpotListView> {
  @override
  Widget build(BuildContext context) {
    if (widget.data_spot.isNotEmpty) {
      return ListView.builder( // 주차장 리스트
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.data_spot.length, // 리스트의 길이만큼 ListTile 개수 설정
        itemBuilder: (context, i) { // 필수 파라미터 2개
          return Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE1E1E1)))),
            child: CheckboxListTile(
              title: Text(widget.data_spot[i]["name"], style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
              selected: widget.ischecked_list2[i],
              value: widget.ischecked_list2[i],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  widget.ischecked_list2[i] = value!;
                });
              },
              checkboxShape: CircleBorder(),
            ),
          );
        },
      );
    }
    else { // 아직 리스트에 데이터가 담기지 않았을 때 -> 로딩 표시
      return CircularProgressIndicator();
    }
  }
}


// 커스텀 위젯3 - 차량 추가 팝업
class DialogaddCar extends StatelessWidget {
  DialogaddCar({Key? key, this.addCarNum, this.addCheck1}) : super(key: key);
  final addCarNum;
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
                if((inputData1.text != '') & (inputData2.text != '')) { // 자동차 이름 / 차량 번호 모두 입력해야 추가됨
                  addCarNum(inputData1.text, inputData2.text);
                  addCheck1();
                }
                Navigator.pop(context); // 추가 버튼 클릭 시 창 닫기

                // 추가된 차량 정보 GET 하기 위해, 버튼 클릭 시 새로고침 구현
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => BookMarkView())).whenComplete(addCheck1);
              },
              child: Text('차량 추가')),
        )
      ],
    );
  }
}


// 커스텀 위젯4 - 주차장 추가 팝업
class DialogaddSpot extends StatelessWidget {
  DialogaddSpot({Key? key, this.addSpot, this.addCheck2}) : super(key: key);
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
                if(inputData3.text != '') { // 주차장 이름 입력해야 추가됨
                  addSpot(inputData3.text);
                  addCheck2();
                }
                Navigator.pop(context);
              },
              child: Text('주차장 추가')),
        )
      ],
    );
  }
}


// 커스텀 위젯5 - 삭제 안내 팝업
class Dialogdel extends StatelessWidget {
  Dialogdel({Key? key, this.delCar, this.delSpot}) : super(key: key);
  final delCar;
  final delSpot;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        // title: Text('경고'),
        content: Text('정말로 삭제하시겠습니까?'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: Size(70, 35),
                      primary: Colors.cyan, // 버튼 내부 글자색
                      textStyle: TextStyle(fontSize: 13),
                      backgroundColor: Colors.white
                  ),
                  onPressed: () {
                    delCar();
                    delSpot();
                    Navigator.pop(context); // 추가 버튼 클릭 시 창 닫기
                  },
                  child: Text('예')),
              TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: Size(70, 35),
                      primary: Colors.cyan, // 버튼 내부 글자색
                      textStyle: TextStyle(fontSize: 13),
                      backgroundColor: Colors.white
                  ),
                  onPressed: () {
                    Navigator.pop(context); // 추가 버튼 클릭 시 창 닫기
                  },
                  child: Text('아니오')),
            ],
          )
        ]
    );
  }
}
