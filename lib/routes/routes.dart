import 'package:flutter/material.dart';

import '../screens/screens.dart';

class Routes {
  Map<String, WidgetBuilder> base = {
    '/login': (ctx) => Login(),
    '/home': (ctx) => Home(),
    SignUp.route: (ctx) => SignUp(),
    BluetoothConnection.route: (ctx) => BluetoothConnection(),
    DeviceScreen.route: (ctx) => DeviceScreen()
  };

  Widget landingPage = Home();
}
