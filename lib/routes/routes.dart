import 'package:flutter/material.dart';

import '../screens/screens.dart';

class Routes {
  Map<String, WidgetBuilder> base = {
    '/login': (ctx) => Login(),
    '/home': (ctx) => Home(),
    SignUp.route: (ctx) => SignUp(),
    TestArea.route: (ctx) => TestArea(),
    SqfliteTesting.route: (ctx) => SqfliteTesting(),
    BluetoothConnection.route: (ctx) => BluetoothConnection(),
    DeviceScreen.route: (ctx) => DeviceScreen(),
    IntroModule.route: (ctx) => IntroModule(),
    ProfileSetupPage1.route: (ctx) => ProfileSetupPage1(),
    ProfileSetupPage2.route: (ctx) => ProfileSetupPage2()
  };

  Widget landingPage = Home();
}
