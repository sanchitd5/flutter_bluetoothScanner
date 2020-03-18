import '../../utils/utils.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';


class AndroidChannel {
  static final MethodChannel _channel =
      const MethodChannel('com.sanchitdang.channels');

  static dynamic getLastLocation() async {
    var permission = await Location().hasPermission();
    if (permission == PermissionStatus.GRANTED) {
      try {
        String result = await _channel.invokeMethod('getLastLocation');
        logger.d(result.toString());
        return result;
      } on PlatformException catch (e) {
        logger.e(e.message);
      }
      return null;
    }
    await Location().requestPermission();
    logger.e("GIVE LOCATION PERMISSION!");
  }

  static void logSensorData() async{
    try {
      String result =
      await _channel.invokeMethod('logSensorData');
      logger.i(result.toString());
    } on PlatformException catch (e) {
      logger.e(e.message.toString());
    }
  }

  static void logAccessToken() async {
    try {
      String result =
          await _channel.invokeMethod('logAccessTokenFromSharedPrefs');
      logger.i(result.toString());
    } on PlatformException catch (e) {
      logger.e(e.message.toString());
    }
  }

  static void logInternetConnectivity() async {
    try {
      String result = await _channel.invokeMethod('checkInternetConnection');
      logger.i(result.toString());
    } on PlatformException catch (e) {
      logger.e(e.message.toString());
    }
  }

  static void startAlarmManager() async {
    logger.i("inside function start alarm manager");
    try {
      String result = await _channel.invokeMethod('triggerAlarmManager');
      logger.i(result.toString());
    } on PlatformException catch (e) {
      debugPrint(e.details);
      logger.e("found platform exception");
      logger.e(e.message.toString());
    }
  }
}
