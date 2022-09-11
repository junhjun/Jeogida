import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';


import '../models/book_mark_car.dart';
import '../models/book_mark_car_list.dart';
import '../services/bookmark_service.dart';

import 'package:provider/provider.dart';
import 'package:parking_spot_frontend/providers/book_mark_provider.dart';
import 'package:parking_spot_frontend/widgets/car_listview_widget.dart';
import 'package:parking_spot_frontend/widgets/car_add_widget.dart';


class BookMarkView extends StatefulWidget {
  const BookMarkView({Key? key}) : super(key: key);

  @override
  State<BookMarkView> createState() => _BookMarkViewState();
}

class _BookMarkViewState extends State<BookMarkView> {

  // 수정 예정
  var data_spot = []; // 주차공간 정보 JSON 데이터 담을 리스트
  var ischecked_list2 = []; // 체크 여부 리스트
  bool allchecked2 = false; // 전체선택 시, 모든 값을 true로 변경하도록 설계


  @override
  void initState() {
    super.initState();
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
                Container(
                    alignment: Alignment.center, child: Tab(text: '주차장')),
              ],
              // 디자인
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
              // 스크롤링 가능하게
              controller: ScrollController(initialScrollOffset: 0),
              primary: false,
              child: Column(
                  children: [
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
                              child:
                              TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                      if(states.contains(MaterialState.pressed))
                                        return Color(0xffe7e7e7);
                                      return Color(0xffededed);
                                    }),
                                    overlayColor: MaterialStateProperty.all<Color>(Color(0xffe7e7e7)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                  ),
                                  onPressed: () {
                                    print("------------------");
                                    print(context.read<BookMarkProvider>().isCheckedCar);
                                    context.read<BookMarkProvider>().flipCheckCar();
                                    print(context.read<BookMarkProvider>().isCheckedCar);
                                    print("------------------");
                                  },
                                  child: Container(
                                      child: Text("전체선택", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500))
                                  )
                              )
                          ),
                          Container(
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                  if(states.contains(MaterialState.pressed))
                                    return Color(0xffe7e7e7);
                                  return Color(0xffededed);
                                }),
                                overlayColor: MaterialStateProperty.all<Color>(Color(0xffe7e7e7)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                              ),
                              onPressed: () {
                                // 삭제 위젯
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return Dialogdel(delCar: delCar, delSpot: delSpot);
                                //     }
                                //     );
                              },
                              child: Container(
                                  child: Text("선택삭제", style: TextStyle(color: Color(0xff989797), fontSize: 15, fontWeight: FontWeight.w300))
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // (2) 차량 리스트뷰
                    const CarListView(),

                    // (3) 차량 추가 버튼
                    Container(
                      width: MediaQuery.of(context).size.width * 0.88,
                      margin: EdgeInsets.fromLTRB(0, 6, 0, 15),
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                              if(states.contains(MaterialState.pressed))
                                return Color(0xfff8f7f7);
                              return Colors.white;
                            }),
                            overlayColor: MaterialStateProperty.all<Color>(Color(0xfff8f7f7)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                            // minimumSize: Size(220, 50),
                            // primary: Colors.white, // 버튼 내부 글자색
                            // textStyle: TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogaddCar();
                                });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.fromLTRB(0, 54, 0, 58),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle, color: Color(0xffcccccc), size: 55),
                                // Icon(Icons.add_circle, color: Colors.cyan, size: 55),
                                Text("차량을 추가하고 관리해보세요", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500))
                              ],
                            ),
                          )
                      ),
                    )
                  ]
              ),
            ),

            // 탭 2 : 주차장 탭
            SingleChildScrollView(
              // 스크롤링 가능하게
              controller: ScrollController(initialScrollOffset: 0),
              primary: false,
              child: Column(
                  children: [
                    // (1) 전체선택 + 선택삭제
                    // Container(
                    //   height: MediaQuery.of(context).size.width * 0.15,
                    //   padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                    //   margin: EdgeInsets.fromLTRB(0, 6.5, 0, 0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //           child:
                    //           TextButton(
                    //               style: ButtonStyle(
                    //                 backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    //                   if(states.contains(MaterialState.pressed))
                    //                     return Color(0xffe7e7e7);
                    //                   return Color(0xffededed);
                    //                 }),
                    //                 overlayColor: MaterialStateProperty.all<Color>(Color(0xffe7e7e7)),
                    //                 shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    //               ),
                    //               onPressed: () {
                    //                 if(allchecked2 == false) {
                    //                   setState(() {
                    //                     ischecked_list2.fillRange(0, ischecked_list2.length, true);
                    //                     allchecked2 = true;
                    //                   });
                    //                 }
                    //                 else {
                    //                   setState(() {
                    //                     ischecked_list2.fillRange(0, ischecked_list2.length, false);
                    //                     allchecked2 = false;
                    //                   });
                    //                 }
                    //               },
                    //               child: Container(
                    //                   child: Text("전체선택", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500))
                    //               )
                    //           )
                    //       ),
                    //       Container(
                    //         child: TextButton(
                    //           style: ButtonStyle(
                    //             backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    //               if(states.contains(MaterialState.pressed))
                    //                 return Color(0xffe7e7e7);
                    //               return Color(0xffededed);
                    //             }),
                    //             overlayColor: MaterialStateProperty.all<Color>(Color(0xffe7e7e7)),
                    //             shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    //           ),
                    //           onPressed: () {
                    //             showDialog(
                    //                 context: context,
                    //                 builder: (context) {
                    //                   return Dialogdel(delCar: delCar, delSpot: delSpot);
                    //                 });
                    //           },
                    //           child: Container(
                    //               child: Text("선택삭제", style: TextStyle(color: Color(0xff989797), fontSize: 15, fontWeight: FontWeight.w300))
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    // (2) 주차장 리스트뷰
                    SpotListView(data_spot: data_spot,
                        ischecked_list2: ischecked_list2),

                    // (3) 주차장 추가 버튼
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.88,
                    //   margin: EdgeInsets.fromLTRB(0, 6, 0, 15),
                    //   child: TextButton(
                    //       style: ButtonStyle(
                    //         backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    //           if(states.contains(MaterialState.pressed))
                    //             return Color(0xfff8f7f7);
                    //           return Colors.white;
                    //         }),
                    //         overlayColor: MaterialStateProperty.all<Color>(Color(0xfff8f7f7)),
                    //         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    //       ),
                    //       onPressed: () {
                    //         showDialog(
                    //             context: context,
                    //             builder: (context) {
                    //               return DialogaddSpot(
                    //                   addSpot: addSpot, addCheck2: addCheck2);
                    //             });
                    //       },
                    //       child: Container(
                    //         height: MediaQuery.of(context).size.width * 0.5,
                    //         padding: EdgeInsets.fromLTRB(0, 54, 0, 58),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Icon(Icons.add_circle, color: Color(0xffcccccc), size: 55),
                    //             // Icon(Icons.add_circle, color: Colors.cyan, size: 55),
                    //             Text("주차장을 추가하고 관리해보세요", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500))
                    //           ],
                    //         ),
                    //       )
                    //   ),
                    // )
                  ]
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


// 커스텀 위젯2 - 주차장 리스트뷰

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
    if (widget.data_spot.isNotEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.88,
        child: ListView.builder(
          // 주차장 리스트
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.data_spot.length, // 리스트의 길이만큼 ListTile 개수 설정
          itemBuilder: (context, i) {
            // 필수 파라미터 2개
            return Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              margin: EdgeInsets.fromLTRB(0, 6.5, 0, 6.5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: CheckboxListTile(
                title: Text(widget.data_spot[i]["name"],
                    style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.w500)),
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
    } else {
      // 아직 리스트에 데이터가 담기지 않았을 때 -> 로딩 표시
      return CircularProgressIndicator();
    }
  }
}


// // 커스텀 위젯3 - 차량 추가 팝업 -> car_add_widget.dart


// 커스텀 위젯4 - 주차장 추가 팝업
class DialogaddSpot extends StatefulWidget {
  DialogaddSpot({Key? key, this.addSpot, this.addCheck2}) : super(key: key);
  final addSpot;
  final addCheck2;

  @override
  State<DialogaddSpot> createState() => _DialogaddSpotState();
}

class _DialogaddSpotState extends State<DialogaddSpot> {
  // var inputData3 = TextEditingController();
  var _valueList = [];
  var _selectedValue;

  @override
  void initState() {
    _valueList = ['차량1', '차량2', '차량3', '차량4'];
    _selectedValue = _valueList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text('주차장 추가', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600))),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.12,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // width: MediaQuery.of(context).size.width * 0.6,
                height: 90,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('주차장 선택', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500)),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xffededed)),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(5),
                        dropdownColor: Color(0xffededed),
                        value: _selectedValue,
                        items: _valueList.map((value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                        underline: Container(),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        icon: Padding(
                          padding: EdgeInsets.all(0),
                          child: Icon(Icons.arrow_drop_down, size: 25),
                        ),
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
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)), color: Colors.cyan),
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    if(states.contains(MaterialState.pressed))
                      return Color(0xff01b2c7);
                    return Colors.cyan;
                  }),
                  overlayColor: MaterialStateProperty.all<Color>(Color(0xff01b2c7)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                ),
                onPressed: () {
                  if (_selectedValue.text != '') {
                    // 주차장 이름 입력해야 추가됨
                    widget.addSpot(_selectedValue.text);
                    widget.addCheck2();
                  }
                  Navigator.pop(context);
                },
                child: Text('주차장 추가', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500))),
          ),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.03,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('정말로 삭제하시겠습니까?', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
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
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if(states.contains(MaterialState.pressed))
                          return Color(0xffc0bfbf);
                        return Color(0xffcccccc);
                      }),
                      overlayColor: MaterialStateProperty.all<Color>(Color(0xffc0bfbf)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      minimumSize: MaterialStateProperty.all(Size(120,35))
                  ),
                  onPressed: () {
                    Navigator.pop(context); // 추가 버튼 클릭 시 창 닫기
                  },
                  child: Text('취소', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600))),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if(states.contains(MaterialState.pressed))
                          return Color(0xff01b2c7);
                        return Colors.cyan;
                      }),
                      overlayColor: MaterialStateProperty.all<Color>(Color(0xff01b2c7)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                      minimumSize: MaterialStateProperty.all(Size(120,35))
                  ),
                  onPressed: () {
                    delCar();
                    delSpot();
                    Navigator.pop(context); // 추가 버튼 클릭 시 창 닫기
                  },
                  child: Text('삭제', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600))),
            ],
          ),
        )
      ],
    );
  }
}
