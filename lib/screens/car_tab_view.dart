import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../models/car.dart';
import '../providers/find_car_provider.dart';
import '../providers/user_provider.dart';

class CarTabView extends StatefulWidget {
  const CarTabView({super.key, required this.checkedList});

  final List<bool> checkedList;

  @override
  State<CarTabView> createState() => _CarTabViewState();
}

class _CarTabViewState extends State<CarTabView> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  Widget build(BuildContext context) {
    logger.i("Car Tab View build");

    List<Car> carList = context.watch<FindCarProvider>().bookMarkCarList;
    List<bool> checkedList = widget.checkedList;
    String? userCode = context.watch<UserProvider>().user!.id;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      primary: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        if (checkedList.contains(false)) {
                          checkedList.fillRange(0, checkedList.length, true);
                        } else {
                          checkedList.fillRange(0, checkedList.length, false);
                        }
                      });
                    },
                    child: const Text("전체선택",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500))),
                TextButton(
                    onPressed: () {
                      var length = carList.length;
                      for (int i = 0; i < length; i++) {
                        if (checkedList[i] == true) {
                          context
                              .read<FindCarProvider>()
                              .deleteCarFromList(userCode!, carList[i].id);
                        }
                      }
                    },
                    child: const Text("선택삭제",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w300))),
              ],
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: carList.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: CheckboxListTile(
                        title: Text(
                            "${carList.elementAt(i).name} | ${carList.elementAt(i).number}"),
                        value: checkedList[i],
                        onChanged: (bool? value) {
                          setState(() {
                            checkedList[i] = value!;
                          });
                        },
                        selected: checkedList[i],
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.cyan,
                        checkboxShape: const CircleBorder(),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                );
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: TextButton(
                onPressed: () => _dialogBuilder(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xfff8f7f7);
                    }
                    return Colors.white;
                  }),
                  overlayColor:
                      MaterialStateProperty.all<Color>(const Color(0xfff8f7f7)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.add_circle, color: Color(0xffcccccc), size: 50),
                    Text("차량을 추가하고 관리해보세요",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 차량 추가 팝업
  Future<void> _dialogBuilder(BuildContext context) {
    var titleTextStyle = const TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600);
    var infoTextStyle = const TextStyle(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500);
    var formTextStyle = const TextStyle(
        fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300);
    var buttonStyle = const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
        color: Colors.cyan);

    var carName = TextEditingController();
    var carNumber = TextEditingController();
    var userCode = context.read<UserProvider>().user!.id!;
    var findCarProvider = Provider.of<FindCarProvider>(context, listen: false);

    Widget addCarDialog = AlertDialog(
      buttonPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(child: Text('차량 추가', style: titleTextStyle)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('자동차 이름', style: infoTextStyle),
                TextField(
                  cursorColor: Colors.grey,
                  style: formTextStyle,
                  controller: carName,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan)),
                      hintText: '자동차 이름',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey)),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('차량 번호', style: infoTextStyle),
                TextField(
                  cursorColor: Colors.grey,
                  style: formTextStyle,
                  controller: carNumber,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan)),
                      hintText: '차량 번호',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey)),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Container(
          decoration: buttonStyle,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color(0xff01b2c7);
                    }
                    return Colors.cyan;
                  }),
                  overlayColor:
                      MaterialStateProperty.all<Color>(const Color(0xff01b2c7)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
                ),
                onPressed: () {
                  // 자동차 이름, 차량 번호 검사
                  if (carName.text.isNotEmpty && carNumber.text.isNotEmpty) {
                    context
                        .read<FindCarProvider>()
                        .addCarToList(userCode, carName.text, carNumber.text);
                    Navigator.of(context).pop(context);
                  }
                },
                child: const Text('차량 추가',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500))),
          ),
        )
      ],
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => ChangeNotifierProvider.value(
          value: findCarProvider, child: addCarDialog),
    );
  }
}
