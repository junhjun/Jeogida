import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/providers/find_car_provider.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';

class BookMarkCarWidget extends StatefulWidget {
  const BookMarkCarWidget({Key? key}) : super(key: key);

  @override
  State<BookMarkCarWidget> createState() => _BookMarkCarWidgetState();
}

class _BookMarkCarWidgetState extends State<BookMarkCarWidget> {
  final _dropdownTextStyle = const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500, fontFamily: 'GmarketSans');
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.i("car dropdown menu build");
    List<Car> carList = context.watch<FindCarProvider>().bookMarkCarList;
    List<DropdownMenuItem<Car>> dropDownMenuItem = carList
        .map(((e) => DropdownMenuItem(
            value: e,
            child: Text(
              "${e.name}  |  ${e.number}",
              style: _dropdownTextStyle,
            ))))
        .toList();
    Car? selectedCar = context.watch<FindCarProvider>().selectedCar;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 15),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffe7e7e7)),
          borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton(
          borderRadius: BorderRadius.circular(5),
          items: dropDownMenuItem,
          value: selectedCar,
          onChanged: (Car? value) {
            context.read<FindCarProvider>().setSelectedCar(value);
            context.read<FindCarProvider>().setCarInfo();
          },
          isExpanded: true,
          underline: Container(),
          dropdownColor: Colors.white,
          hint: Text("차량을 선택하세요", style: _dropdownTextStyle)),
    );
  }
}
