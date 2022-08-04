import 'package:flutter/material.dart';

import '../models/book_mark_car.dart';
import '../models/book_mark_car_list.dart';
import '../providers/book_mark_provider.dart';
import '../screens/find_car_view.dart';

class BookMarkCarWidget extends StatefulWidget {
  const BookMarkCarWidget({Key? key}) : super(key: key);

  @override
  State<BookMarkCarWidget> createState() => _BookMarkCarWidgetState();
}

class _BookMarkCarWidgetState extends State<BookMarkCarWidget> {
  final _dropdownTextStyle = const TextStyle(fontSize: 13, color: Colors.black);
  final _dropdownIcon = const Icon(Icons.arrow_drop_down, size: 30);
  late Future<BookMarkCarList> bookMarkModel; // BookMarkData
  String _userid = "7"; // temp data

  @override
  void initState() {
    super.initState();
    bookMarkModel = BookMarkProvider.getBookmarkCarList(_userid);
    selectedCar = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookMarkCarList>(
        future: bookMarkModel,
        builder:
            (BuildContext context, AsyncSnapshot<BookMarkCarList> snapshot) {
          if (snapshot.hasData) {
            return DropdownButton(
                hint: Text("차량을 선택하세요"),
                value: selectedCar,
                items: (snapshot.data!.cars as List<BookMarkCar>)
                    .map((e) => DropdownMenuItem(
                        child: Text("차량번호 | " + e.number), value: e))
                    .toList(),
                onChanged: (BookMarkCar? value) {
                  setState(() {
                    selectedCar = value;
                  });
                },
                style: _dropdownTextStyle,
                icon: _dropdownIcon,
                iconEnabledColor: Colors.grey);
          } else if (snapshot.hasError) {
            return Text("error : ${snapshot.error}"); // Error
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
