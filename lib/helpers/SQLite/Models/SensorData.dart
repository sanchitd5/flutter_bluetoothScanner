import 'dart:typed_data';

class SensorData {
  final int id;
  final String sensorID;
  final Uint8List data;
  final String timestamp = DateTime.now().toUtc().toString();

  SensorData({this.id, this.data, this.sensorID});

  Map<String, dynamic> toMap() =>
      {'id': id, 'sensorID': sensorID, 'data': data, 'timestamp': timestamp};
}
