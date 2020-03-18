import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import '../../utils/utils.dart';

class IMoveBLEHelper {
  static Future<bool> attachListenerToDevice(BluetoothDevice device,
      String serviceID, String characteristicID, Function onListen) async {
    try {
      await device.connect(autoConnect: true);
    } on PlatformException catch (e) {
      logger.e(e.message);
    }
    List<BluetoothService> services = await device.discoverServices();
    BluetoothService selectedService;
    services.forEach((service) {
      if (serviceID == service.uuid.toString()) {
        selectedService = service;
      }
    });
    if (null == selectedService) {
      logger.e("Provided service with $serviceID not found.");
      return false;
    } else {
      for (BluetoothCharacteristic _characteristic
          in selectedService.characteristics) {
        if (_characteristic.uuid.toString() == characteristicID) {
          _characteristic.value.listen((List<int> sensorData) async {
            if (null != sensorData) if (null != onListen)
              onListen(sensorData, _characteristic);
          });
          _characteristic.setNotifyValue(!_characteristic.isNotifying);
          return true;
        }
      }
      logger.e("Provided characteristic with $characteristicID not found.");
      return false;
    }
  }
}
