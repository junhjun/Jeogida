import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';

class BookMarkView extends StatefulWidget {
  const BookMarkView({Key? key}) : super(key: key);

  @override
  State<BookMarkView> createState() => _BookMarkViewState();
}

class _BookMarkViewState extends State<BookMarkView> {
  static const haniumURL = 'http://3.37.217.255:8080';

  var data_car = []; // 즐겨찾는 차량
  var data_spot = []; // 즐겨찾는 주차장
  var data_everyspot = []; // 전체 주차장

  var ischecked_list1 = []; // 차량 체크박스
  var ischecked_list2 = []; // 주차장 체크박스

  bool allchecked1 = false; // 전체선택 default 값
  bool allchecked2 = false; // 전체선택 시 모두 true로 변경되도록

  var Code; // userCode

  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  var car_id = 206; // 매번 시작 시 마다 바꿔야 함

  // 차량 탭
  // (1) 즐겨찾기 차량 추가
  addCarNum(name, num, userCode) {
    postDataCar(name, num, userCode);
    setState(() {
      // UI 데이터 업데이트
      data_car.add({
        "id": car_id,
        "number": num,
        "name": name,
        "user_id": userCode,
      });
      car_id = car_id + 1; // 차량 추가 시 마다 id 값 +1
    });
  }

  // (2) 체크박스
  addCheck1() {
    setState(() {
      ischecked_list1.add(false);
    });
  }

  // (3) 즐겨찾기 차량 제거
  delCar(userCode) {
    for (int i = 0; i < ischecked_list1.length; i++) {
      if (ischecked_list1[i] == true) {
        deleteDataCar(userCode, "${data_car[i]["id"]}");
        setState(() {
          // UI 데이터 업데이트
          ischecked_list1.removeAt(i);
          data_car.removeAt(i);
          i = -1; // 중복 제거
        });
      }
    }
  }

  // 주차장 탭
  // (1) 즐겨찾기 주차장 추가
  addSpot(spotInfo, userCode) {
    postDataSpot("${spotInfo["id"]}", userCode);
    setState(() {
      data_spot.add({
        "id": spotInfo["id"],
        "name": spotInfo["name"],
        "total": spotInfo["total"],
      });
    });
    logger.i("Add BookMarkSpot :\n$data_spot");
  }

  // (2) 체크박스
  addCheck2() {
    setState(() {
      ischecked_list2.add(false);
    });
  }

  // (3) 즐겨찾기 주차장 제거
  delSpot(userCode) {
    for (int i = 0; i < ischecked_list2.length; i++) {
      if (ischecked_list2[i] == true) {
        deleteDataSpot(userCode, "${data_spot[i]["id"]}");
        setState(() {
          ischecked_list2.removeAt(i);
          data_spot.removeAt(i);
          i = -1;
        });
      }
    }
  }

