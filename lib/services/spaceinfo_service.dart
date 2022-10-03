import 'dart:convert';

import 'package:parking_spot_frontend/models/space_info.dart';
import 'package:http/http.dart' as http;
import 'package:parking_spot_frontend/utility/values.dart';

class SpaceInfoService {
  static Future<SpaceInfo> getSpaceInfo(int locationId) async {
    final response = await http
        .get(Uri.parse("$serverAddress/location/parkinglot/$locationId"));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      return SpaceInfo.fromJson(json.decode(responseBody));
    } else {
      throw Exception("getSpaceInfo failed");
    }
  }
}
