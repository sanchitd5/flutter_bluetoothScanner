import 'package:flutter/material.dart';
import '../models/models.dart';

class Configurations {
  final String _appTitle = "bluetoothScanner";
  final String _backendUrl = "http://localhost:8041";
  final bool _bypassbackend = true;
  final String _devUserName = "developer@dev.dev";
  final String _devUserpassword = "secretpassword";
  var layoutConfig =
      LayoutConfig(primaryColor: Colors.indigo, secondaryColor: Colors.yellow);

  final List<SidebarItem> sideBarItems = [];
  String get backendUrl {
    return _backendUrl;
  }

  String get appTitle {
    return _appTitle;
  }

  bool get bypassBackend {
    return _bypassbackend;
  }

  UserLoginDetails getDevDetails() {
    return UserLoginDetails(password: _devUserpassword, username: _devUserName);
  }
}
