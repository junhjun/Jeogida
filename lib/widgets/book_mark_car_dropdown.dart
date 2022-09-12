import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/providers/find_car_provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/book_mark_car.dart';
import '../models/book_mark_car_list.dart';
import '../services/bookmark_service.dart';

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
    return DropdownButton(
        items: context
            .watch<FindCarProvider>()
            .bookMarkCarList
            ?.cars
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  "차량번호  |  ${e.number}",
                  style: _dropdownTextStyle,
                )))
            .toList(),
        value: context.watch<FindCarProvider>().selectedCar,
        onChanged: (BookMarkCar? value) {
          context.read<FindCarProvider>().setSelectedCar(value);
          context.read<FindCarProvider>().setCarInfo();
        },
        hint: Text("차량을 선택하세요", style: _dropdownTextStyle));
  }
}
