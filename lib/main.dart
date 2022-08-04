import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/screens/bookmark_view.dart';
import 'package:parking_spot_frontend/screens/change_password_view.dart';
import 'package:parking_spot_frontend/screens/login_view.dart';
import 'package:parking_spot_frontend/screens/mypage_view.dart';

import 'screens/find_car_view.dart';
import 'screens/find_space_view.dart';
import 'utility/register_web_webview_stub.dart'
    if (dart.library.html) 'utility/register_web_webview.dart';

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
        return MaterialPageRoute(builder: (context) => FindCar());
      },
    ),
  );
}
