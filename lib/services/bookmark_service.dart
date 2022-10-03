import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car.dart';
import '../models/space.dart';
import '../utility/values.dart';

class BookMarkService {
  static Future<List<Car>> getBookmarkCarList(String userCode) async {
    final response = await http.get(Uri.parse("$serverAddress/car/$userCode"));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(responseBody);
      return json.map((e) => Car.fromJson(e)).toList();
    } else {
      throw Exception("Fail to GET bookMarkCar");
    }
  }

  static Future<List<Space>> getBookmarkSpaceList(String userCode) async {
    final response = await http
        .get(Uri.parse("$serverAddress/favorite-location/$userCode"));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(responseBody);
      return json.map((e) => Space.fromJson(e)).toList();
    } else {
      throw Exception("Fail to GET bookMarkSpace");
    }
  }

  static Future<Car> postBookmarkCar(
      String name, String num, String userCode) async {
    final response = await http.post(Uri.parse("$serverAddress/car/$userCode"),
        headers: <String, String>{"Content-type": "application/json"},
        body: jsonEncode(<String, String>{"name": name, "number": num}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic responseData = jsonDecode(response.body);
      int carId = responseData["car_id"];
      int userId = responseData["user_id"];
      return Car(carId, num, name, userId);
    }
    throw Exception("Fail to POST bookMarkCar");
  }

  static Future<void> postBookMarkSpace(int locationId, String userCode) async {
    final response = await http.post(
        Uri.parse("$serverAddress/favorite-location/$userCode/$locationId"),
        headers: <String, String>{
          'Content-type': 'application/json',
        });
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Fail to POST bookMarkSpace");
    }
  }

  static Future<http.Response> deleteBookMarkCar(
      String userCode, int carId) async {
    final http.Response response = await http.delete(
      Uri.parse("$serverAddress/car/$userCode/$carId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  static Future<http.Response> deleteBookMarkSpace(
      String userCode, int locationId) async {
    final http.Response response = await http.delete(
      Uri.parse("$serverAddress/car/$userCode/$locationId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
