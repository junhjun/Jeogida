import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../models/book_mark_car.dart';
import '../models/car_info.dart';
import '../services/bookmark_service.dart';


class BookMarkProvider extends ChangeNotifier {
  final logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  // 체크박스 - 차량
  List _isCheckedCar = List.filled(10, false); // 추후에 수정 // 체크 여부 리스트 (true : 체크O / false : 체크X)
  bool _allCheckedCar = false; // 전체선택 default 값 (체크x)

  List get isCheckedCar => _isCheckedCar; // getter 생성
  bool get allCheckedCar => _allCheckedCar; // getter 생성

  void flipCheckCar() {
    if (_isCheckedCar.every((x) => x) == false) {
      _isCheckedCar.fillRange(0, _isCheckedCar.length, true);
    }
    else {
      _isCheckedCar.fillRange(0, _isCheckedCar.length, false);
    }
    notifyListeners();
  }

  void addCheckCar() {
    _isCheckedCar.add(false);
    notifyListeners();
  }
  void delCheckCar() {
    for (int i = 0; i < _isCheckedCar.length; i++) {
      if (_isCheckedCar[i] == true) {
        _isCheckedCar.removeAt(i);
        i = -1; // 나중에 체크
      }
    }
    notifyListeners();
  }


  // 차량 추가
  void postCar(String name, String num, String userCode) async {
    if (userCode != null) {
      await BookMarkService.postBookmarkCar(name, num, userCode);
      notifyListeners();
    }
  }




  // 체크박스 - 주차장
  List _isCheckedSpot = List.filled(10, false);
  bool _allCheckedSpot = false;

  List get isCheckedSpot => _isCheckedSpot;
  bool get allCheckedSpot => _allCheckedSpot;

  void flipCheckSpot() {
    if (_isCheckedSpot.every((x) => x) == false) {
      _isCheckedSpot.fillRange(0, _isCheckedSpot.length, true);
    }
    else {
      _isCheckedSpot.fillRange(0, _isCheckedSpot.length, false);
    }
    notifyListeners();
  }

  // 주차장 추가
}
