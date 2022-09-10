import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/models/book_mark_space.dart';
import 'package:parking_spot_frontend/providers/find_space_provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/book_mark_space_list.dart';
import '../services/bookmark_service.dart';

class BookMarkSpaceWidget extends StatefulWidget {
  const BookMarkSpaceWidget({Key? key}) : super(key: key);

  @override
  State<BookMarkSpaceWidget> createState() => _BookMarkSpaceWidgetState();
}

class _BookMarkSpaceWidgetState extends State<BookMarkSpaceWidget> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));
  final _dropdownTextStyle = const TextStyle(fontSize: 15, color: Colors.black);
  final _dropdownIcon = const Icon(Icons.arrow_drop_down, size: 30);
  late Future<BookMarkSpaceList> bookMarkModel; // BookMarkData

  @override
  void initState() {
    super.initState();
    bookMarkModel = BookMarkService.getBookmarkSpaceList(
        context.read<UserProvider>().user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookMarkSpaceList>(
        future: bookMarkModel,
        builder:
            (BuildContext context, AsyncSnapshot<BookMarkSpaceList> snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffededed)),
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              child: DropdownButton(
                  hint: const Text("주차장을 선택하세요"),
                  value: context.watch<FindSpaceProvider>().selectedLocation,
                  items: snapshot.data!.spaces
                      .map((e) => DropdownMenuItem(
                          value: e, child: Text("위치  |  ${e.name}")))
                      .toList(),
                  onChanged: (BookMarkSpace? value) {
                    setState(() {
                      context.read<FindSpaceProvider>().setLocation(value!);
                      context.read<FindSpaceProvider>().setSpaceInfo();
                    });
                  },
                  underline: Container(),
                  isExpanded: true,
                  style: _dropdownTextStyle,
                  icon: _dropdownIcon,
                  iconEnabledColor: Colors.grey),
            );
          } else if (snapshot.hasError) {
            logger.e("error : ${snapshot.error}");
            return const Text("error"); // Error
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
