import 'package:flutter/foundation.dart';

class IMoveDevice {
  String name;
  String deviceID;
  String serviceID;
  String characteristicID;

  IMoveDevice(
      {@required this.deviceID,
      @required this.characteristicID,
      @required this.serviceID,
      this.name});
}

class SensorDataType1 {
  static final int initialTime = DateTime.now().millisecond;
  int time;
  double angle;

  SensorDataType1({this.angle}) {
    this.time = (initialTime - DateTime.now().millisecond) * 24 * 3600;
  }
}

class SensorDataType2 {
  static final int initialTime = DateTime.now().millisecond;
  int time;
  double magX;
  double magY;
  double magZ;
  double accelX;
  double accelY;
  double accelZ;
  double gyroX;
  double gyroY;
  double gyroZ;

  SensorDataType2(
      int val1,
      int val2,
      int val3,
      int val4,
      int val5,
      int val6,
      int val7,
      int val8,
      int val9,
      int val10,
      int val11,
      int val12,
      int val13,
      int val14,
      int val15,
      int val16,
      int val17,
      int val18) {
    this.time = (initialTime - DateTime.now().millisecond) * 24 * 3600;
    this.magX = (val1 * 256 + val2 - 4000).toDouble();
    this.magY = (val3 * 256 * val4 - 4000).toDouble();
    this.magZ = (val5 * 256 + val6 - 4000).toDouble();
    this.accelX = (val7 * 256 + val8 - 4000) / 100.0;
    this.accelY = (val9 * 256 + val10 - 4000) / 100.0;
    this.accelZ = (val11 * 256 + val12 - 4000) / 100.0;
    this.gyroX = (val13 * 256 + val14 - 32000) / 16.0;
    this.gyroY = (val15 * 256 + val16 - 32000) / 16.0;
    this.gyroZ = (val17 * 256 + val18 - 32000) / 16.0;
  }

  Map<String, dynamic> getAllData() {
    return {
      "time": this.time,
      "magX": magX,
      "magY": magY,
      "magZ": magZ,
      "accelX": accelX,
      "accelY": accelY,
      "accelZ": accelZ,
      "gyroX": gyroX,
      "gyroY": gyroY,
      "gyroZ": gyroZ
    };
  }
}

class SensorDataType3 {
  static final int initialTime = DateTime.now().millisecond;
  int time;

  double magX;
  double magY;
  double magZ;
  double accelX;
  double accelY;
  double accelZ;
  double gyroX;
  double gyroY;
  double gyroZ;
  double angle;

  SensorDataType3(
      int val1,
      int val2,
      int val3,
      int val4,
      int val5,
      int val6,
      int val7,
      int val8,
      int val9,
      int val10,
      int val11,
      int val12,
      int val13,
      int val14,
      int val15,
      int val16,
      int val17,
      int val18,
      int val19) {
    this.time = (initialTime - DateTime.now().millisecond);
    this.magX = (val1 * 256 + val2 - 4000).toDouble();
    this.magY = (val3 * 256 * val4 - 4000).toDouble();
    this.magZ = (val5 * 256 + val6 - 4000).toDouble();
    this.accelX = (val7 * 256 + val8 - 4000) / 100.0;
    this.accelY = (val9 * 256 + val10 - 4000) / 100.0;
    this.accelZ = (val11 * 256 + val12 - 4000) / 100.0;
    this.gyroX = (val13 * 256 + val14 - 32000) / 16.0;
    this.gyroY = (val15 * 256 + val16 - 32000) / 16.0;
    this.gyroZ = (val17 * 256 + val18 - 32000) / 16.0;
    this.angle = val19.toDouble();
  }

  Map<String, dynamic> getAllData() {
    return {
      "time": this.time,
      "magX": magX,
      "magY": magY,
      "magZ": magZ,
      "accelX": accelX,
      "accelY": accelY,
      "accelZ": accelZ,
      "gyroX": gyroX,
      "gyroY": gyroY,
      "gyroZ": gyroZ,
      "angle": angle
    };
  }
}
