import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';

import '../utils.dart';

class AlarmManagerModel {
  final String name;
  final Function function;
  final Duration interval;

  AlarmManagerModel(
      {@required this.name, @required this.function, @required this.interval});
}

class AlarmManagerBootstrapper {
  static int counter = 0;
  static List<AlarmManagerModel> services = [];

  static void bootstrap() async {
    logger.i('Bootstrapping Alarm Manager');
    await AndroidAlarmManager.initialize();
    services.forEach((f) async {
      bool status =
          await AndroidAlarmManager.periodic(f.interval, counter, f.function);
      if (status) {
        logger.i('${f.name} Started in Alarm Manager');
        counter = counter + 1;
      } else {
        logger.e('Error Starting Alarm Manager Service');
      }
    });
  }

  static void addService(AlarmManagerModel service) async {
    services.add(service);
    await AndroidAlarmManager.periodic(
        service.interval, counter, service.function);
    counter = counter + 1;
    logger.i(
        '${service.name} has been pushed to isolate queue and ID: ${counter.toString()} has been assigned to it.');
  }

  static void cancelAllServicesInQueue() async {
    for (var i = 0; i < services.length; i++) {
      await AndroidAlarmManager.cancel(i);
    }
    logger.i('Cenceled All the Services Successfully');
  }

  static void cancelServiceByName(String name) async {
    int id;
    for (var i = 0; i < services.length; i++) {
      if (services[i].name == name) {
        id = i;
        break;
      }
    }
    await AndroidAlarmManager.cancel(id);
    logger.i(
        'Service $name with ID: ${id.toString()} has been removed to isolate queue and  has been assigned to it.');
  }
}
