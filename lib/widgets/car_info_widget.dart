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
  final _currentAreaTextStyle = const TextStyle(fontSize: 28, color: Colors.cyan, fontWeight: FontWeight.bold, fontFamily: 'GmarketSans');
  final _infoTextStyle = const TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'GmarketSans');
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var carInfo = context.watch<FindCarProvider>().carInfo;
    DateTime dt = (carInfo != null && carInfo.parkingInfoChangedAt != null)
        ? DateTime.parse(carInfo.parkingInfoChangedAt!)
        : DateTime.now();
    DateTime now = DateTime.now();
    Duration duration = now.difference(dt);
    var floor = carInfo?.parkingLotName ?? 0;
    var number = carInfo?.parkingInfoNumber ?? 0;
    var location = carInfo?.locationName ?? "차량을 선택하세요";
    logger.d("CarInfo\n"
        "위치 : $location $floor층 $number번\n"
        "주차 시간 : ${duration.inMinutes ~/ 60} 시간 ${duration.inMinutes % 60} 분\n"
        "mapId : ${carInfo?.mapId}");

    return Container(
      padding: const EdgeInsets.fromLTRB(4, 25, 4, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            child:
                Text("$floor층 $number번", style: _currentAreaTextStyle), // 주차 구역
          ),
          Text("- 위치 : $location", style: _infoTextStyle), // 주차장 위치
          Text(
              "- 주차시간 : ${duration.inMinutes ~/ 60}시간 ${duration.inMinutes % 60}분",
              style: _infoTextStyle),
        ],
      ),
    );
  }
}
