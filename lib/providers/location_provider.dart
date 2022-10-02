import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/services/location_service.dart';

import '../models/space.dart';

class LocationProvider extends ChangeNotifier {
  final logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  List<Space> _locationList = [];
  Space? _selectedLocation;

  List<Space> get locationList => _locationList;
  Space? get selectedLocation => _selectedLocation;

  void setLocationList() async {
    _locationList = await LocationService.getAllLocation();
    _locationList.map((e) => logger.d(e));
    notifyListeners();
  }

  void setLocation(Space location) {
    _selectedLocation = location;
    logger.d("selectedLocation : $_selectedLocation");
    notifyListeners();
  }

  void clear() {
    locationList.clear();
    _selectedLocation = null;
  }
}
