import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/book_mark_car_list.dart';
import '../models/book_mark_space_list.dart';
import '../utility/values.dart';

class BookMarkProvider {
  static Future<BookMarkCarList> getBookmarkCarList(String userid) async {
    final response = await http.get(Uri.parse(serverAddress + "car/" + userid));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      return BookMarkCarList.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception("Failed to load bookMarkCar");
    }
  }

  static Future<BookMarkSpaceList> getBookmarkSpaceList() async {
    final response =
        await http.get(Uri.parse(serverAddress + "favorite-location"));
    var responseBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      return BookMarkSpaceList.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception("Failed to load bookMarkSpace");
    }
  }
}
