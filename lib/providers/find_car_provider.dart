import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/models/book_mark_car_list.dart';
import 'package:parking_spot_frontend/services/bookmark_service.dart';

import '../models/book_mark_car.dart';
import '../models/car_info.dart';
import '../services/carinfo_service.dart';

class FindCarProvider extends ChangeNotifier {
  final logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  BookMarkCar? _selectedCar;
  CarInfo? _carInfo;
  BookMarkCarList? _bookMarkCarList;

  BookMarkCar? get selectedCar => _selectedCar;
  CarInfo? get carInfo => _carInfo;
  BookMarkCarList? get bookMarkCarList => _bookMarkCarList;

  void setSelectedCar(BookMarkCar? selectedCar) {
    _selectedCar = selectedCar;
    logger.d("selectedCar : ${_selectedCar?.number}");
    notifyListeners();
  }

  Future<void> setCarInfo() async {
    if (_selectedCar != null) {
      _carInfo = await CarInfoService.getCarInfo(_selectedCar!.id);
      notifyListeners();
    }
  }

  void setBookMarkCarList(String? userCode) async {
    if (userCode != null) {
      _bookMarkCarList = await BookMarkService.getBookmarkCarList(userCode);
      notifyListeners();
    }
  }

  void clear() {
    _selectedCar = null;
    _carInfo = null;
  }
}
