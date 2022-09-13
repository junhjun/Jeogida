import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parking_spot_frontend/models/book_mark_car.dart';
import '../models/book_mark_car_list.dart';
import '../models/book_mark_space_list.dart';
import '../utility/values.dart';

class BookMarkService {
  static Future<BookMarkCarList> getBookmarkCarList(String userid) async {
    final response = await http.get(Uri.parse("${serverAddress}car/$userid"));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      return BookMarkCarList.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception("Fail to GET bookMarkCar");
    }
  }

  static Future<BookMarkSpaceList> getBookmarkSpaceList(String userid) async {
    final response =
        await http.get(Uri.parse("${serverAddress}favorite-location/$userid"));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      return BookMarkSpaceList.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception("Fail to GET bookMarkSpace");
    }
  }

  static Future<BookMarkCarList> postBookmarkCar(String name, String num, String userCode) async {
    final url = Uri.parse(serverAddress + "car/" + userCode);
    final headers = {"Content-type": "application/json"};
    final response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "name": name,
          "number": num,
        }));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      return BookMarkCarList.fromJson(jsonDecode(responseBody));
    } else {
      print(response.statusCode);
      throw Exception("Failed to load bookMarkCar");
    }
  }

  static void postBookMarkSpace(int userCode, int locationId) async {
    final response = await http.post(
      Uri.parse("${serverAddress}favorite-location/$locationId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Fail to POST bookMarkSpace");
    }
  }

  static void deleteBookMarkCar(int userCode, int carId) async {
    final http.Response response = await http.delete(
      Uri.parse("${serverAddress}car/$userCode/$carId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Fail to DELETE bookMarkCar");
    }
  }

  static void deleteBookMarkSpace(int userCode, int locationId) async {
    final http.Response response = await http.delete(
      Uri.parse("${serverAddress}car/$userCode/$locationId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Fail to DELETE bookMarkSpace");
    }
  }
}
