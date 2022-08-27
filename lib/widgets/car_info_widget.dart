import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/models/book_mark_car.dart';
import 'package:parking_spot_frontend/models/car_info.dart';
import 'package:parking_spot_frontend/providers/book_mark_provider.dart';
import 'package:parking_spot_frontend/screens/find_car_view.dart';

import '../main.dart';

class CarInfoWidget extends StatefulWidget {
  const CarInfoWidget({Key? key}) : super(key: key);

  @override
  State<CarInfoWidget> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfoWidget> {
  final _currentAreaTextStyle = const TextStyle(
      fontSize: 20, color: Colors.cyan, fontWeight: FontWeight.bold);
  final _infoTextStyle = const TextStyle(fontSize: 15, color: Colors.grey);
  late Future<CarInfo> carInfo; // BookMarkData

  @override
  void initState() {
    if (selectedCar != null)
      carInfo = BookMarkProvider.getCarInfo(selectedCar!.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CarInfo>(
        future: carInfo,
        builder: (BuildContext context, AsyncSnapshot<CarInfo> snapshot) {
          if (snapshot.hasData) {
            logger.i("carInfo\n${snapshot.data.toString()}");
            return Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   child: Text("${_floor}층 ${_sector}구역 ${_number}번",
                    //       style: _currentAreaTextStyle), // 주차 구역
                    //   padding: const EdgeInsets.only(bottom: 10),
                    // ),
                    // Text("위치 : ${_currentSpace}", style: _infoTextStyle), // 주차장 위치
                    // Text("주차시간 : ${_parkingHour}시간 ${_parkingMin}분",
                    //     style: _infoTextStyle) // 주차 시간
                  ],
                ));
          } else if (snapshot.hasError) {
            logger.e("error : ${snapshot.error}");
            return Text("error : ${snapshot.error}"); // Error
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
