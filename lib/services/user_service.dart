import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/utility/values.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/user.dart';

class UserService {
  static var logger =
      Logger(printer: PrettyPrinter(methodCount: 0, colors: false));

  static Future<void> postUser(User user) async {
    http.Response response = await http.post(Uri.parse("${serverAddress}user"),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
        body: json.encode(user.toJson()));
    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i("User post success");
    } else if (response.statusCode == 400) {
      logger.e("User post failed\n${response.body}");
    } else {
      logger.e("User post failed\n${response.body}");
    }
  }
}
