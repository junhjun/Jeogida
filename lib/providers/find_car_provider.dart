import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/services/bookmark_service.dart';
import '../models/car.dart';
import '../models/car_info.dart';
import '../services/carinfo_service.dart';

class FindCarProvider extends ChangeNotifier {
  final logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  List<Car> _bookMarkCarList = [];
  Car? _selectedCar;
  CarInfo? _carInfo;

  List<Car> get bookMarkCarList => _bookMarkCarList;
  Car? get selectedCar => _selectedCar;
  CarInfo? get carInfo => _carInfo;

  void setBookMarkCarList(String? userCode) async {
    if (userCode != null) {
      _bookMarkCarList = await BookMarkService.getBookmarkCarList(userCode);
      _bookMarkCarList.map((e) => logger.d(e));
      notifyListeners();
    }
  }

  void setSelectedCar(Car? selectedCar) {
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

  void addCarToList(String userCode, String name, String num) async {
    int idx = _bookMarkCarList.indexWhere((element) => element.number == num);
    if (idx > 0) return;
    Car newCar = await BookMarkService.postBookmarkCar(name, num, userCode);
    _bookMarkCarList.add(newCar);
    notifyListeners();
  }

  void deleteCarFromList(String userCode, int carId) async {
    Car found = bookMarkCarList.firstWhere((e) => e.id == carId);
    http.Response result =
        await BookMarkService.deleteBookMarkCar(userCode, carId);
    if (result.statusCode != 200) {
      logger.e("Delete Car Failed");
      return;
    }
    bookMarkCarList.remove(found);
    notifyListeners();
  }

  void clear() {
    bookMarkCarList.clear();
    _selectedCar = null;
    _carInfo = null;
    notifyListeners();
  }
}
