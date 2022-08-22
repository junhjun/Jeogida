import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parking_spot_frontend/screens/login_view.dart';
import 'package:parking_spot_frontend/widgets/main_widget.dart';

import 'models/user.dart';
import 'utility/register_web_webview_stub.dart'
    if (dart.library.html) 'utility/register_web_webview.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
  'email',
]);

Future<void> handleLogIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}

Future<void> handleLogOut() => _googleSignIn.signOut();

late User? user;

void main() {
  registerWebViewWebImplementation();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        user = User(_currentUser?.displayName, _currentUser?.email,
            _currentUser?.id, _currentUser?.photoUrl);
        print(user.toString());
      }
    });
    _googleSignIn.signInSilently();
  }

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return MainWidget();
    } else {
      return LoginView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _buildBody(),
    );
  }
}
