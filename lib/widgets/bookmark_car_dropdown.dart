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
  final _dropdownTextStyle = const TextStyle(fontSize: 15, color: Colors.black);
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
              "${e.name} |  ${e.number}",
              style: _dropdownTextStyle,
            ))))
        .toList();
    Car? selectedCar = context.watch<FindCarProvider>().selectedCar;

    return DropdownButton(
        items: dropDownMenuItem,
        value: selectedCar,
        onChanged: (Car? value) {
          context.read<FindCarProvider>().setSelectedCar(value);
          context.read<FindCarProvider>().setCarInfo();
        },
        hint: Text("차량을 선택하세요", style: _dropdownTextStyle));
  }
}
