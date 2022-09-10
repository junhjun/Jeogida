import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:parking_spot_frontend/services/user_service.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);
  var logger = Logger(printer: PrettyPrinter(methodCount: 0, colors: false));
  GoogleSignInAccount? _currentUser;
  User? _user;

  GoogleSignInAccount? get currentUser => _currentUser;
  User? get user => _user;

  Future<void> handleLogIn() async {
    try {
      await _googleSignIn.signIn();
      logger.i("Login Successed");
      _currentUser = _googleSignIn.currentUser;
      _user = User(_currentUser?.displayName, _currentUser?.email,
          _currentUser?.id, _currentUser?.photoUrl);
      UserService.postUser(_user!);
      logger.d("User Info\n${_user.toString()}");
      _googleSignIn.signInSilently();
      notifyListeners();
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> handleLogOut() async {
    _googleSignIn.signOut();
    logger.i("Logout Successed");
    notifyListeners();
  }

  void clear() {
    _currentUser = null;
    _user = null;
    _currentUser = null;
  }
}
