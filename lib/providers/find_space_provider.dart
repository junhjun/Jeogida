import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/models/space.dart';
import 'package:parking_spot_frontend/services/bookmark_service.dart';
import 'package:parking_spot_frontend/services/spaceinfo_service.dart';
import '../models/space_info.dart';

class FindSpaceProvider extends ChangeNotifier {
  final logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  List<Space> _bookMarkSpaceList = [];
  Space? _selectedLocation;
  SpaceInfo? _spaceInfo;
  int? _selectedIdx;

  List<Space> get bookMarkSpaceList => _bookMarkSpaceList;
  Space? get selectedLocation => _selectedLocation;
  SpaceInfo? get spaceInfo => _spaceInfo;
  int? get selectedIdx => _selectedIdx;

  void setLocation(Space? selected) {
    _selectedLocation = selected;
    logger.d("selectedLocation : ${_selectedLocation?.name}");
    notifyListeners();
  }

  Future<void> setSpaceInfo() async {
    if (_selectedLocation != null) {
      _spaceInfo = await SpaceInfoService.getSpaceInfo(_selectedLocation!.id);
      notifyListeners();
    }
  }

  void setIdx(int idx) {
    _selectedIdx = idx;
    notifyListeners();
  }

  void setBookMarkSpaceList(String? userCode) async {
    _bookMarkSpaceList = await BookMarkService.getBookmarkSpaceList(userCode!);
    notifyListeners();
  }

  void addSpaceToList(String userCode, Space location) async {
    int idx =
        _bookMarkSpaceList.indexWhere((element) => element.id == location.id);
    if (idx > 0) return;
    _bookMarkSpaceList.add(location);
    await BookMarkService.postBookMarkSpace(location.id, userCode);
    notifyListeners();
  }

  void deleteSpaceFromList(String userCode, int locationId) async {
    Space found =
        _bookMarkSpaceList.firstWhere((element) => element.id == locationId);
    http.Response result =
        await BookMarkService.deleteBookMarkSpace(userCode, locationId);
    if (result.statusCode != 200) {
      logger.e("Delete Space Failed");
      return;
    }
    _bookMarkSpaceList.remove(found);
    notifyListeners();
  }

  void clear() {
    _bookMarkSpaceList.clear();
    _selectedIdx = null;
    _selectedLocation = null;
    _spaceInfo = null;
  }
}
