import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/screens/find_car_view.dart';

import '../main.dart';
import '../models/book_mark_car.dart';
import '../models/book_mark_car_list.dart';
import '../providers/book_mark_provider.dart';

class BookMarkCarWidget extends StatefulWidget {
  final ValueChanged<BookMarkCar> update;
  const BookMarkCarWidget({required this.update, Key? key}) : super(key: key);

  @override
  State<BookMarkCarWidget> createState() => _BookMarkCarWidgetState(update);
}

class _BookMarkCarWidgetState extends State<BookMarkCarWidget> {
  final ValueChanged<BookMarkCar> update;
  _BookMarkCarWidgetState(this.update);

  final _dropdownTextStyle = const TextStyle(fontSize: 13, color: Colors.black);
  final _dropdownIcon = const Icon(Icons.arrow_drop_down, size: 30);
  late Future<BookMarkCarList> bookMarkModel; // BookMarkData
  String _userid = "7"; // temp user id

  @override
  void initState() {
    super.initState();
    bookMarkModel = BookMarkProvider.getBookmarkCarList(_userid);
  }
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookMarkCarList>(
        future: bookMarkModel,
        builder:
            (BuildContext context, AsyncSnapshot<BookMarkCarList> snapshot) {
          if (snapshot.hasData) {
            return DropdownButton(
                hint: const Text("차량을 선택하세요"),
                value: selectedCar,
                items: (snapshot.data!.cars as List<BookMarkCar>)
                    .map((e) => DropdownMenuItem(
                        child: Text("차량번호 | ${e.number}"), value: e))
                    .toList(),
                onChanged: (BookMarkCar? value) {
                  update(value!);
                },
                style: _dropdownTextStyle,
                icon: _dropdownIcon,
                iconEnabledColor: Colors.grey);
          } else if (snapshot.hasError) {
            logger.e("error : ${snapshot.error}");
            return Text("error : ${snapshot.error}"); // Error
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
