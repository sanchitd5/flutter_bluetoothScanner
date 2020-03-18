import 'package:flutter/material.dart';
import '../models/models.dart';

class Configurations {
  final String _appTitle = "bluetoothScanner";
  final String _backendUrl = "http://52.189.230.113:8003/api/";
  final bool _bypassbackend = false;
  final String _devUserName = "d@dev.dev";
  final String _devUserpassword = "secretpassword";

  var layoutConfig =
      LayoutConfig(primaryColor: Colors.indigo, secondaryColor: Colors.yellow);

  final List<IMoveDevice> _devices = [
    IMoveDevice(
      deviceID: "F8:F0:05:EB:DA:73",
      serviceID: "688ee5ce-0800-4e99-b278-a290e6da388f",
      name: "H1",
      characteristicID: "57a343ea-26d1-4104-8de4-7706115a21bd",
    ),
    IMoveDevice(
        deviceID: "F8:F0:05:EB:DA:6A",
        serviceID: "89bcf930-09c1-22a8-3d16-fbe2666aa8a7",
        name: "H2",
        characteristicID: "f21f4b71-a252-49e1-365b-cd8d033d7608"),
    IMoveDevice(
        deviceID: "F8:F0:05:C5:11:7A",
        serviceID: "38887a84-7acf-4551-8ea7-fad2e62bd8ec",
        name: "SORD12",
        characteristicID: "d8c63b24-2d30-4104-b42f-ad356acff07d"),
    IMoveDevice(
        serviceID: "38ef3bd5-a6ef-46db-924b-ed5c71b30699",
        characteristicID: "940778f8-8cff-4cd7-a5dc-e337edd72ec9",
        name: "SORD10",
        deviceID: "F8:F0:05:C5:11:AA")
  ];

  final List<SidebarItem> sideBarItems = [];

  String get backendUrl {
    return _backendUrl;
  }

  List<IMoveDevice> get iMoveDevices {
    return _devices;
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
