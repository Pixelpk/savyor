import 'package:dio/dio.dart';
import 'package:savyor/data/models/user.dart';

import '../../../../application/core/exception/exception.dart';
import '../../../../application/network/client/iApService.dart';
import '../../../../application/network/error_handler/error_handler.dart';
import '../../../../common/logger/log.dart';
import 'i_register_api.dart';

class RegisterApi implements IRegisterApi {
  RegisterApi(IApiService api) : dio = api.get();
  Dio dio;

  @override
  Future<User> register(FormData data) async {
    try {
      d("RES${data.fields}");
      d("RES${data.files}");
      dio.options.headers.clear();
      final responseData = await dio.post("/api/user/create", data: data);
      d("RESPOMS${responseData.data}");
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
}
