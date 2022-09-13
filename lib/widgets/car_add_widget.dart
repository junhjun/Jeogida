import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:parking_spot_frontend/providers/book_mark_provider.dart';
import '../models/book_mark_car.dart';
import '../models/book_mark_car_list.dart';
import '../services/bookmark_service.dart';

import 'package:parking_spot_frontend/screens/bookmark_view.dart';


class DialogaddCar extends StatefulWidget {
  const DialogaddCar({Key? key, required this.userCode}) : super(key: key);
  final String userCode;

  @override
  State<DialogaddCar> createState() => _DialogaddCarState();
}

class _DialogaddCarState extends State<DialogaddCar> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  var inputCarName = TextEditingController();
  var inputCarNum = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      buttonPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text('차량 추가', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600))),
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
                    Text('자동차 이름', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                    TextField(
                      cursorColor: Colors.grey,
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300),
                      controller: inputCarName,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                          hintText: '자동차 이름',
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey)),
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
                    Text('차량 번호', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                    TextField(
                      cursorColor: Colors.grey,
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300),
                      controller: inputCarNum,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
                          hintText: '차량 번호',
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey)),
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
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)), color: Colors.cyan),
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
                  if ((inputCarName.text != '') & (inputCarNum.text != '')) {
                    BookMarkService.postBookmarkCar(
                        inputCarName.text,
                        inputCarNum.text,
                        widget.userCode
                        // context.read<UserProvider>().user!.id!
                        // '117893793138796152457'
                        );
                  }
                  Navigator.pop(context); // 추가 버튼 클릭 시 창 닫기

                  // 여기가 문제!!
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => ChangeNotifierProvider(
                        create: (context) => UserProvider(),
                        // child: MyApp()
                        child: BookMarkView(),
                          )));
                  },
                child: Container(
                    child: Text('차량 추가', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)))),
          ),
        )
      ],
    );
  }
}
