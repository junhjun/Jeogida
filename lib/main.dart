import 'package:flutter/material.dart';
import 'package:parking_spot_frontend/providers/find_car_provider.dart';
import 'package:parking_spot_frontend/providers/user_provider.dart';
import 'package:parking_spot_frontend/screens/login_view.dart';
import 'package:parking_spot_frontend/widgets/main_widget.dart';
import 'package:provider/provider.dart';

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
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => FindCarProvider()),
            FutureProvider(
                create: (context) => FindCarProvider().setCarInfo(),
                initialData: null),
          ],
          child: const BuildBody(),
        ));
  }
}

class BuildBody extends StatefulWidget {
  const BuildBody({Key? key}) : super(key: key);

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  @override
  Widget build(BuildContext context) {
    Widget body;
    if (context.watch<UserProvider>().user == null) {
      // if not logined
      body = const LoginView(); // Login View
    } else {
      body = const MainWidget(); // Main View
    }
    return body;
  }
}
