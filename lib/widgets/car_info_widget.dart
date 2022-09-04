import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/providers/find_car_provider.dart';
import 'package:provider/provider.dart';

class CarInfoWidget extends StatefulWidget {
  const CarInfoWidget({Key? key}) : super(key: key);

  @override
  State<CarInfoWidget> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfoWidget> {
  final _currentAreaTextStyle = const TextStyle(
      fontSize: 28, color: Colors.cyan, fontWeight: FontWeight.bold);
  final _infoTextStyle = const TextStyle(fontSize: 14, color: Colors.grey);
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final findCarProvider = Provider.of<FindCarProvider>(context, listen: true);
    DateTime dt = (findCarProvider.carInfo != null &&
            findCarProvider.carInfo?.parkingInfoChangedAt != null)
        ? DateTime.parse(findCarProvider.carInfo!.parkingInfoChangedAt!)
        : DateTime.now();
    DateTime now = DateTime.now();
    Duration duration = now.difference(dt);
    var floor = findCarProvider.carInfo?.parkingLotName ?? 0;
    var number = findCarProvider.carInfo?.parkingInfoNumber ?? 0;
    var location = findCarProvider.carInfo?.locationName ?? "차량을 선택하세요";
    logger.d("CarInfo\n"
        "위치 : $location $floor층 $number번\n"
        "주차 시간 : ${duration.inMinutes ~/ 60} 시간 ${duration.inMinutes % 60} 분\n"
        "mapId : ${findCarProvider.carInfo?.mapId}");

    return Container(
      padding: EdgeInsets.fromLTRB(4, 25, 4, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            child:
                Text("$floor층 $number번", style: _currentAreaTextStyle), // 주차 구역
          ),
          Text("- 위치 : $location", style: _infoTextStyle), // 주차장 위치
          Text("- 주차시간 : ${duration.inMinutes ~/ 60}시간 ${duration.inMinutes % 60}분",
              style: _infoTextStyle),
          // Divider
          Container(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
            child: const Divider(thickness: 0.3, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
