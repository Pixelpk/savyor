import 'package:dio/dio.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/data/models/user.dart';

import '../../../../application/core/exception/exception.dart';
import '../../../../application/network/client/iApService.dart';
import '../../../../application/network/error_handler/error_handler.dart';
import '../../../../common/logger/log.dart';
import 'i_login_api.dart';

class LoginApi implements ILoginApi {
  LoginApi(IApiService api) : dio = api.get();
  Dio dio;

  @override
  Future<User> login(Map<String, dynamic> data) async {
    try {
      final responseData = await dio.post("/api/user/login", data: data);
      return User.fromJson(responseData.data);
    } on DioError catch (e) {
      d(e);
      final exception = getException(e);
      throw exception;
    } catch (e, t) {
      d(e);
      throw ResponseException(msg: e.toString());
    }
  }

  @override
  Future<ServerResponse> forgotPassword(String email) async {
    try {
      final responseData = await dio.put("/api/password/reset", data: {"username": email});
      return ServerResponse.fromJson(responseData.data);
    } on DioError catch (e) {

      final exception = getException(e);
      throw exception;
    } catch (e, t) {
      d(e);
      throw ResponseException(msg: e.toString());
    }
  }
}
