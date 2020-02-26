import 'package:dio/dio.dart';

import '../../configurations/configurations.dart';
import '../../utils/utils.dart';

class DioInstance {
  final Dio _instance = new Dio();
  final String _backendUrl = Configurations().backendUrl;

  DioInstance() {
    _instance.options.baseUrl = _backendUrl;
    logger
        .i('DIO instance Constructed\nBackend Url: ' + _backendUrl.toString());
    _instance.options.connectTimeout = 5000;
    _instance.options.receiveTimeout = 3000;
  }

  Dio get construct {
    return _instance;
  }
}