  // 차량 탭
  // (1) 즐겨찾기 차량 POST
  Future<void> postDataCar(name, num, userCode) async {
    final url = Uri.parse(haniumURL + "/car/" + userCode);
    final headers = {"Content-type": "application/json"};
    final response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "name": name,
          "number": num,
        }));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 201) {
      print(responseBody);
    } else {
      print(response.statusCode);
      throw Exception("Failed to load BookMarkCar");
    }
  }

  // (2) 즐겨찾기 차량 DELETE
  Future<void> deleteDataCar(userCode, carID) async {
    final url = Uri.parse(haniumURL + "/car/" + userCode + "/" + carID);
    final response = await http.delete(url);
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      print(responseBody);
    } else {
      print(response.statusCode);
      throw Exception("Failed to delete BookMarkCar");
    }
  }

  // 주차장 탭
  // (1) 즐겨찾기 주차장 POST
  Future<void> postDataSpot(locationID, userCode) async {
    final url = Uri.parse(
        haniumURL + "/favorite-location/" + userCode + "/" + locationID);
    final headers = {"Content-type": "application/json"};
    final response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "location_id": locationID,
          "user_id": userCode,
        }));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 201) {
      print(responseBody);
    } else {
      print(response.statusCode);
      throw Exception("Failed to load BookMarkSpot");
    }
  }

  // (2) 즐겨찾기 주차장 DELETE
  Future<void> deleteDataSpot(userCode, locationID) async {
    final url = Uri.parse(
        haniumURL + "/favorite-location/" + userCode + "/" + locationID);
    final response = await http.delete(url);
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      print(responseBody);
    } else {
      print(response.statusCode);
      throw Exception("Failed to delete BookMarkSpot");
    }
  }

  // (3) 전체 주차장 GET
  Future<void> getDataEverySpot() async {
    final url = Uri.parse(haniumURL + "/location");
    final response = await http.get(url);
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      print(responseBody);
    } else {
      print(response.statusCode);
      throw Exception("Failed to get EverySpot");
    }
  }

  // 즐겨찾기 차량, 즐겨찾기 주차장, 전체 주차장 GET + 리스트 업데이트
  Future<void> getData(userCode) async {
    final url_car = '$haniumURL/car/$userCode';
    final url_spot = '$haniumURL/favorite-location/$userCode';
    final url_everyspot = '$haniumURL/location';

    var result_car = await http.get(Uri.parse(url_car));
    var result_spot = await http.get(Uri.parse(url_spot));
    var result_everyspot = await http.get(Uri.parse(url_everyspot));

    if ((result_car.statusCode == 200) &
        (result_spot.statusCode == 200) &
        (result_everyspot.statusCode == 200)) {
      setState(() {
        data_car = jsonDecode(utf8.decode(result_car.bodyBytes));
        data_spot = jsonDecode(utf8.decode(result_spot.bodyBytes));
        data_everyspot = jsonDecode(utf8.decode(result_everyspot.bodyBytes));
      });
    } else {
      throw Exception('GET Failed');
    }

    for (int i = 0; i < data_car.length; i++) {
      ischecked_list1.add(false);
    }
    for (int i = 0; i < data_spot.length; i++) {
      ischecked_list2.add(false);
    }

    logger.i("GET CAR/SPOT");
    logger.i("BookMarkCar Data :\n$data_car\n$ischecked_list1");
    logger.i("BookMarkSpot Data :\n$data_spot\n$ischecked_list2");
    logger.i("EverySpot Data :\n$data_everyspot");
    logger.i("User ID :\n$Code");
  }

  @override
  void initState() {
    super.initState();
    Code = context.read<UserProvider>().user!.id;
    getData(Code);
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
                    child: Tab(text: '차량')),
                Container(alignment: Alignment.center, child: Tab(text: '주차장')),
              ],
              indicatorWeight: 8,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.cyan,
              labelStyle: TextStyle(fontSize: 18),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          decoration: BoxDecoration(color: Color(0xffededed)),
          child: TabBarView(children: [
            // 탭 1 : 차량 탭
            SingleChildScrollView(
              controller: ScrollController(initialScrollOffset: 0),
              primary: false,
              child: Column(children: [
                // (1) 전체선택 + 선택삭제
                Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  margin: EdgeInsets.fromLTRB(0, 6.5, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Color(0xffe7e7e7);
                              return Color(0xffededed);
                            }),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color(0xffe7e7e7)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0))),
                          ),
                          onPressed: () {
                            if (allchecked1 == false) {
                              setState(() {
                                ischecked_list1.fillRange(
                                    0, ischecked_list1.length, true);
                                allchecked1 = true;
                              });
                            } else {
                              setState(() {
                                ischecked_list1.fillRange(
                                    0, ischecked_list1.length, false);
                                allchecked1 = false;
                              });
                            }
                          },
                          child: Container(
                              child: Text("전체선택",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)))),
                      Container(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Color(0xffe7e7e7);
                              return Color(0xffededed);
                            }),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color(0xffe7e7e7)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialogdel(
                                      delCar: delCar,
                                      delSpot: delSpot,
                                      Code: Code);
                                });
                          },
                          child: Container(
                              child: Text("선택삭제",
                                  style: TextStyle(
                                      color: Color(0xff989797),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300))),
                        ),
                      )
                    ],
                  ),
                ),

                // (2) 차량 리스트뷰
                CarListView(
                    data_car: data_car, ischecked_list1: ischecked_list1),

                // (3) 차량 추가 버튼
                Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  margin: EdgeInsets.fromLTRB(0, 6, 0, 15),
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Color(0xfff8f7f7);
                          return Colors.white;
                        }),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Color(0xfff8f7f7)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DialogaddCar(
                                  addCarNum: addCarNum,
                                  addCheck1: addCheck1,
                                  Code: Code,
                                  data_car: data_car);
                            });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.fromLTRB(0, 54, 0, 58),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle,
                                color: Color(0xffcccccc), size: 55),
                            Text("차량을 추가하고 관리해보세요",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      )),
                )
              ]),
            ),

            // 탭 2 : 주차장 탭
            SingleChildScrollView(
              controller: ScrollController(initialScrollOffset: 0),
              primary: false,
              child: Column(children: [
                // (1) 전체선택 + 선택삭제
                Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  margin: EdgeInsets.fromLTRB(0, 6.5, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Color(0xffe7e7e7);
                                  return Color(0xffededed);
                                }),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Color(0xffe7e7e7)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                              onPressed: () {
                                if (allchecked2 == false) {
                                  setState(() {
                                    ischecked_list2.fillRange(
                                        0, ischecked_list2.length, true);
                                    allchecked2 = true;
                                  });
                                } else {
                                  setState(() {
                                    ischecked_list2.fillRange(
                                        0, ischecked_list2.length, false);
                                    allchecked2 = false;
                                  });
                                }
                              },
                              child: Container(
                                  child: Text("전체선택",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500))))),
                      Container(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Color(0xffe7e7e7);
                              return Color(0xffededed);
                            }),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Color(0xffe7e7e7)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialogdel(
                                      delCar: delCar,
                                      delSpot: delSpot,
                                      Code: Code);
                                });
                          },
                          child: Container(
                              child: Text("선택삭제",
                                  style: TextStyle(
                                      color: Color(0xff989797),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300))),
                        ),
                      )
                    ],
                  ),
                ),

                // (2) 주차장 리스트뷰
                SpotListView(
                    data_spot: data_spot, ischecked_list2: ischecked_list2),

                // (3) 주차장 추가 버튼
                Container(
                  width: MediaQuery.of(context).size.width * 0.88,
                  margin: EdgeInsets.fromLTRB(0, 6, 0, 15),
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Color(0xfff8f7f7);
                          return Colors.white;
                        }),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Color(0xfff8f7f7)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DialogaddSpot(
                                  addSpot: addSpot,
                                  addCheck2: addCheck2,
                                  Code: Code,
                                  data_spot: data_spot,
                                  data_everyspot: data_everyspot);
                            });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.fromLTRB(0, 54, 0, 58),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle,
                                color: Color(0xffcccccc), size: 55),
                            Text("주차장을 추가하고 관리해보세요",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      )),
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

