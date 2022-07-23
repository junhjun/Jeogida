import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/BookMark/bookmark_view.dart';
import 'package:parking_spot_frontend/MyPageView.dart';
import 'package:parking_spot_frontend/change_password_view.dart';
import 'package:parking_spot_frontend/home_view.dart';
import 'package:parking_spot_frontend/login_view.dart';

import 'FindCar/find_car.dart';
import 'FindCar/register_web_webview_stub.dart'
    if (dart.library.html) 'register_web_webview.dart';
import 'FindSpace/find_space.dart';

void main() {
  registerWebViewWebImplementation();
  runApp(
    MaterialApp(
      title: "Parking Spot",
      initialRoute: FindCar.routeName,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case FindCar.routeName:
            return MaterialPageRoute(builder: (context) => FindCar());
          case FindSpace.routeName:
            return MaterialPageRoute(builder: (context) => FindSpace());
          case LoginView.routeName:
            return MaterialPageRoute(builder: (context) => LoginView());
          case MyPageView.routeName:
            return MaterialPageRoute(builder: (context) => MyPageView());
          case BookMarkView.routeName:
            return MaterialPageRoute(builder: (context) => BookMarkView());
          case ChangePasswordView.routeName:
            return MaterialPageRoute(
                builder: (context) => ChangePasswordView());
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => HomeView());
      },
    ),
  );
}
