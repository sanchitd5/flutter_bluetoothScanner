import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('iMove testing area'),
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
                LandingPageCardTileModel(
                    title: 'General Testing Area',
                    buttonText: 'Open',
                    icon: Icons.developer_mode,
                    onbuttonPressed: () {
                      Navigator.pushNamed(context, '/test/general');
                    }),
                LandingPageCardTileModel(
                    title: 'Database Testing Area',
                    buttonText: 'Open',
                    icon: Icons.developer_mode,
                    onbuttonPressed: () {
                      Navigator.pushNamed(context, '/test/sqflite');
                    }),
                LandingPageCardTileModel(
                    title: 'Intro Page',
                    buttonText: 'Open',
                    icon: Icons.arrow_forward,
                    onbuttonPressed: () {
                      Navigator.pushNamed(context, '/intro');
                    }),
                LandingPageCardTileModel(
                    title: 'Profile Setup Page',
                    buttonText: 'Open',
                    icon: Icons.arrow_forward,
                    onbuttonPressed: () {
                      Navigator.pushNamed(context, '/profileSetup/1');
                    }),
              ],
            ),
          ],
        )));
  }
}
