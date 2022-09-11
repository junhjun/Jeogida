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


  // 체크박스 - 주차장
  List _isCheckedSpot = [];
  bool _allCheckedSpot = false;

  List get isCheckedSpot => _isCheckedSpot;
  bool get allCheckedSpot => _allCheckedSpot;

  void addCheckSpot() {
    _isCheckedSpot.add(false);
    notifyListeners();
  }
  void delCheckSpot() {
    for (int i = 0; i < _isCheckedSpot.length; i++) {
      if (_isCheckedSpot[i] == true) {
        _isCheckedSpot.removeAt(i);
        i = -1;
      }
    }
    notifyListeners();
  }
}
