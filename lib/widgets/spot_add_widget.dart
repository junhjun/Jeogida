import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:parking_spot_frontend/providers/book_mark_provider.dart';
import '../models/book_mark_space.dart';
import '../models/book_mark_space_list.dart';
import '../services/bookmark_service.dart';


class DialogaddSpot extends StatefulWidget {
  DialogaddSpot({Key? key}) : super(key: key);

  @override
  State<DialogaddSpot> createState() => _DialogaddSpotState();
}

class _DialogaddSpotState extends State<DialogaddSpot> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  // var inputData3 = TextEditingController();
  // var _valueList = [];
  // var _selectedValue;

  @override
  void initState() {
    super.initState();
    // _valueList = ['차량1', '차량2', '차량3', '차량4'];
    // _selectedValue = _valueList[0];
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
                width: MediaQuery.of(context).size.width * 0.6,
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
                  // 즐겨찾는 주차장 리스트에 추가(POST)
                  //
                  // if (_selectedValue.text != '') {
                  //   // 주차장 이름 입력해야 추가됨
                  //   widget.addSpot(_selectedValue.text);
                  //   widget.addCheck2();
                  // }
                  Navigator.pop(context);
                },
                child: Text('주차장 추가', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500))),
          ),
        )
      ],
    );
  }
}