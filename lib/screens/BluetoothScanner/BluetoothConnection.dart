import 'package:flutter/material.dart';

import 'package:flutter_blue/flutter_blue.dart';

import 'BluetoothScanner.dart';
import '../../providers/providers.dart';

class BluetoothConnection extends StatelessWidget {
  static String route = "/bluetoothConnection";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Device Connection'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Consumer<UserDataProvider>(
            builder: (_, data, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
               
                Flexible(
                    child: StreamBuilder<BluetoothState>(
                        stream: FlutterBlue.instance.state,
                        initialData: BluetoothState.unknown,
                        builder: (c, snapshot) {
                          final state = snapshot.data;
                          if (state == BluetoothState.on) {
                            return FindDevicesScreen();
                          }
                          return BluetoothOffScreen(state: state);
                        }))
              ],
            ),
          ),
        ));
  }
}
