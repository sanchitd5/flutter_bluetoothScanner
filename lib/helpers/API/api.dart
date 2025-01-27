import '../../models/models.dart';
import 'package:dio/dio.dart';
import './dioInstance.dart';
import '../../utils/utils.dart';
import '../../providers/providers.dart';

class API {
  final Dio _dioInstance = DioInstance().construct;

  DIOResponseBody errorHelper(error) {
    if (error.response.isEmpty) {
      return DIOResponseBody(success: false, data: "Network Error");
    }
    return DIOResponseBody(
        success: false, data: error.response.data['message']);
  }

  Future<DIOResponseBody> userLogin(details) async {
    return _dioInstance.post('user/login', data: details).then((respone) {
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

  Future<bool> accessTokenLogin(accessToken, body) async {
    return _dioInstance
        .post('user/accessTokenLogin',
            data: body,
            options:
                Options(headers: {'authorization': 'Bearer ' + accessToken}))
        .then((response) {
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> registerUser(userDetails) async {
    return _dioInstance
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
    return _dioInstance
        .post('user/weather',
            data: {'lat': latitude, 'lon': longitude},
            options: Options(headers: {
              'authorization': 'Bearer ' + await UserDataProvider().accessToken
            }))
        .then((response) {
      return DIOResponseBody(success: true, data: response);
    }).catchError((error) {
      print(error.toString());
      return null;
    });
  }

  Future<DIOResponseBody> createExtenderProfile(Map userData) async {
    print(UserDataProvider().accessToken);
    print(userData);
    return _dioInstance
        .post("/user/createExtendedProfile",
            data: userData,
            options: Options(headers: {
              'authorization': 'Bearer ' + await UserDataProvider().accessToken
            }))
        .then((response) {
      return DIOResponseBody(success: true, data: response);
    }).catchError((error) {
      logger.e(error.toString());
      return null;
    });
  }
}
