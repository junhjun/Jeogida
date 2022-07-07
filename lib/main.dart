import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/MyPageView.dart';
import 'package:parking_spot_frontend/bookmark_view.dart';
import 'package:parking_spot_frontend/change_password_view.dart';
import 'package:parking_spot_frontend/home_view.dart';
import 'package:parking_spot_frontend/login_view.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Parking Spot",
      initialRoute: HomeView.routeName,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomeView.routeName:
            return MaterialPageRoute(builder: (context) => HomeView());
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
