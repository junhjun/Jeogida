import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/models/book_mark_space.dart';

import '../models/book_mark_space_list.dart';
import '../providers/book_mark_provider.dart';
import '../screens/find_space_view.dart';

class BookMarkSpaceWidget extends StatefulWidget {
  const BookMarkSpaceWidget({Key? key}) : super(key: key);

  @override
  State<BookMarkSpaceWidget> createState() => _BookMarkSpaceWidgetState();
}

class _BookMarkSpaceWidgetState extends State<BookMarkSpaceWidget> {
  final _dropdownTextStyle = const TextStyle(fontSize: 13, color: Colors.black);
  final _dropdownIcon = const Icon(Icons.arrow_drop_down, size: 30);
  late Future<BookMarkSpaceList> bookMarkModel; // BookMarkData

  @override
  void initState() {
    super.initState();
    bookMarkModel = BookMarkProvider.getBookmarkSpaceList();
    selectedSpace = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookMarkSpaceList>(
        future: bookMarkModel,
        builder:
            (BuildContext context, AsyncSnapshot<BookMarkSpaceList> snapshot) {
          if (snapshot.hasData) {
            return DropdownButton(
                hint: Text("주차장을 선택하세요"),
                value: selectedSpace,
                items: (snapshot.data!.spaces as List<BookMarkSpace>)
                    .map((e) => DropdownMenuItem(
                        child: Text("위치 | " + e.name), value: e))
                    .toList(),
                onChanged: (BookMarkSpace? value) {
                  setState(() {
                    selectedSpace = value;
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
