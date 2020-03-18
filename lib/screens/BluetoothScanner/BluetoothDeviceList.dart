import 'dart:async';
import 'dart:io';

import 'package:bluetoothScanner/helpers/BLE/IMoveBLEHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './BluetoothDeviceScreen.dart';
import '../../widgets/widgets.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../configurations/configurations.dart';

class FindDevicesScreen extends StatefulWidget {
  @override
  _FindDevicesScreenState createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
  final devices = Configurations().iMoveDevices;
  final bool filterDevices = true;
  final bool filterUnnamedDevices = true;

  @override
  void initState() {
    FlutterBlue.instance.startScan(timeout: Duration(seconds: 2));
    super.initState();
  }

  void _saveDeviceToPrefs(IMoveDevice device) async {
    SharedPreferences _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setString('defaultDevice', device.deviceID);
  }

  Future<Widget> _defaultDeviceDialog(BuildContext context,
      BluetoothDevice device, IMoveDevice selectedDevice) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Do you want to set this as your default device"),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () async {
                  _saveDeviceToPrefs(selectedDevice);
                  bool deviceAttachStatus =
                      await IMoveBLEHelper.attachListenerToDevice(
                          device,
                          selectedDevice.serviceID,
                          selectedDevice.characteristicID,
                          (sensorData, _characteristic) async {
                    print("RAW DATA:" + sensorData.toString());
                    if (sensorData.length > 20) {
                      SensorDataType2 convertedData = new SensorDataType2(
                          sensorData[2],
                          sensorData[3],
                          sensorData[4],
                          sensorData[5],
                          sensorData[6],
                          sensorData[7],
                          sensorData[8],
                          sensorData[9],
                          sensorData[10],
                          sensorData[11],
                          sensorData[12],
                          sensorData[13],
                          sensorData[14],
                          sensorData[15],
                          sensorData[16],
                          sensorData[17],
                          sensorData[18],
                          sensorData[19]);
                      print("Data after calc" +
                          convertedData.getAllData().toString());
                    } else
                      print("length was found to be ${sensorData.length}");
//                    await SQLiteHelper.rawInsert(
//                        "INSERT INTO sensorData( data, sensorId, characteristic) VALUES (?, ?, ?)",
//                        [
//                          sensorData,
//                          _characteristic.deviceId.toString(),
//                          _characteristic.uuid.toString(),
//                        ]);
                  });
                  FlutterBlue.instance
                      .startScan(timeout: Duration(milliseconds: 50));
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      device.connect();
                      return DeviceScreen(device: device);
                    }),
                  );
                },
                child: Text('No'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 2)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Select the device assigned to you',
                  textAlign: TextAlign.left,
                ),
              ),
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return RaisedButton(
                                    child: Text('Disconnect'),
                                    onPressed: () async {
                                      await d.disconnect();
                                      FlutterBlue.instance.startScan(
                                          timeout: Duration(milliseconds: 50));
//                                      Navigator.of(context).push(
//                                          MaterialPageRoute(
//                                              builder: (context) =>
//                                                  DeviceScreen(device: d)));
                                    },
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data.map((r) {
                    if (!filterDevices) {
                      if (filterUnnamedDevices) {
                        if ("" != r.device.name)
                          return ScanResultTile(
                            result: r,
                            onTap: () {
                              print("Device ID: ${r.device.id}");
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  r.device.connect();
                                  return DeviceScreen(device: r.device);
                                }),
                              );
                            },
                          );
                        else
                          return SizedBox.shrink();
                      } else
                        return ScanResultTile(
                          result: r,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                r.device.connect();
                                return DeviceScreen(device: r.device);
                              }),
                            );
                          },
                        );
                    }
                    IMoveDevice _tempDevice;
                    devices.forEach(
                      (iMoveDevice) {
                        if (iMoveDevice.deviceID == r.device.id.id) {
                          {
                            _tempDevice = iMoveDevice;
                          }
                        }
                      },
                    );
                    if (null == _tempDevice) {
                      return SizedBox.shrink();
                    } else {
                      return ScanResultTile(
                        result: r,
                        onTap: () {
                          _defaultDeviceDialog(context, r.device, _tempDevice);
                        },
                      );
                    }
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