// (1) 차량 리스트뷰
class CarListView extends StatefulWidget {
  const CarListView({Key? key, this.data_car, this.ischecked_list1})
      : super(key: key);
  final data_car;
  final ischecked_list1;

  @override
  State<CarListView> createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.data_car.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            margin: EdgeInsets.fromLTRB(0, 6.5, 0, 6.5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: CheckboxListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.data_car[i]["name"],
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  Text(widget.data_car[i]["number"],
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400))
                ],
              ),
              selected: widget.ischecked_list1[i],
              value: widget.ischecked_list1[i],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  widget.ischecked_list1[i] = value!;
                });
              },
              activeColor: Colors.cyan,
              checkboxShape: CircleBorder(),
            ),
          );
        },
      ),
    );
  }
}

// (2) 주차장 리스트뷰
class SpotListView extends StatefulWidget {
  const SpotListView({Key? key, this.data_spot, this.ischecked_list2})
      : super(key: key);
  final data_spot;
  final ischecked_list2;

  @override
  State<SpotListView> createState() => _SpotListViewState();
}

class _SpotListViewState extends State<SpotListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.data_spot.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            margin: EdgeInsets.fromLTRB(0, 6.5, 0, 6.5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: CheckboxListTile(
              title: Text(widget.data_spot[i]["name"],
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
              selected: widget.ischecked_list2[i],
              value: widget.ischecked_list2[i],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  widget.ischecked_list2[i] = value!;
                });
              },
              activeColor: Colors.cyan,
              checkboxShape: CircleBorder(),
            ),
          );
        },
      ),
    );
  }
}

// (3) 차량 추가 팝업
class DialogaddCar extends StatefulWidget {
  DialogaddCar(
      {Key? key, this.addCarNum, this.addCheck1, this.Code, this.data_car})
      : super(key: key);
  final addCarNum;
  final addCheck1;
  final Code;
  final data_car;

  @override
  State<DialogaddCar> createState() => _DialogaddCarState();
}

