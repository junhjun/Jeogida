import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/models/book_mark_space.dart';
import 'package:parking_spot_frontend/services/spaceinfo_service.dart';

import '../models/space_info.dart';

class FindSpaceProvider extends ChangeNotifier {
  final logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));
  BookMarkSpace? _selectedLocation;
  SpaceInfo? _spaceInfo;
  int? _selectedIdx;

  BookMarkSpace? get selectedLocation => _selectedLocation;
  SpaceInfo? get spaceInfo => _spaceInfo;
  int? get selectedIdx => _selectedIdx;

  void setLocation(BookMarkSpace? selected) {
    _selectedLocation = selected;
    logger.d("selectedLocation : ${_selectedLocation?.name}");
    notifyListeners();
  }

  Future<void> setSpaceInfo() async {
    if (_selectedLocation != null) {
      _spaceInfo = await SpaceInfoService.getSpaceInfo(_selectedLocation!.id);
      // debug
      for (int i = 0; i < _spaceInfo!.spaces.length; i++) {
        logger.d("${_spaceInfo!.spaces[i]}");
      }
      notifyListeners();
    }
  }

  void setIdx(int idx) {
    _selectedIdx = idx;
    notifyListeners();
  }

  void clear() {
    _selectedIdx = null;
    _selectedLocation = null;
    _spaceInfo = null;
  }
}
