import '../../models/models.dart';
import 'package:dio/dio.dart';
import './dioInstance.dart';
import '../../utils/utils.dart';
import '../../providers/providers.dart';

class API {
  final Dio _dioinstance = DioInstance().construct;

  DIOResponseBody errorHelper(error) {
    if (error.response.isEmpty) {
      return DIOResponseBody(success: false, data: "Network Error");
    }
    return DIOResponseBody(
        success: false, data: error.response.data['message']);
  }

  Future<DIOResponseBody> userLogin(details) async {
    return _dioinstance.post('user/login', data: details).then((respone) {
      return DIOResponseBody(
          success: true, data: respone.data['data']['accessToken']);
    }).catchError((error) {
      if (error == null) {
        return DIOResponseBody(success: false, data: 'Network Error');
      }
      print(error);
      logger.e(error.type);
      if (error.response == null) {
        return DIOResponseBody(
            success: false, data: 'Connection to Backend Failed');
      }
      return DIOResponseBody(
          success: false, data: error.response.data['message']);
    });
  }

  Future<bool> accessTokenLogin(accessToken) async {
    return _dioinstance
        .post('user/accessTokenLogin',
            options:
                Options(headers: {'authorization': 'Bearer ' + accessToken}))
        .then((response) {
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> registerUser(userDetails) async {
    return _dioinstance
        .post('user/register', data: userDetails)
        .then((response) {
      return true;
    }).catchError((error) {
      print(error.response);
      return false;
    });
  }

  Future<DIOResponseBody> sendWeatherPredicationData(
      {latitude, longitude}) async {
    return _dioinstance
        .post('user/weather',
            data: {'lat': latitude, 'lon': longitude},
            options: Options(headers: {
              'authorization': 'Bearer ' + UserDataProvider().accessToken
            }))
        .then((response) {
      return DIOResponseBody(success: true, data: response);
    }).catchError((error) {
      print(error.toString());
      return null;
    });
  }
}
