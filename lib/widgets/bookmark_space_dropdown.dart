import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/models/space.dart';
import 'package:parking_spot_frontend/providers/find_space_provider.dart';
import 'package:provider/provider.dart';

class BookMarkSpaceWidget extends StatefulWidget {
  const BookMarkSpaceWidget({Key? key}) : super(key: key);

  @override
  State<BookMarkSpaceWidget> createState() => _BookMarkSpaceWidgetState();
}

class _BookMarkSpaceWidgetState extends State<BookMarkSpaceWidget> {
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));
  final _dropdownTextStyle = const TextStyle(fontSize: 15, color: Colors.black);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Space> spaceList =
        context.watch<FindSpaceProvider>().bookMarkSpaceList;
    List<DropdownMenuItem<Space>> dropDownItem = spaceList
        .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
              e.name,
              style: _dropdownTextStyle,
            )))
        .toList();
    Space? selectedSpace = context.watch<FindSpaceProvider>().selectedLocation;

    return DropdownButton(
        items: dropDownItem,
        value: selectedSpace,
        onChanged: (Space? value) {
          context.read<FindSpaceProvider>().setLocation(value);
          context.read<FindSpaceProvider>().setSpaceInfo();
        },
        hint: Text("주차장을 선택하세요", style: _dropdownTextStyle));
  }
}
