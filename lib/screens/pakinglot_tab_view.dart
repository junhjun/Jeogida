import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../models/space.dart';
import '../providers/find_space_provider.dart';
import '../providers/location_provider.dart';
import '../providers/user_provider.dart';

class ParkingLotTabView extends StatefulWidget {
  const ParkingLotTabView({super.key, required this.checkedList});

  final List<bool> checkedList;

  @override
  State<ParkingLotTabView> createState() => _ParkingLotTabViewState();
}

class _ParkingLotTabViewState extends State<ParkingLotTabView> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  void initState() {
    super.initState();
    context.read<LocationProvider>().setLocationList();
  }

  @override
  Widget build(BuildContext context) {
    logger.i("ParkingLot Tab build");
    List<Space> spaceList =
        context.watch<FindSpaceProvider>().bookMarkSpaceList;
    List<bool> checkedList = widget.checkedList;
    String userCode = context.watch<UserProvider>().user!.id!;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      primary: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
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
                    var length = spaceList.length;
                    for (int i = 0; i < length; i++) {
                      if (checkedList[i] == true) {
                        logger.d("location id : ${spaceList[i].id}");
                        context
                            .read<FindSpaceProvider>()
                            .deleteSpaceFromList(userCode, spaceList[i].id);
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
            itemCount: spaceList.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: CheckboxListTile(
                      title: Text(spaceList.elementAt(i).name),
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
              onPressed: () {
                _dialogBuilder(context);
              },
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.add_circle, color: Color(0xffcccccc), size: 50),
                  Text("주차장을 추가하고 관리해보세요",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _dialogBuilder(BuildContext context) {
    String userCode = context.read<UserProvider>().user!.id!;
    var bookMarkList = context.read<FindSpaceProvider>().bookMarkSpaceList;
    var addSpaceFunc = context.read<FindSpaceProvider>().addSpaceToList;
    var locationList = context.read<LocationProvider>().locationList;
    var locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    Space? selectedLocation;

    var buttonStyle = const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
        color: Colors.cyan);

    showDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) {
          return ChangeNotifierProvider<LocationProvider>.value(
            value: locationProvider,
            child: AlertDialog(
              buttonPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Center(
                child: Text(
                  "차량 추가",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton(
                      isExpanded: true,
                      items: locationList
                          .map((e) => DropdownMenuItem<Space>(
                                value: e,
                                child: Text(e.name),
                              ))
                          .toList(),
                      onChanged: (Space? value) {
                        setState(() {
                          selectedLocation = value;
                        });
                      },
                      value: selectedLocation,
                      hint: const Text("주차장을 선택하세요"),
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
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color(0xff01b2c7);
                            }
                            return Colors.cyan;
                          }),
                          overlayColor: MaterialStateProperty.all<Color>(
                              const Color(0xff01b2c7)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                        onPressed: () {
                          // 자동차 이름, 차량 번호 검사
                          if (selectedLocation != null &&
                              !bookMarkList.contains(selectedLocation)) {
                            logger.d(
                                "selectedLocation : ${selectedLocation!.name}");
                            // context
                            //     .read<FindSpaceProvider>()
                            //     .addSpaceToList(userCode, selectedLocation!);
                            addSpaceFunc(userCode, selectedLocation!);
                          } else {
                            logger.e("이미 추가되어 있는 장소입니다.");
                          }
                          Navigator.of(context).pop(context);
                        },
                        child: const Text('차량 추가',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500))),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