class _DialogaddCarState extends State<DialogaddCar> {
  var inputData1 = TextEditingController();
  var inputData2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text('차량 추가',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600))),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.25,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 75,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('자동차 이름',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    TextField(
                      cursorColor: Colors.grey,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      controller: inputData1,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan)),
                          hintText: '자동차 이름',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey)),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 75,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('차량 번호',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    TextField(
                      cursorColor: Colors.grey,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      controller: inputData2,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan)),
                          hintText: '차량 번호',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Colors.cyan),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Color(0xff01b2c7);
                    return Colors.cyan;
                  }),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Color(0xff01b2c7)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
                ),
                onPressed: () {
                  if ((inputData1.text != '') & (inputData2.text != '')) {
                    // 자동차 이름, 차량 번호 모두 입력해야 추가됨
                    widget.addCarNum(
                        inputData1.text, inputData2.text, widget.Code);
                    widget.addCheck1();
                  }
                  Navigator.pop(context); // 추가 버튼 클릭 시 창 닫기
                },
                child: Container(
                    child: Text('차량 추가',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)))),
          ),
        )
      ],
    );
  }
}

// (4) 주차장 추가 팝업
class DialogaddSpot extends StatefulWidget {
  DialogaddSpot(
      {Key? key,
      this.addSpot,
      this.addCheck2,
      this.Code,
      this.data_spot,
      this.data_everyspot})
      : super(key: key);
  final addSpot;
  final addCheck2;
  final Code;
  final data_spot;
  final data_everyspot;

  @override
  State<DialogaddSpot> createState() => _DialogaddSpotState();
}

class _DialogaddSpotState extends State<DialogaddSpot> {
  var bmSpotNameList = [];
  var everySpotNameList = [];
  var selectedValue;
  var spotInfo;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.data_spot.length; i++) {
      bmSpotNameList.add(widget.data_spot[i]['name']);
    }
    for (int i = 0; i < widget.data_everyspot.length; i++) {
      everySpotNameList.add(widget.data_everyspot[i]['name']);
    }
    selectedValue = everySpotNameList[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text('주차장 추가',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600))),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.12,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 90,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('주차장 선택',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffededed)),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(5),
                        dropdownColor: Color(0xffededed),
                        value: selectedValue,
                        items: everySpotNameList.map((value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                        underline: Container(),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        icon: Padding(
                            padding: EdgeInsets.all(0),
                            child: Icon(Icons.arrow_drop_down, size: 25)),
                        iconEnabledColor: Colors.grey,
                        isExpanded: true,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: Colors.cyan),
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Color(0xff01b2c7);
                    return Colors.cyan;
                  }),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Color(0xff01b2c7)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
                ),
                onPressed: () {
                  if ((selectedValue != '') &&
                      !(bmSpotNameList.contains(selectedValue))) {
                    // 즐겨찾기 주차장과 중복되지 않으면
                    for (int i = 0; i < widget.data_everyspot.length; i++) {
                      if (widget.data_everyspot[i]["name"] == selectedValue) {
                        spotInfo = widget.data_everyspot[i];
                      }
                    }
                    widget.addSpot(spotInfo, widget.Code);
                    widget.addCheck2();
                  } else {
                    print("해당 주차장을 즐겨찾기에 추가할 수 없습니다.(이미 등록되어 있음)");
                  }
                  Navigator.pop(context);
                },
                child: Text('주차장 추가',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500))),
          ),
        )
      ],
    );
  }
}

// (5) 삭제 안내 팝업
class Dialogdel extends StatefulWidget {
  Dialogdel({Key? key, this.delCar, this.delSpot, this.Code}) : super(key: key);
  final delCar;
  final delSpot;
  final Code;

  @override
  State<Dialogdel> createState() => _DialogdelState();
}

class _DialogdelState extends State<Dialogdel> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.03,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('정말로 삭제하시겠습니까?',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      actions: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xffc0bfbf);
                        return Color(0xffcccccc);
                      }),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Color(0xffc0bfbf)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                      minimumSize: MaterialStateProperty.all(Size(120, 35))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('취소',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600))),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xff01b2c7);
                        return Colors.cyan;
                      }),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Color(0xff01b2c7)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                      minimumSize: MaterialStateProperty.all(Size(120, 35))),
                  onPressed: () {
                    widget.delCar(widget.Code);
                    widget.delSpot(widget.Code);
                    Navigator.pop(context);
                  },
                  child: Text('삭제',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600))),
            ],
          ),
        )
      ],
    );
  }
}
