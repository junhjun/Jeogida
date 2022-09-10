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
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  final _dropdownTextStyle = const TextStyle(fontSize: 15, color: Colors.black);
  final _dropdownIcon = const Icon(Icons.arrow_drop_down, size: 30);
  late Future<BookMarkCarList> bookMarkModel; // BookMarkData

  @override
  void initState() {
    super.initState();
    bookMarkModel = BookMarkService.getBookmarkCarList(
        context.read<UserProvider>().user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookMarkCarList>(
        future: bookMarkModel,
        builder:
            (BuildContext context, AsyncSnapshot<BookMarkCarList> snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffededed)),
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              child: DropdownButton(
                  hint: const Text("차량을 선택하세요"),
                  value: context.watch<FindCarProvider>().selectedCar,
                  items: snapshot.data!.cars
                      .map((e) => DropdownMenuItem(
                          value: e, child: Text("차량번호  |  ${e.number}")))
                      .toList(),
                  onChanged: (BookMarkCar? value) {
                    context.read<FindCarProvider>().setSelectedCar(value);
                    context.read<FindCarProvider>().setCarInfo();
                  },
                  underline: Container(),
                  isExpanded: true,
                  style: _dropdownTextStyle,
                  icon: _dropdownIcon,
                  iconEnabledColor: Colors.grey),
            );
          } else if (snapshot.hasError) {
            logger.e("error : ${snapshot.error}");
            return Text("error : ${snapshot.error}"); // Error
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
