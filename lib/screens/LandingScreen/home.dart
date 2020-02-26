import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth Scanner'),
          actions: <Widget>[
            GestureDetector(
                onTap: () {},
                child: Consumer<UserDataProvider>(
                    builder: (_, data, __) => FlatButton(
                          child: Text('Logout'),
                          onPressed: () {
                            data.logout();
                            Navigator.pushReplacementNamed(context, '/');
                          },
                        )))
          ],
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            LandingPageCard(
              tiles: [
                LandingPageCardTileModel(
                    title: 'Connected Device',
                    buttonText: 'Connect',
                    icon: Icons.bluetooth,
                    onbuttonPressed: () {
                      Navigator.pushNamed(context, '/bluetoothConnection');
                    }),
              ],
            ),
          ],
        )));
  }
}
