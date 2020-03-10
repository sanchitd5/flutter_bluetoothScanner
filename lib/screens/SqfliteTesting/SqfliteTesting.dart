import 'package:bluetoothScanner/helpers/helpers.dart';

import '../../helpers/Channels/AndroidChannel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';
import '../../utils/utils.dart';

class SqfliteTesting extends StatefulWidget {
  static String route = "/test/sqflite";

  @override
  _SqfliteTestingState createState() => _SqfliteTestingState();
}

class _SqfliteTestingState extends State<SqfliteTesting> {
  String _result = "Do Something";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Database testing area'),
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
                    title: 'Create SensorData table',
                    buttonText: 'Start',
                    icon: Icons.directions_walk,
                    onbuttonPressed: () async {
                      await SQLiteHelper.execute("CREATE TABLE sensorData ("
                          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                          "sensorId TEXT,"
                          "charcterstic TEXT,"
                          "timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,"
                          "data BLOB)");
                      setState(() {
                        _result = "Created Table sensorData";
                      });
                    }),
                LandingPageCardTileModel(
                    title: 'Delete SensorData table',
                    buttonText: 'Delete',
                    icon: Icons.delete_forever,
                    onbuttonPressed: () async {
                      await SQLiteHelper.execute("DROP TABLE sensorData");
                      setState(() {
                        _result = "Deleted Table sensorData";
                      });
                    }),
                LandingPageCardTileModel(
                    title: 'Log values from sensor table',
                    buttonText: 'Start',
                    icon: Icons.directions_walk,
                    onbuttonPressed: () async {
                      int val = await SQLiteHelper.queryRowCount('sensorData');
                      print(val.toString());
                      List data = await SQLiteHelper.rawSelectAll('sensorData');
                      setState(() {
                        _result = data.join("\n\n").toString();
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 500,
              width: 350,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Text(
                      _result,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
