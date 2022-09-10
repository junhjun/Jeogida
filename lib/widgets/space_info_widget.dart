import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../providers/find_space_provider.dart';

class SpaceInfoWidget extends StatefulWidget {
  const SpaceInfoWidget({Key? key}) : super(key: key);

  @override
  State<SpaceInfoWidget> createState() => _SpaceInfoState();
}

class _SpaceInfoState extends State<SpaceInfoWidget> {
  final logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));
  @override
  Widget build(BuildContext context) {
    final disabledTextStyle = TextStyle(
        color: Colors.grey[600], fontSize: 15, fontWeight: FontWeight.bold);
    final disabledButtonStyle = ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: Colors.grey[300],
        onSurface: Colors.black);
    final activeButtonStyle = ElevatedButton.styleFrom(
        shape: const CircleBorder(), primary: Colors.cyan);
    const activeTextStyle = TextStyle(
        color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold);
    if (context.watch<FindSpaceProvider>().selectedLocation == null) {
      return const Center(
          child: Text("주차장을 선택하세요",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan)));
    }
    return ListView.separated(
        shrinkWrap: true,
        itemCount: context.watch<FindSpaceProvider>().spaceInfo != null
            ? context.watch<FindSpaceProvider>().spaceInfo!.spaces.length
            : 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext ctx, int idx) {
          return ElevatedButton(
              onPressed: () {
                context.read<FindSpaceProvider>().setIdx(idx);
                logger.d("selected index : $idx");
              },
              style: context.watch<FindSpaceProvider>().selectedIdx == idx
                  ? activeButtonStyle
                  : disabledButtonStyle,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                    child: Text(
                        " ${context.watch<FindSpaceProvider>().spaceInfo?.spaces[idx].name}\n${context.watch<FindSpaceProvider>().spaceInfo?.spaces[idx].parkedNum}석",
                        style: context.watch<FindSpaceProvider>().selectedIdx ==
                                idx
                            ? activeTextStyle
                            : disabledTextStyle)),
              ));
        },
        separatorBuilder: (BuildContext context, index) => const SizedBox(
              width: 10,
            ));
  }
}
