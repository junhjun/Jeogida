import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parking_spot_frontend/models/space.dart';
import 'package:parking_spot_frontend/utility/values.dart';

class LocationService {
  static Future<List<Space>> getAllLocation() async {
    final response = await http.get(Uri.parse("$serverAddress/location/"));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(responseBody);
      return json.map((e) => Space.fromJson(e)).toList();
    }
    throw Exception("Fail to GET location");
  }
}
