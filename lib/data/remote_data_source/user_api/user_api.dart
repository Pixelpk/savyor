import 'package:dio/dio.dart';
import 'package:savyor/data/models/UserProfileImage.dart';
import 'package:savyor/data/models/supported_store.dart';
import 'package:savyor/data/models/track_product.dart';
import 'package:savyor/data/models/user.dart';

import '../../../../application/core/exception/exception.dart';
import '../../../../application/network/client/iApService.dart';
import '../../../../application/network/error_handler/error_handler.dart';
import '../../../../common/logger/log.dart';
import 'i_user_api.dart';

class UserApi implements IUserApi {
  UserApi(IApiService api) {
    api.setIsTokenRequired(true);
    dio = api.get();
  }

  late Dio dio;

  @override
  Future<GetUserProfile> getUserProfile() async {
    try {
      final responseData = await dio.get("/api/user/profilePic");
      return GetUserProfile.fromJson(responseData.data);
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
  Future<ServerResponse> updateProfileImage(FormData formData) async {
    try {
      final responseData = await dio.put("/api/user/updateProfilePic", data: formData);
      return ServerResponse.fromJson(responseData.data);
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
  Future<ServerResponse> changePassword(Map<String, dynamic> data) async {
    try {
      final responseData = await dio.put("/api/password/change", data: data);
      return ServerResponse.fromJson(responseData.data);
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
