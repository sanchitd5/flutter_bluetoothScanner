import '../../helpers/Channels/AndroidChannel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class TestArea extends StatelessWidget {
  static String route = "/test/general";
  final String firebaseServerToken =
      "AAAAiQfxmr0:APA91bHsAGfhoRBPW9LhltbL08UYFwksv7ES3-LdkF_v5wylIpjn_WpX8G5PzGsLfvnMc6988cih927PcPVugJMCPfhN-1TpwFg8nreGMQcwfUfqxeFqttUtBvgKa7-OxCFBmYhtVysr";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('General testing area'),
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
                ),
              ),
            )
          ],
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            LandingPageCard(
              tiles: [
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
                    }),
                LandingPageCardTileModel(
                    title: 'Trigger Notification',
                    buttonText: 'Trigger',
                    icon: Icons.alarm_add,
                    onbuttonPressed: () {}),
              ],
            ),
          ],
        )));
  }
}
