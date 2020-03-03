
import '../../helpers/Channels/AndroidChannel.dart';
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
                LandingPageCardTileModel(
                    title: 'getLocationFromChannel',
                    buttonText: 'Get',
                    icon: Icons.location_on,
                    onbuttonPressed: () {
                      AndroidChannel.getLastLocation();
                    }),
                LandingPageCardTileModel(
                    title: 'hit Access token from android',
                    buttonText: 'Log',
                    icon: Icons.android,
                    onbuttonPressed: () {
                      AndroidChannel.logAccessToken();
                    }),
                LandingPageCardTileModel(
                    title: 'hit Access token from flutter',
                    buttonText: 'Log',
                    icon: Icons.language,
                    onbuttonPressed: () {
                      UserDataProvider().accessTokenLogin();
                    }),
                LandingPageCardTileModel(
                    title: 'Log Internet Connectivity',
                    buttonText: 'Log',
                    icon: Icons.signal_cellular_connected_no_internet_4_bar,
                    onbuttonPressed: () {
                      AndroidChannel.logInternetConnectivity();
                    }),
                LandingPageCardTileModel(
                    title: 'Start Android Alarm Manager',
                    buttonText: 'Start',
                    icon: Icons.alarm_add,
                    onbuttonPressed: () {
                      AndroidChannel.startAlarmManager();
                    })
              ],
            ),
          ],
        )));
  }
}
