import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/providers/find_car_provider.dart';
import 'package:parking_spot_frontend/providers/find_space_provider.dart';
import 'package:parking_spot_frontend/providers/location_provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:parking_spot_frontend/screens/login_view.dart';
import 'package:parking_spot_frontend/widgets/main_widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'utility/register_web_webview_stub.dart'
    if (dart.library.html) 'utility/register_web_webview.dart';

void main() {
  registerWebViewWebImplementation();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiProvider(
          providers: providers,
          child: const BuildBody(),
        ));
  }
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => FindCarProvider()),
  ChangeNotifierProvider(create: (_) => FindSpaceProvider()),
  ChangeNotifierProvider(create: (_) => LocationProvider()),
];

class BuildBody extends StatefulWidget {
  const BuildBody({Key? key}) : super(key: key);

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  @override
  Widget build(BuildContext context) {
    Widget body;
    if (context.watch<UserProvider>().user == null ||
        context.watch<UserProvider>().user!.id == null) {
      // if not logined
      body = const LoginView(); // Login View
    } else {
      body = const MainWidget(); // Main View
    }
    return body;
  }
}
