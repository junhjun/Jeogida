import 'dart:convert';
import 'package:parking_spot_frontend/utility/values.dart';
import '../models/car_info.dart';
import 'package:http/http.dart' as http;

class CarInfoService {
  static Future<CarInfo> getCarInfo(int carId) async {
    final response =
        // await http.get(Uri.parse("${serverAddress}place/${carId}"));
        await http.get(Uri.parse("${serverAddress}place/122"));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      return CarInfo.fromJson(json.decode(responseBody));
    } else {
      throw Exception("Failed to load carInfo");
    }
  }
}
