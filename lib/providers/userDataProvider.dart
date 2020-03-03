import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/helpers.dart';
import '../utils/utils.dart';

class UserDataProvider with ChangeNotifier {
  String _accessToken;
  bool _userLoggedIn = false;

  Future<bool> accessTokenLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('accessToken')) return false;
    var localToken = prefs.getString('accessToken');
    bool status = await API().accessTokenLogin(localToken);
    if (status) {
      logger.i("Success with AccessToken: $localToken");
      _userLoggedIn = true;
      _accessToken = localToken;
      return true;
    } else {
      logger.e("Error with AccessToken: $localToken");
      _userLoggedIn = false;
      _accessToken = "";
      return false;
    }
  }

  String get accessToken {
    if (_accessToken == null) return "";
    return _accessToken;
  }

  bool get loginStatus {
    return _userLoggedIn;
  }

  void assignAccessToken(String token) async {
    if (token != "") {
      _accessToken = token;
      _userLoggedIn = true;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', token);
      prefs.setBool('loginStatus', true);
      notifyListeners();
    }
  }

  void logout() async {
    _userLoggedIn = false;
    notifyListeners();
    _accessToken = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void changeLoginStatus(bool status) {
    _userLoggedIn = status;
    notifyListeners();
  }
}
